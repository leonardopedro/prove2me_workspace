#!/usr/bin/env python3
"""Repair stubs whose statement cites a declaration from *another* def bundle.

Generator gap: a stub imports only `Definitions.Def_<own chapter>`, but its
statement references a helper declared in a different chapter's def bundle
(`IsShiftInvertC` in Def_ChapterHashimotoComplexShifts, `diagOp` in
Def_ChapterNavierStokesDeficiency, `EssentiallySelfAdjointOn` in
Def_ChapterFarisLavineCore, ...).  The server rejects the whole submission with
`Unknown identifier X`.

For each such identifier this adds `import Definitions.Def_<bundle>` and an
`open <innermost namespace>` so the bare name resolves.  Identifiers declared in
*no* def bundle are reported as blocked (they need their own node published).

Usage:
  python3 debug/fix_stub_def_imports.py --dry-run [--only SUBSTR]
  python3 debug/fix_stub_def_imports.py [--only SUBSTR]
"""
import argparse
import json
import os
import re
import sys

WS = os.environ.get("PROVE2ME_WS") or os.getcwd()
DEFS = os.path.join(WS, "Definitions")
THMS = os.path.join(WS, "Theorems")
STATE = os.path.join(WS, "state", "pipeline.json")

IMPORT_RE = re.compile(r'^import\s+Definitions\.(?P<mod>\S+)\s*$', re.M)
NS_RE = re.compile(r'^namespace\s+([A-Za-z_][\w.]*)\s*$')
DECL_RE = re.compile(r'^\s*(?:@\[[^\]]*\]\s*)?(?:private\s+|protected\s+|noncomputable\s+|partial\s+|unsafe\s+)*'
                     r'(?:def|theorem|lemma|abbrev|structure|class|instance|inductive)\s+([A-Za-z_][\w\'.!?]*)')
UNK_RE = re.compile(r"Unknown identifier `([^`]+)`")
OPEN_RE = re.compile(r'^open\s+([A-Za-z_][\w.]*(?:\s+[A-Za-z_][\w.]*)*)\s*$', re.M)


def def_modules():
    return {f[:-5][len("Def_"):]: os.path.join(DEFS, f)
            for f in os.listdir(DEFS) if f.startswith("Def_") and f.endswith(".lean")}


def decl_info(path, name):
    """(module, innermost namespace) declaring `name` top-level, else (None, None)."""
    stack = []
    for line in open(path):
        m = NS_RE.match(line)
        if m:
            stack.append(m.group(1))
            continue
        if re.match(r'^end(\s|$)', line) and stack:
            stack.pop()
            continue
        d = DECL_RE.match(line)
        if d and d.group(1) == name:
            return os.path.basename(path)[len("Def_"):-5], ".".join(stack)
    return None, None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--only", action="append", default=[])
    a = ap.parse_args()

    st = json.load(open(STATE))["items"]
    mods = def_modules()

    # index: identifier -> (module, namespace) for every top-level declaration
    index = {}
    for mod, path in mods.items():
        stack = []
        for line in open(path):
            m = NS_RE.match(line)
            if m:
                stack.append(m.group(1))
                continue
            if re.match(r'^end(\s|$)', line) and stack:
                stack.pop()
                continue
            d = DECL_RE.match(line)
            if d:
                index.setdefault(d.group(1), (mod, ".".join(stack)))

    patched = blocked = 0
    for key, rec in sorted(st.items()):
        if not key.startswith("thm:"):
            continue
        if rec.get("status") == "done":
            continue
        if a.only and not any(s in key for s in a.only):
            continue
        err = rec.get("error") or ""
        names = [n for n in UNK_RE.findall(err) if "." not in n]
        if not names:
            continue
        fn = "Thm_" + key.split(":", 1)[1] + ".lean"
        path = os.path.join(THMS, fn)
        if not os.path.exists(path):
            continue
        txt = open(path).read()
        have = {(m[4:] if m.startswith("Def_") else m)
                for m in IMPORT_RE.findall(txt)}
        opens = {n for m in OPEN_RE.findall(txt) for n in m.split()}
        add_imports, add_opens, missing = [], [], []
        for n in names:
            hit = index.get(n)
            if not hit:
                missing.append(n)
                continue
            mod, ns = hit
            if mod not in have:
                add_imports.append(mod)
            if ns and ns not in opens:
                add_opens.append(ns)
        if missing:
            print(f"{fn}: BLOCKED {', '.join(sorted(set(missing)))} (no def bundle declares them)")
            blocked += 1
            continue
        if not add_imports and not add_opens:
            continue
        print(f"{fn}: +import {sorted(set(add_imports))} +open {sorted(set(add_opens))}")
        patched += 1
        if a.dry_run:
            continue
        lines = txt.split("\n")
        last_imp = max(i for i, l in enumerate(lines)
                       if l.startswith("import ") and not l.startswith("import Mathlib"))
        for m in sorted(set(add_imports)):
            lines.insert(last_imp + 1, f"import Definitions.Def_{m}")
        # insert opens right after the import block
        last_imp = max(i for i, l in enumerate(lines) if l.startswith("import "))
        for ns in sorted(set(add_opens)):
            lines.insert(last_imp + 1, f"open {ns}")
        # Drop duplicated import/open lines an earlier revision of this tool added.
        seen, dedup = set(), []
        for l in lines:
            if (l.startswith("import Definitions.") or l.startswith("open ")):
                if l in seen:
                    continue
                seen.add(l)
            dedup.append(l)
        open(path, "w").write("\n".join(dedup))

    print(f"\n{'would patch' if a.dry_run else 'patched'} {patched} file(s), {blocked} blocked")
    return 0


if __name__ == "__main__":
    sys.exit(main())
