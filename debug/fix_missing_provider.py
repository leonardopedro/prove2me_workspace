#!/usr/bin/env python3
"""Repair the `Unknown identifier X` / `Unknown constant X` sol class (fix23).

PIPELINE_PLAN §2.29-3 did this by hand for 138 sols: the name IS declared in a
bundle the sol never imported (or imported without `open`).  This script
generalises it, with two safety rules learned the hard way:

* only a **published** provider counts (`state/published_bundles/Def_*.lean`
  must actually DECLARE the leaf name — §2.7a: a hollow bundle declares
  nothing, and grepping the text is the only dependable test);
* only ADD imports/opens, never remove: ambiguity is resolved by the compiler
  in the oracle recheck, not here (§5d).

Usage:
    python3 debug/fix_missing_provider.py --slugs /tmp/fail163.txt [--apply]
"""
import argparse
import json
import os
import re
import shutil
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PUB = f"{WS}/state/published_bundles"
DECL = re.compile(r"^\s*(?:@\[[^\]]*\]\s*)*(?:protected\s+|private\s+|nonrec\s+)*"
                  r"(?:def|abbrev|theorem|lemma|instance|structure|class|inductive|opaque)\s+([^\s({:]+)",
                  re.M)
IDENT = re.compile(r"Unknown (?:identifier|constant) [`\"]([^`\"]+)[`\"]")


def providers():
    """leaf name -> (module, namespace) over every published bundle that
    actually declares something (hollow bundles skipped)."""
    idx = {}
    for fn in sorted(os.listdir(PUB)):
        if not (fn.startswith("Def_") and fn.endswith(".lean")):
            continue
        txt = open(f"{PUB}/{fn}", encoding="utf-8").read()
        mod = "Definitions." + fn[:-5]
        ns, stack = None, []
        for line in txt.splitlines():
            m = re.match(r"^namespace\s+(\S+)", line)
            if m:
                stack.append(m.group(1))
                continue
            if re.match(r"^end\b", line):
                if stack:
                    stack.pop()
                continue
            d = DECL.match(line)
            if d:
                leaf = d.group(1).split(".")[-1]
                ns = ".".join(stack)
                idx.setdefault(leaf, []).append((mod, ns))
    return idx


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--slugs", required=True)
    ap.add_argument("--verdicts", default=f"{WS}/state/offline_pending_check.json")
    ap.add_argument("--apply", action="store_true")
    args = ap.parse_args()

    verds = json.load(open(args.verdicts))["sol"]["items"]
    slugs = [l.strip() for l in open(args.slugs) if l.strip()]
    idx = providers()
    report, fixed = [], 0
    for s in slugs:
        v = str(verds.get(s, ""))
        m = IDENT.search(v)
        if not m:
            continue
        name = m.group(1)
        leaf = name.split(".")[-1]
        cands = idx.get(leaf, [])
        if name.startswith("BookProof."):
            # fully qualified in the sol: the namespace must match exactly
            ns_want = ".".join(name.split(".")[:-1])
            cands = [(mo, ns) for mo, ns in cands if ns == ns_want]
        if not cands:
            report.append((s, name, "no published provider"))
            continue
        path = f"{WS}/Solutions/Sol_{s}.lean"
        txt = open(path, encoding="utf-8").read()
        mods = [mo for mo, _ in cands]
        need_mod = [mo for mo in mods if f"import {mo}" not in txt]
        need_ns = sorted({ns for mo, ns in cands
                          if ns and f"open {ns}" not in txt
                          and not re.search(rf"open [^\n]*\b{re.escape(ns.split()[-1])}\b", txt)})
        if not need_mod and not need_ns:
            report.append((s, name, "already imported/opened"))
            continue
        report.append((s, name, f"+import {need_mod} +open {need_ns}"))
        if not args.apply:
            continue
        lines = txt.splitlines(keepends=True)
        last_imp = max((i for i, l in enumerate(lines) if l.startswith("import ")), default=-1)
        for mo in reversed(need_mod):
            lines.insert(last_imp + 1, f"import {mo}\n")
        last_open = max((i for i, l in enumerate(lines) if l.startswith("open ")), default=last_imp)
        for ns in reversed(need_ns):
            lines.insert(last_open + 1, f"open {ns}\n")
        bak = path + ".bak_fix23"
        if not os.path.exists(bak):
            shutil.copy2(path, bak)
        open(path, "w", encoding="utf-8").write("".join(lines))
        fixed += 1
    for r in report:
        print("\t".join(r))
    print(f"fixable: {sum(1 for r in report if r[2].startswith('+'))} "
          f"of {len(slugs)}  applied: {fixed}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
