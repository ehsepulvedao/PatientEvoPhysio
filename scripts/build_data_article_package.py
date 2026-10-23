#!/usr/bin/env python3
"""Build a journal-agnostic data-article submission support package."""
from __future__ import annotations
import argparse,shutil,subprocess,sys
from datetime import datetime,timezone
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
ap=argparse.ArgumentParser(); ap.add_argument('--include-data',action='store_true'); a=ap.parse_args()
cmd=[sys.executable,str(ROOT/'scripts'/'build_dataset_release.py'),'--name','PatientEvoPhysio_synthetic_cardiorespiratory_data','--zip']
if a.include_data: cmd.append('--include-data')
subprocess.run(cmd,cwd=ROOT,check=True)
stamp=datetime.now(timezone.utc).strftime('%Y%m%d'); out=ROOT/'release'/f'data_article_submission_{stamp}'
if out.exists():shutil.rmtree(out)
out.mkdir(parents=True)
shutil.copytree(ROOT/'docs'/'data_in_brief',out/'manuscript_materials')
for f in ['CITATION.cff','AUTHORS.md','LICENSE','VERSION','README.md']:
 if (ROOT/f).exists(): shutil.copy2(ROOT/f,out/f)
(out/'SUBMISSION_INVENTORY.txt').write_text('''PatientEvoPhysio data-article support package\n\nmanuscript_materials/  Draft/template/checklists\n../PatientEvoPhysio_synthetic_cardiorespiratory_data_<date>/  Dataset release directory\n../PatientEvoPhysio_synthetic_cardiorespiratory_data_<date>.zip  Upload-ready dataset archive when built with data\n\nBefore submission, confirm journal scope, replace all [TO COMPLETE] placeholders, deposit the final dataset in a repository with a persistent identifier, and insert the final DOI/URL.\n''',encoding='utf-8')
print('[OK]',out)
