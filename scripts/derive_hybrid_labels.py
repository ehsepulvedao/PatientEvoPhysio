#!/usr/bin/env python3
"""Create an interpretable left-heart hybrid-mode dataset from a curated CSV."""
import argparse,csv
from pathlib import Path
ap=argparse.ArgumentParser(); ap.add_argument('csv_file',type=Path); ap.add_argument('--output',type=Path); a=ap.parse_args()
out=a.output or a.csv_file.with_name(a.csv_file.stem+'.hybrid.csv')
need=['time','leftAtrium.pressure_mmHg','leftVentricle.pressure_mmHg','leftVentricle.volume','intrathoracicArteries.pressure_mmHg','mitralValve.open','aorticValve.open']
with a.csv_file.open('r',encoding='utf-8-sig',newline='') as f: r=csv.DictReader(f); fields=r.fieldnames or []; rows=list(r)
missing=[x for x in need if x not in fields]
if missing: raise SystemExit('Missing required columns: '+', '.join(missing))
new=need+['left_cardiac_mode','dP_LV_dt_mmHg_per_s']
with out.open('w',encoding='utf-8',newline='') as f:
    w=csv.DictWriter(f,fieldnames=new); w.writeheader(); prev=None
    for row in rows:
        t=float(row['time']); p=float(row['leftVentricle.pressure_mmHg']); m=float(row['mitralValve.open'])>=0.5; av=float(row['aorticValve.open'])>=0.5
        dp=0.0 if prev is None or t==prev[0] else (p-prev[1])/(t-prev[0])
        if m and not av: mode='filling'
        elif av and not m: mode='ejection'
        elif not m and not av: mode='isovolumetric_contraction' if dp>=0 else 'isovolumetric_relaxation'
        else: mode='valve_overlap_review'
        rec={k:row[k] for k in need}; rec.update({'left_cardiac_mode':mode,'dP_LV_dt_mmHg_per_s':dp}); w.writerow(rec); prev=(t,p)
print('[OK]',out)
