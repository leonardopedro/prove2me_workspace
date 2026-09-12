#!/usr/bin/env python3
"""Pre-submission compliance audit (SKILL.md "three basic rules" + runbook §6.1).

Runs locally with no credential and no Lean toolchain, so it is the cheapest
gate available on a checkout that cannot build Mathlib:

  A. every solution is a TOP-LEVEL `theorem solution` (rule 1)
  B. no solution imports its own target theorem (rule 2)
  C. no `sorry` anywhere in a solution (rule 3)
  D. conservative-ASCII identifier policy: the server rejects `'` in
     theorem_name, so names/slugs carrying one can never be published
  E. every theorem stub still ends in `:= by sorry` and its declaration name
     matches the wave spec's dotted name (what the uploader splits on)

Usage: python3 debug/skill_compliance.py [--limit N]
Exit code 1 if any hard violation (A/B/C/E) is found.
"""
import argparse
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402  (reuse the workspace/path resolution)


def solution_rules(path):
    """(top_level_solution, self_imports, text) for one Sol file.

    Rule 1 wants a top-level `theorem solution`: declared at column 0 and not
    wrapped in a namespace, so track namespace depth up to the declaration.
    """
    txt = open(path, encoding="utf-8").read()
    ns_depth = 0
    found = False
    for line in txt.splitlines():
        if line.startswith("theorem solution"):
            found = True
            break
        if re.match(r"\s*namespace\s", line):
            ns_depth += 1
        elif re.match(r"\s*end\b", line):
            ns_depth -= 1
    self_imports = re.findall(r"(?m)^\s*import\s+Theorems\.Thm_(\S+)", txt)
    return found and ns_depth <= 0, self_imports, txt


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--limit", type=int, default=0)
    args = ap.parse_args()

    wave = json.load(open(os.path.join(WS, "pipeline/wave_upload.json"), encoding="utf-8"))
    thms = wave["thms"]

    hard = {"not_top_level_solution": [], "self_import": [],
            "sorry_in_solution": [], "stub_not_sorry": [], "name_mismatch": []}
    soft = {"apostrophe_in_identifier": []}
    checked = 0

    for slug, meta in thms.items():
        if args.limit and checked >= args.limit:
            break
        checked += 1
        name = meta["name"]
        if "'" in name or "'" in slug:
            soft["apostrophe_in_identifier"].append(slug)

        sol = os.path.join(WS, f"Solutions/Sol_{slug}.lean")
        if os.path.exists(sol):
            ok_top, self_imports, txt = solution_rules(sol)
            if not ok_top:
                hard["not_top_level_solution"].append(slug)
            if slug in self_imports:
                hard["self_import"].append(slug)
            if re.search(r"(?<![\w.])sorry(?![\w'])", txt):
                hard["sorry_in_solution"].append(slug)

        thm = up.resolve_path(meta["file"])
        if os.path.exists(thm):
            body = open(thm, encoding="utf-8").read()
            if not body.rstrip().endswith(":= by sorry"):
                hard["stub_not_sorry"].append(slug)
            if not re.search(r"(?m)^theorem\s+" + re.escape(name) + r"\b", body):
                hard["name_mismatch"].append(slug)

    print(f"audited {checked} wave theorem/solution pair(s)")
    for k, v in hard.items():
        print(f"  {k}: {len(v)}" + (f"  e.g. {', '.join(v[:3])}" if v else ""))
    for k, v in soft.items():
        print(f"  {k}: {len(v)}" + (f"  e.g. {', '.join(v[:3])}" if v else ""))
    return 1 if any(hard.values()) else 0


if __name__ == "__main__":
    sys.exit(main())
