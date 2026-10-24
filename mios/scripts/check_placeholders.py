#!/usr/bin/env python3
"""Report unresolved publication placeholders before repository/data release."""
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]; scan=[ROOT/'docs'/'data_in_brief',ROOT/'release']
hits=[]
for base in scan:
 if not base.exists():continue
 for p in base.rglob('*'):
  if p.is_file() and p.suffix.lower() in {'.md','.txt','.json','.csv'}:
   try:s=p.read_text(encoding='utf-8')
   except:continue
   for i,line in enumerate(s.splitlines(),1):
    if '[TO COMPLETE]' in line or '[REPOSITORY' in line or '[DOI' in line: hits.append((p.relative_to(ROOT),i,line.strip()))
if hits:
 print(f'[INFO] {len(hits)} publication placeholders remain (expected before final submission):')
 for p,i,l in hits[:100]:print(f'  {p}:{i}: {l}')
else:print('[OK] No publication placeholders detected.')
