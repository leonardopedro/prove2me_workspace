#!/usr/bin/env python3
"""Rename a trailing-prime declaration to the platform's `_prime` convention.

`submit-problem` rejects any `theorem_name` containing a prime
("theorem_name must be a valid Lean identifier (identifier segments separated
by '.')") — §6.1 of the runbook.  The generated stubs keep the source
declaration's name verbatim, so every primed node is a guaranteed rejection.

This rewrites the declaration in the stub *and* the `name` in the wave spec
together (they must agree: the thm splitter looks the name up in the file), and
only for stubs whose node is not published yet — a published node's name is what
the catalogue holds and must not drift.

Usage:
  python3 debug/fix_primed_names.py [--dry-run]
"""
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(WS, "pipeline"))

SPEC = os.path.join(WS, "pipeline", "wave_upload.json")


def main():
    dry = "--dry-run" in sys.argv
    spec = json.load(open(SPEC, encoding="utf-8"))
    state = json.load(open(os.path.join(WS, "state", "pipeline.json")))["items"]

    renamed, skipped = [], []
    for slug, meta in sorted(spec["thms"].items()):
        name = meta.get("name") or ""
        if not name.endswith("'"):
            continue
        if (state.get("thm:" + slug) or {}).get("status") == "done":
            skipped.append((slug, "already published"))
            continue
        path = os.path.join(WS, "Theorems", f"Thm_{slug}.lean")
        if not os.path.exists(path):
            skipped.append((slug, "no stub file in this checkout"))
            continue
        new_name = name.rstrip("'") + "_prime"
        txt = open(path, encoding="utf-8", errors="replace").read()
        pat = re.compile(r"(?m)^(theorem\s+)" + re.escape(name) + r"(?![A-Za-z0-9_'.!?])")
        if not pat.search(txt):
            skipped.append((slug, "declaration not found verbatim (reconcile handles it)"))
            continue
        new_txt = pat.sub(lambda m: m.group(1) + new_name, txt, count=1)
        if not dry:
            open(path, "w", encoding="utf-8").write(new_txt)
            spec["thms"][slug]["name"] = new_name
        renamed.append((slug, name, new_name))

    for slug, a, b in renamed:
        print(f"  RENAME {slug}\n      {a}  ->  {b}")
    for slug, why in skipped:
        print(f"  SKIP   {slug}: {why}")
    print(f"\n{len(renamed)} renamed, {len(skipped)} skipped" + (" [dry run]" if dry else ""))
    if not dry and renamed:
        with open(SPEC, "w", encoding="utf-8") as f:
            json.dump(spec, f, indent=1)
        print(f"wrote {SPEC}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
