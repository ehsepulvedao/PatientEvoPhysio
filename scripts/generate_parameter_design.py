#!/usr/bin/env python3
"""Generate a reproducible Latin-hypercube virtual-patient parameter design.

Physiological ranges are NEVER invented by this script. The user must provide
an enabled parameter-space CSV with literature-supported bounds.
"""
from __future__ import annotations
import argparse,csv,json,math,random
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def public_path(p:Path):
    try:return p.resolve().relative_to(ROOT.resolve()).as_posix()
    except (ValueError,OSError):return p.name
ap=argparse.ArgumentParser(); ap.add_argument('parameter_space',type=Path); ap.add_argument('--n',type=int,required=True); ap.add_argument('--seed',type=int,default=20261023); ap.add_argument('--output',type=Path,default=Path('config/virtual_population.csv')); a=ap.parse_args()
if a.n<1: raise SystemExit('--n must be >=1')
rows=[]
with a.parameter_space.open('r',encoding='utf-8-sig',newline='') as f:
    r=csv.DictReader(f)
    for x in r:
        if x.get('enabled','').strip().lower()!='true': continue
        try: lo=float(x['min']); hi=float(x['max'])
        except Exception: raise SystemExit(f'Enabled row lacks numeric min/max: {x}')
        if not hi>lo: raise SystemExit(f'Expected max>min: {x}')
        if x.get('scale','linear') not in ('linear','log'): raise SystemExit(f'Unsupported scale: {x}')
        rows.append((x['scenario_id'].strip(),x['parameter'].strip(),lo,hi,x.get('scale','linear')))
if not rows: raise SystemExit('No enabled parameter ranges. Edit a COPY of config/parameter_space.template.csv using literature-supported bounds.')
scenarios={r[0] for r in rows}
if len(scenarios)!=1: raise SystemExit('One parameter-space file must currently describe one scenario_id.')
rng=random.Random(a.seed); strata={}
for _,param,lo,hi,scale in rows:
    vals=[]
    for i in range(a.n):
        u=(i+rng.random())/a.n
        if scale=='log': vals.append(math.exp(math.log(lo)+u*(math.log(hi)-math.log(lo))))
        else: vals.append(lo+u*(hi-lo))
    rng.shuffle(vals); strata[param]=vals
out=a.output; out.parent.mkdir(parents=True,exist_ok=True)
with out.open('w',encoding='utf-8',newline='') as f:
    w=csv.writer(f); w.writerow(['patient_id','scenario_id','parameter','value'])
    scenario=next(iter(scenarios))
    for i in range(a.n):
        pid=f'{scenario}_{i+1:06d}'
        for _,param,_,_,_ in rows: w.writerow([pid,scenario,param,format(strata[param][i],'.17g')])
meta={'schema_version':1,'method':'latin_hypercube','n_patients':a.n,'seed':a.seed,'parameter_space':public_path(a.parameter_space),'output':public_path(out),'parameters':[{'scenario_id':s,'parameter':p,'min':lo,'max':hi,'scale':sc} for s,p,lo,hi,sc in rows]}
out.with_suffix('.metadata.json').write_text(json.dumps(meta,indent=2),encoding='utf-8')
print('[OK]',out)
