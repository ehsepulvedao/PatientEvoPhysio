#!/usr/bin/env python3
"""Static source audit for PatientEvoPhysio v2.

This test does not replace OpenModelica compilation. It catches accidental
source corruption, missing scenarios, dependency drift and reintroduction of
selected legacy identifiers.
"""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MODEL = ROOT / "PatientEvoPhysio.mo"
CONFIG = ROOT / "config" / "scenarios.json"


def code_only(text: str) -> str:
    out = []
    i = 0
    state = "code"
    while i < len(text):
        c = text[i]
        if state == "code":
            if text.startswith("//", i):
                state = "line_comment"; out.extend("  "); i += 2; continue
            if text.startswith("/*", i):
                state = "block_comment"; out.extend("  "); i += 2; continue
            if c == '"':
                state = "string"; out.append(" "); i += 1; continue
            out.append(c); i += 1; continue
        if state == "string":
            if c == "\\" and i + 1 < len(text):
                out.extend("  "); i += 2; continue
            if c == '"':
                state = "code"
            out.append("\n" if c == "\n" else " "); i += 1; continue
        if state == "line_comment":
            if c == "\n":
                state = "code"; out.append("\n")
            else:
                out.append(" ")
            i += 1; continue
        if state == "block_comment":
            if text.startswith("*/", i):
                state = "code"; out.extend("  "); i += 2; continue
            out.append("\n" if c == "\n" else " "); i += 1
    return "".join(out)


def fail(msg: str) -> None:
    print("[FAIL]", msg)
    raise SystemExit(1)


def main() -> int:
    raw = MODEL.read_text(encoding="utf-8")
    code = code_only(raw)

    if not raw.rstrip().endswith("end PatientEvoPhysio;"):
        fail("Top-level package terminator missing")

    for left, right in [("(", ")"), ("{", "}")]:
        if code.count(left) != code.count(right):
            fail(f"Unbalanced delimiters: {left}{right}")

    required = [
        "version = \"2.0.0\"",
        'Modelica(version = "3.2.3")',
        'Physiolibrary(version = "2.3.1")',
        "model FetalToNeonatal_Transition",
        "model Constant_Elastance",
        "stream Types.Concentration conc",
        "type MolarFlow = Modelica.SIunits.MolarFlowRate",
    ]
    for needle in required:
        if needle not in raw:
            fail(f"Required source marker missing: {needle}")

    banned_identifiers = {
        "Ventriculo_Izquierdo", "Ventriculo_Derecho", "Auricula_Derecha",
        "Auricula_izquierda", "Valvula_Aortica", "Valvula_Mitral",
        "Valvula_Tricuspide", "Valvula_pulmonar", "R_Arterias_Pulmonares",
        "Consumo", "Saturacion", "presion", "flujo", "Fetus2neonate_transition",
    }
    tokens = set(re.findall(r"\b[A-Za-z_]\w*\b", code))
    present = sorted(banned_identifiers & tokens)
    if present:
        fail("Legacy identifiers remain in executable code: " + ", ".join(present))

    cfg = json.loads(CONFIG.read_text(encoding="utf-8"))
    expected_ids = {
        "adult_healthy", "child_healthy", "child_stenosis", "neonate_healthy",
        "neonate_stenosis", "neonate_coarctation", "neonate_tof", "neonate_tga",
        "neonate_pda", "fetal_to_neonatal_transition",
    }
    if set(cfg["scenarios"]) != expected_ids:
        fail("Scenario config IDs differ from the expected canonical set")

    model_paths = [v["model"] for v in cfg["scenarios"].values()]
    if len(model_paths) != len(set(model_paths)):
        fail("Duplicate Modelica paths in scenario config")

    print("[PASS] Static audit completed")
    print(f"       source bytes: {MODEL.stat().st_size}")
    print(f"       scenario IDs: {len(expected_ids)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
