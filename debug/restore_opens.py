#!/usr/bin/env python3
"""Correct Lean namespace scanner, and repair a bad drop pass with it.

`debug/fix_sol_ns_imports.py --drop` decided "no def bundle declares X" with a
scanner that pushed only `namespace` blocks but popped on **every** `end` line.
`section … end` therefore popped the enclosing namespace, so namespaces declared
after the first section were reported undeclared and their (valid) `open` lines
were removed.

This tool re-derives the truth:
  * `scan()` tracks `namespace`/`section`/`end` in one stack, so a section's `end`
    can no longer close a namespace;
  * for every `Solutions/*.lean` it takes the `open BookProof.…` lines present in
    **git HEAD** and re-adds any of them that (a) is missing from the working copy
    and (b) *is* declared by some `Definitions.Def_*` bundle.

Nothing is ever removed here.

Usage:
  python3 debug/restore_opens.py --dry-run [--only SUBSTR]
  python3 debug/restore_opens.py
  python3 debug/restore_opens.py --declare BookProof.YangMillsHermite.RealCoeff
"""
import argparse
import os
import re
import subprocess
import sys

WS = os.environ.get("PROVE2ME_WS") or os.getcwd()
DEFS = os.path.join(WS, "Definitions")
SOLS = os.path.join(WS, "Solutions")

NS_OPEN = re.compile(r'^(?:noncomputable\s+|private\s+)?namespace\s+([A-Za-z_][\w.]*)\s*$')
SEC_OPEN = re.compile(r'^(?:noncomputable\s+|private\s+)?section(?:\s+([A-Za-z_][\w.\']*))?\s*$')
END_RE = re.compile(r'^end(?:\s+([A-Za-z_][\w.\']*))?\s*$')
DECL_RE = re.compile(r'^(?:@\[[^\]]*\]\s*)?(?:private\s+|protected\s+|noncomputable\s+|partial\s+|unsafe\s+)*'
                     r'(?:def|theorem|lemma|abbrev|structure|class|instance|inductive)\s+([A-Za-z_][\w\'.!?]*)')
OPEN_RE = re.compile(r'^open(?:[ \t]+scoped)?[ \t]+([A-Za-z_][\w.]*(?:[ \t]+[A-Za-z_][\w.]*)*)[ \t]*$', re.M)


def scan(lines):
    """Return (namespace prefixes, declarations) declared at top level."""
    stack = []          # ('ns'|'sec', name)
    namespaces = set()
    decls = set()

    def full():
        return ".".join(n for k, n in stack if k == "ns")

    for raw in lines:
        s = raw.strip()
        if s.startswith("--") or s.startswith("/-"):
            continue
        m = NS_OPEN.match(s)
        if m:
            stack.append(("ns", m.group(1)))
            parts = full().split(".")
            for i in range(1, len(parts) + 1):
                namespaces.add(".".join(parts[:i]))
            continue
        m = SEC_OPEN.match(s)
        if m:
            stack.append(("sec", m.group(1) or ""))
            continue
        m = END_RE.match(s)
        if m:
            name = m.group(1)
            hit = None
            for i in range(len(stack) - 1, -1, -1):
                if name and stack[i][1] == name:
                    hit = i
                    break
            if hit is None:
                if stack:
                    stack.pop()
            else:
                del stack[hit:]
            continue
        m = DECL_RE.match(s)
        if m:
            decls.add((full(), m.group(1)))
    return namespaces, decls


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--only", action="append", default=[])
    ap.add_argument("--declare", help="print which bundle declares a namespace and exit")
    a = ap.parse_args()

    def_bundles = {}
    for fn in sorted(os.listdir(DEFS)):
        if fn.startswith("Def_") and fn.endswith(".lean"):
            ns, _ = scan(open(os.path.join(DEFS, fn)).read().split("\n"))
            def_bundles[fn[4:-5]] = ns
    all_ns = set().union(*def_bundles.values()) if def_bundles else set()

    if a.declare:
        owners = [m for m, ns in def_bundles.items() if a.declare in ns]
        print(f"{a.declare}: declared={a.declare in all_ns} owners={owners}")
        return 0

    patched = 0
    for fn in sorted(f for f in os.listdir(SOLS) if f.endswith(".lean")):
        if a.only and not any(s in fn for s in a.only):
            continue
        path = os.path.join(SOLS, fn)
        rel = os.path.relpath(path, WS)
        head = subprocess.run(["git", "show", f"HEAD:{rel}"], cwd=WS,
                              capture_output=True, text=True).stdout
        if not head:
            continue
        head_opens = set()
        for grp in OPEN_RE.findall(head):
            head_opens.update(n for n in grp.split() if n.startswith("BookProof."))
        if not head_opens:
            continue
        cur = open(path).read()
        cur_opens = {n for grp in OPEN_RE.findall(cur) for n in grp.split()}
        want = {n for n in head_opens - cur_opens if n in all_ns}
        if not want:
            continue
        print(f"{fn}: +open {sorted(want)}")
        patched += 1
        if a.dry_run:
            continue
        lines = cur.split("\n")
        last = max(i for i, l in enumerate(lines) if l.startswith("import "))
        for ns in sorted(want):
            lines.insert(last + 1, f"open {ns}")
        open(path, "w").write("\n".join(lines))

    print(f"\n{'would restore' if a.dry_run else 'restored'} {patched} file(s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
