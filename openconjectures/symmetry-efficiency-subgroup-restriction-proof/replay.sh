#!/bin/sh
set -eu
cd "$(dirname "$0")"
python3 - <<'PY'
import json
from pathlib import Path

proof = Path("PROOF.md").read_text()
readme = Path("README.md").read_text()
identity = json.loads(Path("data/source_identity.json").read_text())
note = json.loads(Path("data/verification_note.json").read_text())
required = ("subgroup", "equivariant", "taking minima")
missing = [word for word in required if word.lower() not in proof.lower()]
assert not missing, f"proof missing required terms: {missing}"
assert "scope boundary" in readme.lower(), "README scope boundary missing"
assert identity and note, "source identity or verification note is empty"
print("RESULT: PASS (source identity, proof boundary, and verification note present)")
PY
