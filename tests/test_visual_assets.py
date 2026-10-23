from pathlib import Path
import re
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
MO = ROOT / "PatientEvoPhysio.mo"
text = MO.read_text(encoding="utf-8")

assert "imageSource = \"iVBOR" not in text, "Embedded PNG payload remains in PatientEvoPhysio.mo"

refs = re.findall(r'fileName\s*=\s*"modelica://PatientEvoPhysio/([^\"]+)"', text)
assert refs, "No modelica://PatientEvoPhysio resource references found"

active_icon_dir = ROOT / "Resources" / "Images" / "icon"
active_pngs = sorted(active_icon_dir.glob("*.png"))
assert not active_pngs, f"Active icon folder must be SVG-only; found: {[p.name for p in active_pngs]}"

active_svg_refs = 0
for rel in refs:
    path = ROOT / rel
    assert path.is_file(), f"Missing visual resource: {rel}"
    if path.suffix.lower() == ".svg":
        root = ET.parse(path).getroot()
        assert root.tag.endswith("svg"), f"Invalid SVG root: {rel}"
        if "Resources/Images/icon/" in rel.replace("\\", "/"):
            active_svg_refs += 1
            assert path.suffix.lower() == ".svg"

assert active_svg_refs == 26, f"Expected 26 active SVG icon references, found {active_svg_refs}"
print(f"[PASS] Visual assets: {len(refs)} portable references validated; {active_svg_refs} active icons are SVG-only")
