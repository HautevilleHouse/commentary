#!/usr/bin/env bash
# Reject JSON sha256 fields that are not exactly 64 lowercase hex characters.
# Prevents fat-finger digests (e.g. 65-char SHA-256) from entering commentary packets.
set -euo pipefail

root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$root"

python3 - <<'PY'
from __future__ import annotations

import json
import re
import subprocess
import sys
from pathlib import Path

SHA256_RE = re.compile(r"^[0-9a-f]{64}$")
HEXISH_RE = re.compile(r"^[0-9a-fA-F]+$")


def iter_json_files() -> list[Path]:
    try:
        out = subprocess.check_output(
            ["git", "ls-files", "*.json"],
            text=True,
        )
        return [Path(line) for line in out.splitlines() if line.strip()]
    except subprocess.CalledProcessError:
        return list(Path(".").rglob("*.json"))


def walk(value, path: str, errors: list[str]) -> None:
    if isinstance(value, dict):
        for key, child in value.items():
            child_path = f"{path}.{key}" if path else key
            if isinstance(child, str) and "sha256" in key.lower():
                if not SHA256_RE.fullmatch(child):
                    detail = f"length {len(child)}"
                    if HEXISH_RE.fullmatch(child):
                        detail += " hex digits"
                    errors.append(f"{child_path}: expected lowercase hex SHA-256 of exactly 64 characters ({detail})")
            else:
                walk(child, child_path, errors)
    elif isinstance(value, list):
        for index, child in enumerate(value):
            walk(child, f"{path}[{index}]", errors)


errors: list[str] = []
for path in iter_json_files():
    try:
        payload = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, json.JSONDecodeError):
        continue
    local: list[str] = []
    walk(payload, "", local)
    for item in local:
        errors.append(f"{path}: {item}")

if errors:
    print("REFUSING PUBLISH: malformed SHA-256 field(s) found", file=sys.stderr)
    for item in errors:
        print(item, file=sys.stderr)
    raise SystemExit(1)
print("sha256-format clean")
PY
