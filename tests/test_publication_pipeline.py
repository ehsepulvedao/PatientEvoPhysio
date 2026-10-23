#!/usr/bin/env python3
import csv,json,subprocess,sys,tempfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
# plans reference valid profiles/scenarios
sc=json.loads((ROOT/'config'/'scenarios.json').read_text(encoding='utf-8'))
pl=json.loads((ROOT/'config'/'experiment_plans.json').read_text(encoding='utf-8'))
for name,p in pl['plans'].items():
    assert p['profiles'], name
    for profile in p['profiles']: assert profile in sc['profiles'], (name,profile)
# publication groups are well formed
pv=json.loads((ROOT/'config'/'publication_variables.json').read_text(encoding='utf-8'))
assert 'hybrid_left_heart' in pv['groups'] and 'diagnosis_core' in pv['groups']
# generate a tiny artificial CSV to test report + hybrid label code
with tempfile.TemporaryDirectory() as td:
    td=Path(td); c=td/'tiny.csv'
    fields=['time','leftAtrium.pressure_mmHg','leftVentricle.pressure_mmHg','leftVentricle.volume','intrathoracicArteries.pressure_mmHg','intrathoracicArteries.oxygenSaturation','mitralValve.open','aorticValve.open']
    rows=[
      [0,9,8,4.8e-6,40,40,1,0],
      [0.1,9,20,4.7e-6,42,50,0,0],
      [0.2,9,60,3.0e-6,60,70,0,1],
      [0.3,9,15,2.0e-6,50,90,0,0],
      [0.4,9,7,4.5e-6,42,95,1,0],
      [0.5,9,8,4.8e-6,40,96,1,0],
    ]
    with c.open('w',encoding='utf-8',newline='') as f:
        w=csv.writer(f);w.writerow(fields);w.writerows(rows)
    cp=subprocess.run([sys.executable,str(ROOT/'scripts'/'scientific_report.py'),str(c)],capture_output=True,text=True)
    assert cp.returncode==0, cp.stderr+cp.stdout
    assert (td/'report'/'scientific_summary.json').exists()
    cp=subprocess.run([sys.executable,str(ROOT/'scripts'/'derive_hybrid_labels.py'),str(c)],capture_output=True,text=True)
    assert cp.returncode==0, cp.stderr+cp.stdout
    assert c.with_name('tiny.hybrid.csv').exists()
print('[PASS] Publication pipeline configuration and helper tests')
