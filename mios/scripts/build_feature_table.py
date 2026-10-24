#!/usr/bin/env python3
"""Build a compact scenario-labelled feature table from scientific summaries."""
import csv,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
out=ROOT/'data'/'analysis'/'diagnosis_feature_table.csv'; out.parent.mkdir(parents=True,exist_ok=True)
records=[]
for p in sorted((ROOT/'data'/'generated').rglob('scientific_summary.json')):
    d=json.loads(p.read_text(encoding='utf-8')); rel=p.relative_to(ROOT/'data'/'generated').parts
    scenario=rel[-3] if len(rel)>=3 and rel[-2]=='report' else rel[-2] if len(rel)>=2 else 'unknown'
    profile=rel[-4] if len(rel)>=4 and rel[0]=='profiles' else ''
    rec={'profile':profile,'scenario_id':scenario,'csv':d.get('csv'),'heart_rate_observed_bpm':d.get('heart_rate_observed_bpm')}
    for k,s in d.get('metrics',{}).items():
        if s:
            rec[k+'.min']=s.get('min'); rec[k+'.max']=s.get('max'); rec[k+'.mean']=s.get('mean')
    records.append(rec)
if not records: raise SystemExit('No scientific_summary.json files found; run reports first.')
fields=[]
for r in records:
    for k in r:
        if k not in fields: fields.append(k)
with out.open('w',encoding='utf-8',newline='') as f:
    w=csv.DictWriter(f,fieldnames=fields); w.writeheader(); w.writerows(records)
print('[OK]',out)
