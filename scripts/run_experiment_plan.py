#!/usr/bin/env python3
"""Run a named publication-oriented experiment plan and generate QC reports."""
from __future__ import annotations
import argparse,json,subprocess,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
plans=json.loads((ROOT/'config'/'experiment_plans.json').read_text(encoding='utf-8'))['plans']
ap=argparse.ArgumentParser(); ap.add_argument('plan',choices=sorted(plans)); ap.add_argument('--raw',action='store_true'); a=ap.parse_args()
review=0
for profile in plans[a.plan]['profiles']:
    cmd=[sys.executable,str(ROOT/'scripts'/'generate_csv.py'),'--profile',profile]
    if a.raw: cmd.append('--raw')
    print('[RUN]',profile); cp=subprocess.run(cmd,cwd=ROOT)
    if cp.returncode: raise SystemExit(cp.returncode)
    base=ROOT/'data'/'generated'/'profiles'/profile
    for csvp in sorted(base.rglob('*_res.csv')):
        for script in ('validate_results.py','scientific_report.py'):
            cp=subprocess.run([sys.executable,str(ROOT/'scripts'/script),str(csvp)],cwd=ROOT)
            if cp.returncode==2: review+=1
            elif cp.returncode!=0: raise SystemExit(cp.returncode)
print(f'[OK] Experiment plan completed: {a.plan}; REVIEW={review}')
raise SystemExit(0 if review==0 else 2)
