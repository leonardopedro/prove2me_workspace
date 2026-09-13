#!/usr/bin/env python3
"""Solution-side analogue of `debug/fix_stub_def_imports.py`.

A proof cites a helper declared in a def bundle other than the one it imports
(`harmCore` in Def_ChapterQgHermiteOscillatorEsa, `cpoly_sum`, `gaussInt_coreD`,
`eval_harmPoly`, ...), so the server answers `verdict CE: ... Unknown identifier X`.

For each identifier named in the item's recorded error this adds
`import Definitions.Def_<bundle>` and `open <innermost namespace at the declaration>`.
Identifiers no def bundle declares are reported BLOCKED.

Usage:
  python3 debug/fix_sol_def_imports.py --dry-run [--only SUBSTR]
  python3 debug/fix_sol_def_imports.py
"""
import argparse
import json
import os
import re
import sys

WS = os.environ.get("PROVE2ME_WS") or os.getcwd()
DEFS = os.path.join(WS, "Definitions")
SOLS = os.path.join(WS, "Solutions")
STATE = os.path.join(WS, "state", "pipeline.json")

IMPORT_RE = re.compile(r'^import\s+Definitions\.(?P<mod>\S+)\s*$', re.M)
NS_RE = re.compile(r'^namespace\s+([A-Za-z_][\w.]*)\s*$')
DECL_RE = re.compile(r'^\s*(?:@\[[^\]]*\]\s*)?(?:private\s+|protected\s+|noncomputable\s+|partial\s+|unsafe\s+)*'
                     r'(?:def|theorem|lemma|abbrev|structure|class|instance|inductive)\s+([A-Za-z_][\w\'.!?]*)')
UNK_RE = re.compile(r"Unknown identifier `([^`]+)`")
OPEN_RE = re.compile(r'^open\s+([A-Za-z_][\w.]*(?:\s+[A-Za-z_][\w.]*)*)\s*$', re.M)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--only", action="append", default=[])
    a = ap.parse_args()

    index = {}
    for fn in sorted(os.listdir(DEFS)):
        if not (fn.startswith("Def_") and fn.endswith(".lean")):
            continue
        stack = []
        for line in open(os.path.join(DEFS, fn)):
            m = NS_RE.match(line)
            if m:
                stack.append(m.group(1))
                continue
            if re.match(r'^end(\s|$)', line) and stack:
                stack.pop()
                continue
            d = DECL_RE.match(line)
            if d:
                index.setdefault(d.group(1), (fn[4:-5], ".".join(stack)))

    st = json.load(open(STATE))["items"]
    patched = blocked = 0
    for key, rec in sorted(st.items()):
        if not key.startswith("sol:") or rec.get("status") == "done":
            continue
        if a.only and not any(s in key for s in a.only):
            continue
        names = [n for n in UNK_RE.findall(rec.get("error") or "") if "." not in n]
        if not names:
            continue
        path = os.path.join(SOLS, "Sol_" + key.split(":", 1)[1] + ".lean")
        if not os.path.exists(path):
            continue
        txt = open(path).read()
        have = {(m[4:] if m.startswith("Def_") else m) for m in IMPORT_RE.findall(txt)}
        opens = {n for m in OPEN_RE.findall(txt) for n in m.split()}
        add_imports, add_opens, missing = set(), set(), set()
        for n in names:
            hit = index.get(n)
            if not hit:
                missing.add(n)
                continue
            mod, ns = hit
            if mod not in have:
                add_imports.add(mod)
            if ns and ns not in opens:
                add_opens.add(ns)
        if missing:
            print(f"sol:{key.split(':', 1)[1]}: BLOCKED {sorted(missing)}")
            blocked += 1
        if not add_imports and not add_opens:
            continue
        print(f"sol:{key.split(':', 1)[1]}: +import {sorted(add_imports)} +open {sorted(add_opens)}")
        patched += 1
        if a.dry_run:
            continue
        lines = txt.split("\n")
        last = max(i for i, l in enumerate(lines) if l.startswith("import "))
        for mod in sorted(add_imports):
            lines.insert(last + 1, f"import Definitions.Def_{mod}")
        for ns in sorted(add_opens):
            lines.insert(last + 1, f"open {ns}")
        open(path, "w").write("\n".join(lines))

    print(f"\n{'would patch' if a.dry_run else 'patched'} {patched} file(s), {blocked} blocked")
    return 0


if __name__ == "__main__":
    sys.exit(main())
