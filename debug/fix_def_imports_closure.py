#!/usr/bin/env python3
"""Rewrite each Def_ChapterX.lean bundle's imports to the transitive closure of
its source chapter's `import BookProof.ChapterY` lines (source edges only, which
are acyclic in Lean).  This removes cycle-creating / docstring-derived imports
that the earlier completion script added while keeping everything the bundle
could possibly reference through the source's own import web."""
import os
import re
import sys

DEF_DIR = "Definitions"
SRC_DIR = "BookProof"

def source_path(chap):
    return os.path.join(SRC_DIR, f"Chapter{chap}.lean")

def def_path(chap):
    return os.path.join(DEF_DIR, f"Def_Chapter{chap}.lean")

def source_imports(chap):
    """Direct BookProof.ChapterX imports of the source chapter (deduped)."""
    out = []
    p = source_path(chap)
    if not os.path.exists(p):
        return out
    txt = open(p, encoding="utf-8", errors="replace").read()
    for m in re.finditer(r"^import BookProof\.Chapter([A-Za-z0-9]+)", txt, re.M):
        if m.group(1) not in out:
            out.append(m.group(1))
    for m in re.finditer(r"^import BookProof\.([A-Z][A-Za-z0-9]*)", txt, re.M):
        n = m.group(1)
        if n == "Prelude":
            continue
        if n not in out:
            out.append(n)
    return out

def transitive_closure(chap):
    """All source chapters reachable from chap via source import edges, that
    have a Def bundle."""
    seen = set()
    stack = [chap]
    while stack:
        cur = stack.pop()
        for nxt in source_imports(cur):
            if nxt in seen:
                continue
            if os.path.exists(def_path(nxt)):
                seen.add(nxt)
                stack.append(nxt)
    return seen

def main():
    fixed = 0
    for fn in sorted(os.listdir(DEF_DIR)):
        if not fn.startswith("Def_Chapter") or not fn.endswith(".lean"):
            continue
        chap = fn[len("Def_Chapter"):-len(".lean")]
        path = os.path.join(DEF_DIR, fn)
        txt = open(path, encoding="utf-8", errors="replace").read()
        # Closure over source edges + self.
        closure = transitive_closure(chap)
        imports = sorted(closure)
        # Keep existing non-Definitions imports (Mathlib etc.) untouched.
        keep = []
        for line in txt.splitlines():
            if line.startswith("import ") and "Definitions.Def_" not in line:
                keep.append(line)
        new_imports = keep + [f"import Definitions.Def_Chapter{n}" for n in imports]
        # Drop existing Definitions imports and the leading blank, re-emit.
        lines = [l for l in txt.splitlines() if not l.startswith("import Definitions.Def_")]
        body = "\n".join(lines).lstrip("\n")
        new_text = "\n".join(new_imports) + "\n\n" + body + "\n"
        if new_text != txt:
            open(path, "w", encoding="utf-8").write(new_text)
            fixed += 1
            print(f"fixed {fn}: {len(imports)} upstream imports")
    print(f"total fixed: {fixed}")

if __name__ == "__main__":
    main()