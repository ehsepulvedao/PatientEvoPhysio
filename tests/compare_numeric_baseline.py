#!/usr/bin/env python3
"""Verify that executable numeric literals match the audited v2 baseline."""
from __future__ import annotations
import re
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
BASELINE = ROOT / "tests" / "numeric_baseline.txt"
NEW = ROOT / "PatientEvoPhysio.mo"

def code_only(text: str) -> str:
    out=[]; i=0; state='code'
    while i < len(text):
        c=text[i]
        if state=='code':
            if text.startswith('//',i): state='line'; out.extend('  '); i+=2; continue
            if text.startswith('/*',i): state='block'; out.extend('  '); i+=2; continue
            if c=='"': state='string'; out.append(' '); i+=1; continue
            out.append(c); i+=1; continue
        if state=='string':
            if c=='\\' and i+1<len(text): out.extend('  '); i+=2; continue
            if c=='"': state='code'
            out.append('\n' if c=='\n' else ' '); i+=1; continue
        if state=='line':
            if c=='\n': state='code'; out.append('\n')
            else: out.append(' ')
            i+=1; continue
        if state=='block':
            if text.startswith('*/',i): state='code'; out.extend('  '); i+=2; continue
            out.append('\n' if c=='\n' else ' '); i+=1
    return ''.join(out)

num_re = re.compile(r'(?<![A-Za-z_])(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?')
a = [x.strip() for x in BASELINE.read_text(encoding='utf-8').splitlines() if x.strip()]
b = num_re.findall(code_only(NEW.read_text(encoding='utf-8')))
if a != b:
    for i, pair in enumerate(zip(a, b)):
        if pair[0] != pair[1]:
            raise SystemExit(f"[FAIL] Numeric literal mismatch at token {i}: {pair[0]} != {pair[1]}")
    raise SystemExit(f"[FAIL] Numeric literal counts differ: {len(a)} != {len(b)}")
print(f"[PASS] Numeric baseline preserved: {len(a)} executable numeric literals")
