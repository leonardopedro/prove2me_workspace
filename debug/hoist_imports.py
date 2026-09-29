#!/usr/bin/env python3
"""Hoist every `import` line to the top of the file.

Lean rejects an import that is not at the beginning of the file:

    line 7: invalid 'import' command, it must be used in the beginning of the file

Generated solution files can interleave them — the preamble emits `open`s and
`import`s from the source chapter in source order, so an `import` that the source
wrote further down lands below an `open` and the whole node fails to compile.
A deeper repair pass that inserts an import after "the last import line" happily
adds more of them below the opens, so this pass is also what makes those insertions
legal.

Import order is preserved; duplicates collapse. The leading comment block stays on
top (Lean allows `--` comments before the first import).

Usage:
  python3 debug/hoist_imports.py --dry-run [--dir Solutions|Theorems|Definitions|all]
  python3 debug/hoist_imports.py
"""
import argparse
import os
import re
import sys

WS = os.environ.get("PROVE2ME_WS") or os.getcwd()
IMPORT_RE = re.compile(r'^import\s+\S')


def _is_noise(line):
    s = line.strip()
    return not s or s.startswith("--")


def hoist(txt):
    lines = txt.split("\n")
    # Lean's rule is only that imports precede the first command: blank lines and
    # comments between them are fine, and duplicate imports are legal. So a file is
    # clean unless an import follows the first real (non-import, non-comment) line —
    # otherwise leave it byte-identical.
    seen_real = False
    defective = False
    for line in lines:
        if _is_noise(line):
            continue
        if IMPORT_RE.match(line):
            if seen_real:
                defective = True
                break
        else:
            seen_real = True
    if not defective:
        return txt
    # Leading comment/blank block stays on top.
    head = 0
    while head < len(lines) and _is_noise(lines[head]):
        head += 1
    prefix, body = lines[:head], lines[head:]
    imports, rest = [], []
    for line in body:
        (imports if IMPORT_RE.match(line) else rest).append(line)
    while rest and not rest[0].strip():
        rest.pop(0)
    sep = [""] if rest and rest[0].strip() else []
    return "\n".join(prefix + imports + sep + rest)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--dir", default="all",
                    choices=["Solutions", "Theorems", "Definitions", "all"])
    a = ap.parse_args()

    dirs = ["Solutions", "Theorems", "Definitions"] if a.dir == "all" else [a.dir]
    patched = 0
    for d in dirs:
        home = os.path.join(WS, d)
        if not os.path.isdir(home):
            continue
        for fn in sorted(os.listdir(home)):
            if not fn.endswith(".lean"):
                continue
            path = os.path.join(home, fn)
            txt = open(path, encoding="utf-8").read()
            new = hoist(txt)
            if new == txt:
                continue
            print(f"{d}/{fn}")
            patched += 1
            if not a.dry_run:
                open(path, "w", encoding="utf-8").write(new)
    print(f"\n{'would hoist' if a.dry_run else 'hoisted'} {patched} file(s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
