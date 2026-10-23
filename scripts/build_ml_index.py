#!/usr/bin/env python3
"""Build a time-series file index for diagnostic/AI experiments."""
import csv,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]; out=ROOT/'data'/'analysis'/'ml_timeseries_index.csv';out.parent.mkdir(parents=True,exist_ok=True)
rows=[]
for csvp in sorted((ROOT/'data'/'generated').rglob('*_res.csv')):
 mpath=csvp.parent/'metadata.json'
 if not mpath.exists():continue
 m=json.loads(mpath.read_text(encoding='utf-8'));run=m.get('run',{})
 rows.append({'scenario_id':run.get('scenario_id'),'profile':run.get('profile'),'model':run.get('model'),'start_time_s':run.get('start_time'),'stop_time_s':run.get('stop_time'),'csv':csvp.relative_to(ROOT).as_posix(),'metadata':mpath.relative_to(ROOT).as_posix(),'model_sha256':m.get('model_sha256')})
if not rows: raise SystemExit('No generated CSV files found.')
with out.open('w',encoding='utf-8',newline='') as f:w=csv.DictWriter(f,fieldnames=list(rows[0]));w.writeheader();w.writerows(rows)
print('[OK]',out)
