#!/usr/bin/env python3
"""Generate compact scientific summaries and SVG quality-control figures.

Uses only the Python standard library. The report is descriptive; thresholds
are not clinical decision limits.
"""
from __future__ import annotations
import argparse, csv, json, math, statistics
from pathlib import Path
from typing import Iterable

ROOT=Path(__file__).resolve().parents[1]

def fnum(v):
    try:
        x=float(v); return x if math.isfinite(x) else None
    except (TypeError,ValueError): return None

def read_csv(path:Path):
    with path.open('r',encoding='utf-8-sig',newline='') as f:
        r=csv.DictReader(f); fields=r.fieldnames or []; rows=list(r)
    return fields, rows

def series(rows,name):
    out=[]
    for r in rows:
        x=fnum(r.get(name,''))
        if x is not None: out.append(x)
    return out

def paired(rows,xname,yname):
    out=[]
    for r in rows:
        x=fnum(r.get(xname,'')); y=fnum(r.get(yname,''))
        if x is not None and y is not None: out.append((x,y))
    return out

def summary_stats(vals):
    if not vals: return None
    return {'min':min(vals),'max':max(vals),'mean':sum(vals)/len(vals),'n':len(vals)}

def rising_edges(rows,time_col,val_col):
    pts=[]; prev=0.0
    for r in rows:
        t=fnum(r.get(time_col,'')); v=fnum(r.get(val_col,''))
        if t is None or v is None: continue
        if v>=0.5 and prev<0.5: pts.append(t)
        prev=v
    return pts

def first_crossing(rows,time_col,val_col,threshold):
    for r in rows:
        t=fnum(r.get(time_col,'')); v=fnum(r.get(val_col,''))
        if t is not None and v is not None and v>=threshold: return t
    return None

def svg_line(path:Path, points, title, xlabel, ylabel, width=1000, height=520):
    if len(points)<2: return False
    # downsample for lightweight SVG
    if len(points)>1800:
        step=max(1,len(points)//1800); points=points[::step]
    xs=[p[0] for p in points]; ys=[p[1] for p in points]
    xmin,xmax=min(xs),max(xs); ymin,ymax=min(ys),max(ys)
    if xmax==xmin: xmax=xmin+1
    if ymax==ymin: ymax=ymin+1
    ml,mr,mt,mb=85,25,55,65
    pw,ph=width-ml-mr,height-mt-mb
    def X(x): return ml+(x-xmin)/(xmax-xmin)*pw
    def Y(y): return mt+ph-(y-ymin)/(ymax-ymin)*ph
    poly=' '.join(f'{X(x):.2f},{Y(y):.2f}' for x,y in points)
    lines=[f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" viewBox="0 0 {width} {height}">',
           '<rect width="100%" height="100%" fill="white"/>',
           f'<text x="{width/2}" y="30" text-anchor="middle" font-family="Arial" font-size="20">{title}</text>']
    for i in range(6):
        yy=mt+i*ph/5; val=ymax-i*(ymax-ymin)/5
        lines += [f'<line x1="{ml}" y1="{yy:.2f}" x2="{width-mr}" y2="{yy:.2f}" stroke="#dddddd"/>',
                  f'<text x="{ml-10}" y="{yy+5:.2f}" text-anchor="end" font-family="Arial" font-size="12">{val:.4g}</text>']
    for i in range(6):
        xx=ml+i*pw/5; val=xmin+i*(xmax-xmin)/5
        lines += [f'<line x1="{xx:.2f}" y1="{mt}" x2="{xx:.2f}" y2="{mt+ph}" stroke="#eeeeee"/>',
                  f'<text x="{xx:.2f}" y="{mt+ph+22}" text-anchor="middle" font-family="Arial" font-size="12">{val:.4g}</text>']
    lines += [f'<polyline fill="none" stroke="black" stroke-width="1.5" points="{poly}"/>',
              f'<text x="{width/2}" y="{height-18}" text-anchor="middle" font-family="Arial" font-size="14">{xlabel}</text>',
              f'<text x="18" y="{height/2}" transform="rotate(-90 18 {height/2})" text-anchor="middle" font-family="Arial" font-size="14">{ylabel}</text>',
              '</svg>']
    path.write_text('\n'.join(lines),encoding='utf-8'); return True

def main():
    ap=argparse.ArgumentParser(description=__doc__); ap.add_argument('csv_file',type=Path); ap.add_argument('--output-dir',type=Path)
    a=ap.parse_args(); fields,rows=read_csv(a.csv_file)
    out=a.output_dir or a.csv_file.parent/'report'; out.mkdir(parents=True,exist_ok=True)
    tcol='time' if 'time' in fields else None
    times=series(rows,tcol) if tcol else []
    report={'schema_version':1,'csv':a.csv_file.name,'rows':len(rows),'variables':len(fields),'time':{'start':min(times) if times else None,'end':max(times) if times else None,'duration':(max(times)-min(times)) if times else None},'metrics':{},'valves':{},'oxygen':{},'figures':[]}
    keyvars=['leftAtrium.pressure_mmHg','leftVentricle.pressure_mmHg','leftVentricle.volume','rightAtrium.pressure_mmHg','rightVentricle.pressure_mmHg','rightVentricle.volume','intrathoracicArteries.pressure_mmHg','pulmonaryArteries.pressure_mmHg','pulmonaryArterialResistance.flow_L_per_min']
    for n in keyvars:
        if n in fields: report['metrics'][n]=summary_stats(series(rows,n))
    if tcol:
        for v in ['aorticValve.open','mitralValve.open','pulmonaryValve.open','tricuspidValve.open']:
            if v in fields:
                edges=rising_edges(rows,tcol,v); report['valves'][v]={'opening_count':len(edges),'opening_times_s':edges[:200]}
                if v=='aorticValve.open' and len(edges)>=3:
                    periods=[b-a for a,b in zip(edges[1:-1],edges[2:]) if b>a]
                    if periods:
                        med=statistics.median(periods); report['heart_rate_observed_bpm']=60.0/med
                        report['heart_period_median_s']=med
                        report['heart_period_cv']=statistics.pstdev(periods)/(sum(periods)/len(periods)) if len(periods)>1 else 0.0
        o='intrathoracicArteries.oxygenSaturation'
        if o in fields:
            vals=series(rows,o); report['oxygen'][o]={'initial':vals[0] if vals else None,'final':vals[-1] if vals else None,'min':min(vals) if vals else None,'max':max(vals) if vals else None,'time_to_90_s':first_crossing(rows,tcol,o,90.0),'time_to_95_s':first_crossing(rows,tcol,o,95.0)}
    figs=[]
    figspec=[('leftVentricle.pressure_mmHg','left_ventricle_pressure.svg','Left ventricular pressure','Time (s)','Pressure (mmHg)'),('intrathoracicArteries.pressure_mmHg','systemic_arterial_pressure.svg','Intrathoracic arterial pressure','Time (s)','Pressure (mmHg)'),('intrathoracicArteries.oxygenSaturation','arterial_oxygen_saturation.svg','Arterial oxygen saturation','Time (s)','Oxygen saturation (%)')]
    if tcol:
        for col,fn,title,xl,yl in figspec:
            if col in fields and svg_line(out/fn,paired(rows,tcol,col),title,xl,yl): figs.append(fn)
    if 'leftVentricle.volume' in fields and 'leftVentricle.pressure_mmHg' in fields:
        pts=paired(rows,'leftVentricle.volume','leftVentricle.pressure_mmHg'); pts=[(v*1e6,p) for v,p in pts]
        if svg_line(out/'left_ventricle_pv_loop.svg',pts,'Left ventricular pressure-volume trajectory','Volume (mL)','Pressure (mmHg)'): figs.append('left_ventricle_pv_loop.svg')
    report['figures']=figs
    (out/'scientific_summary.json').write_text(json.dumps(report,indent=2),encoding='utf-8')
    # one-row CSV
    flat={'csv':a.csv_file.name,'rows':len(rows),'variables':len(fields),'duration_s':report['time']['duration'],'heart_rate_observed_bpm':report.get('heart_rate_observed_bpm')}
    for n,s in report['metrics'].items():
        if s: flat[n+'.min']=s['min']; flat[n+'.max']=s['max']; flat[n+'.mean']=s['mean']
    for n,s in report['oxygen'].items():
        for k,v in s.items(): flat[n+'.'+k]=v
    with (out/'scientific_summary.csv').open('w',encoding='utf-8',newline='') as f:
        w=csv.DictWriter(f,fieldnames=list(flat)); w.writeheader(); w.writerow(flat)
    md=['# Scientific run summary','',f'- Source: `{a.csv_file.name}`',f'- Rows: {len(rows)}',f'- Variables: {len(fields)}',f'- Duration: {report["time"]["duration"]} s']
    if 'heart_rate_observed_bpm' in report: md.append(f'- Observed heart rate: {report["heart_rate_observed_bpm"]:.3f} bpm')
    md += ['','## Key variables','', '| Variable | Min | Max | Mean |','|---|---:|---:|---:|']
    for n,s in report['metrics'].items():
        if s: md.append(f'| `{n}` | {s["min"]:.8g} | {s["max"]:.8g} | {s["mean"]:.8g} |')
    if report['oxygen']:
        md += ['','## Oxygen','']
        for n,s in report['oxygen'].items(): md.append(f'- `{n}`: initial={s["initial"]}, final={s["final"]}, t90={s["time_to_90_s"]}, t95={s["time_to_95_s"]}')
    md += ['','## Figures','']+[f'- `{x}`' for x in figs]
    md += ['','> Descriptive quality-control output only; not a clinical validation report.']
    (out/'scientific_summary.md').write_text('\n'.join(md)+'\n',encoding='utf-8')
    print(f'[OK] Scientific report: {out}')
    return 0
if __name__=='__main__': raise SystemExit(main())
