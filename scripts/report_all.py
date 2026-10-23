#!/usr/bin/env python3
"""Validate and generate scientific reports for all curated generated CSVs."""
from pathlib import Path
import subprocess, sys
ROOT=Path(__file__).resolve().parents[1]
files=sorted((ROOT/'data'/'generated').rglob('*_res.csv'))
if not files:
    print('[ERROR] No curated generated CSVs found.'); raise SystemExit(1)
review=0
for p in files:
    v=subprocess.run([sys.executable,str(ROOT/'scripts'/'validate_results.py'),str(p)])
    if v.returncode==2: review+=1
    elif v.returncode!=0: raise SystemExit(v.returncode)
    r=subprocess.run([sys.executable,str(ROOT/'scripts'/'scientific_report.py'),str(p)])
    if r.returncode: raise SystemExit(r.returncode)
print(f'[OK] Reports generated for {len(files)} CSVs; validation REVIEW={review}.')
raise SystemExit(0 if review==0 else 2)
