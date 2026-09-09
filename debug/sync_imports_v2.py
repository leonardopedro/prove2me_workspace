#!/usr/bin/env python3
"""Add missing `import Definitions.Def_*` lines to def bundles — v2.

v1 (sync_upstream_imports.py) imported every upstream chapter the source
chapter imported; that over-corrects: many bundles INLINE the upstream decls
(§12.9 inlining attempt), and importing the same chapter as well makes every
reference AMBIGUOUS.  v2 therefore:

  1. builds a name -> defining-chapter index over ALL local Def bundles
     (first declaration of each short name wins, matching Lean's later-shadow
     behaviour loosely; ambiguity only arises when a name is declared in BOTH
     an imported module and the importing file, which is exactly what we
     avoid),
  2. for each bundle on the command line (default: debug/upstream_list.txt),
     parses its OWN error lines? No — simpler, static rule:
       for each chapter Y the SOURCE chapter imports: add `import
       Definitions.Def_Y` ONLY IF bundle X references names defined in Y and
       does NOT itself declare any of them.
  3. never touches a bundle whose missing names it declares itself.

Run debug/compile_check.sh before and after; iterate only on the failing
files.  Junk `import BookProof.*` / duplicate `import Mathlib` preambles are
also cleaned (same rule as v1).

Usage:  python3 debug/sync_imports_v2.py ChapterA ChapterB ...
"""
import os
import re
import sys
from collections import defaultdict

WS = "/home/leo/prove2me_workspace"
SRC = "/home/leo/Projects/timepiece/BookProof"
DEFDIR = f"{WS}/Definitions"
LIST_DEFAULT = f"{WS}/debug/upstream_list.txt"

DECL_RE = re.compile(
    r"^(?:noncomputable\s+)?(?:private\s+)?(?:abbrev|def|theorem|lemma|structure|class|inductive|instance)\s+([A-Za-z_][A-Za-z0-9_']*)",
    re.M)


def chapters():
    if len(sys.argv) > 1:
        return [c for c in sys.argv[1:] if c]
    with open(LIST_DEFAULT) as f:
        return [ln.strip() for ln in f if ln.strip()]


def local_def_chapters():
    return {fn[4:-5] for fn in os.listdir(DEFDIR)
            if fn.startswith("Def_") and fn.endswith(".lean")}


def decls_of(path):
    try:
        return set(DECL_RE.findall(open(path).read()))
    except OSError:
        return set()


def source_imports(chap):
    src = f"{SRC}/{chap}.lean"
    if not os.path.exists(src):
        return []
    return re.findall(r"^import BookProof\.(Chapter[A-Za-z0-9]*)",
                      open(src).read(), re.M)


def strip_junk(text):
    lines = text.splitlines(keepends=False)
    out, seen = [], False
    for ln in lines:
        s = ln.strip()
        if s == "import Mathlib":
            if not seen:
                out.append(ln)
                seen = True
            continue
        if re.match(r"^import BookProof\.", s):
            continue
        out.append(ln)
    return "\n".join(out)


def main():
    have = local_def_chapters()
    # name -> set of defining chapters
    index = defaultdict(set)
    for c in have:
        for n in decls_of(f"{DEFDIR}/Def_{c}.lean"):
            index[n].add(c)

    todo = chapters()
    for chap in todo:
        path = f"{DEFDIR}/Def_{chap}.lean"
        if not os.path.exists(path):
            print(f"SKIP {chap}: no Def file")
            continue
        text = open(path).read()
        orig = text
        text = strip_junk(text)
        own = decls_of_text = set(DECL_RE.findall(text))
        existing = set(re.findall(r"^import Definitions\.Def_([A-Za-z0-9]*)", text, re.M))
        add = []
        for dep in source_imports(chap):
            if dep == chap or dep in existing or dep not in have:
                continue
            dep_names = {n for n, cs in index.items() if dep in cs}
            # does the bundle reference any of dep's names?
            referenced = {n for n in dep_names if re.search(rf"\b{re.escape(n)}\b", text)}
            if not referenced:
                continue
            # and does it declare them itself?  (then importing = ambiguity)
            clash = referenced & own
            if clash:
                print(f"skip {chap} <- {dep}: inline clash {sorted(clash)[:3]}")
                continue
            add.append(dep)
        if add:
            pos = 0
            for m in re.finditer(r"^import .*$", text, re.M):
                pos = m.end()
            ins = "\n".join(f"import Definitions.Def_{d}" for d in sorted(set(add)))
            head, tail = text[:pos], text[pos:]
            text = head + "\n" + ins + tail
        if text != orig:
            with open(path, "w") as f:
                f.write(text)
            print(f"SYNC {chap}: +{sorted(set(add))}" if add else f"CLEAN {chap}")
        else:
            print(f"ok   {chap}")


if __name__ == "__main__":
    main()
