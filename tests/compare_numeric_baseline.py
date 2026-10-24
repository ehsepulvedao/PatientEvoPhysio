#!/usr/bin/env python3
"""Verify non-annotation physiological numeric literals against the audited v2 baseline.

Graphical annotation numbers (icon extents, placements, rotations, etc.) are
intentionally excluded so visual maintenance cannot masquerade as a
physiological model change.
"""
from __future__ import annotations
import re
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
BASELINE=ROOT/'tests'/'physiology_numeric_baseline.txt'
NEW=ROOT/'PatientEvoPhysio.mo'

def code_without_annotations(text:str)->str:
    out=[];i=0;n=len(text)
    while i<n:
        if text.startswith('//',i):
            j=text.find('\n',i)
            if j<0:break
            out.append('\n');i=j+1;continue
        if text.startswith('/*',i):
            j=text.find('*/',i+2)
            if j<0:break
            out.append('\n'*text[i:j+2].count('\n'));i=j+2;continue
        if text[i]=='"':
            out.append(' ');i+=1
            while i<n:
                if text[i]=='\\' and i+1<n:i+=2;continue
                c=text[i];i+=1
                if c=='"':break
                out.append('\n' if c=='\n' else ' ')
            continue
        m=re.match(r'annotation\s*\(',text[i:])
        if m:
            i+=m.end();depth=1;state='code'
            while i<n and depth:
                if state=='code':
                    if text.startswith('//',i):state='line';i+=2;continue
                    if text.startswith('/*',i):state='block';i+=2;continue
                    if text[i]=='"':state='string';i+=1;continue
                    if text[i]=='(':depth+=1
                    elif text[i]==')':depth-=1
                    i+=1;continue
                if state=='string':
                    if text[i]=='\\' and i+1<n:i+=2;continue
                    if text[i]=='"':state='code'
                    i+=1;continue
                if state=='line':
                    if text[i]=='\n':state='code'
                    i+=1;continue
                if state=='block':
                    if text.startswith('*/',i):state='code';i+=2;continue
                    i+=1
            out.append(' ');continue
        out.append(text[i]);i+=1
    return ''.join(out)

num_re=re.compile(r'(?<![A-Za-z_])(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?')
a=[x.strip() for x in BASELINE.read_text(encoding='utf-8').splitlines() if x.strip()]
b=num_re.findall(code_without_annotations(NEW.read_text(encoding='utf-8')))
if a!=b:
    for i,pair in enumerate(zip(a,b)):
        if pair[0]!=pair[1]:raise SystemExit(f'[FAIL] Physiological numeric mismatch at token {i}: {pair[0]} != {pair[1]}')
    raise SystemExit(f'[FAIL] Physiological numeric counts differ: {len(a)} != {len(b)}')
print(f'[PASS] Physiological numeric baseline preserved: {len(a)} non-annotation executable numeric literals')
