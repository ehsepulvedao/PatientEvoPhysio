#!/usr/bin/env python3
"""Aggregate per-run validation, scientific summaries, provenance and checksums."""
from __future__ import annotations
import csv,hashlib,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
GEN=ROOT/'data'/'generated'; OUT=ROOT/'data'/'quality'; OUT.mkdir(parents=True,exist_ok=True)

def sha(p):
 h=hashlib.sha256();
 with p.open('rb') as f:
  for b in iter(lambda:f.read(1024*1024),b''): h.update(b)
 return h.hexdigest()
rows=[]; model_hashes=set(); omc_versions=set(); deps=set(); total_bytes=0
for csvp in sorted(GEN.rglob('*_res.csv')):
 run=csvp.parent; meta=run/'metadata.json'; val=csvp.with_suffix('.validation.json'); sci=run/'report'/'scientific_summary.json'
 m=json.loads(meta.read_text(encoding='utf-8')) if meta.exists() else {}
 v=json.loads(val.read_text(encoding='utf-8')) if val.exists() else {}
 s=json.loads(sci.read_text(encoding='utf-8')) if sci.exists() else {}
 rel=csvp.relative_to(ROOT).as_posix(); size=csvp.stat().st_size; total_bytes+=size
 mh=m.get('model_sha256'); ov=m.get('openmodelica'); dp=m.get('dependencies',{})
 if mh:model_hashes.add(mh)
 if ov:omc_versions.add(ov)
 if dp:deps.add(json.dumps(dp,sort_keys=True))
 rows.append({'csv':rel,'sha256':sha(csvp),'bytes':size,'status':v.get('status','MISSING'),'rows':v.get('rows'),'variables':v.get('variables'),'scenario_id':m.get('run',{}).get('scenario_id'),'profile':m.get('run',{}).get('profile'),'model':m.get('run',{}).get('model'),'duration_s':s.get('time',{}).get('duration'),'heart_rate_observed_bpm':s.get('heart_rate_observed_bpm'),'scientific_report':sci.relative_to(ROOT).as_posix() if sci.exists() else None,'metadata':meta.relative_to(ROOT).as_posix() if meta.exists() else None})
fields=list(rows[0]) if rows else []
if rows:
 with (OUT/'quality_summary.csv').open('w',encoding='utf-8',newline='') as f: w=csv.DictWriter(f,fieldnames=fields);w.writeheader();w.writerows(rows)
status={'schema_version':1,'generated_runs':len(rows),'pass_runs':sum(r['status']=='PASS' for r in rows),'review_runs':sum(r['status']=='REVIEW' for r in rows),'missing_validation_runs':sum(r['status']=='MISSING' for r in rows),'total_csv_bytes':total_bytes,'unique_model_hashes':sorted(model_hashes),'openmodelica_versions':sorted(omc_versions),'dependency_sets':[json.loads(x) for x in sorted(deps)],'all_runs_pass':bool(rows) and all(r['status']=='PASS' for r in rows),'model_hash_consistent':len(model_hashes)<=1}
(OUT/'quality_summary.json').write_text(json.dumps(status,indent=2),encoding='utf-8')
md=['# Dataset quality summary','',f'- Generated curated runs: {status["generated_runs"]}',f'- PASS: {status["pass_runs"]}',f'- REVIEW: {status["review_runs"]}',f'- Missing validation: {status["missing_validation_runs"]}',f'- Model hash consistent: {status["model_hash_consistent"]}',f'- Total curated CSV size: {status["total_csv_bytes"]} bytes','', '## Run inventory','', '| Profile | Scenario | Status | Rows | Variables |','|---|---|---:|---:|---:|']
for r in rows: md.append(f'| {r["profile"] or ""} | {r["scenario_id"] or ""} | {r["status"]} | {r["rows"] or ""} | {r["variables"] or ""} |')
md += ['','> PASS/REVIEW are engineering quality-control states, not clinical diagnostic labels.']
(OUT/'quality_report.md').write_text('\n'.join(md)+'\n',encoding='utf-8')
print('[OK]',OUT/'quality_report.md')
raise SystemExit(0 if status['all_runs_pass'] and status['model_hash_consistent'] else 2)
