#!/usr/bin/env python3
"""Sync `import Definitions.Def_*` lines into def bundles from their source
chapters' `import BookProof.Chapter*` lines (§12.9 strategy).

For every Definitions/Def_Chapter<X>.lean (or a chapter list given on the
command line), read the matching source /home/leo/Projects/timepiece/BookProof/
Chapter<X>.lean, collect its `import BookProof.Chapter<Y>` lines, and insert
`import Definitions.Def_Chapter<Y>` into the def bundle whenever
  * Definitions/Def_Chapter<Y>.lean exists locally, and
  * the bundle does not already import it.

Also removes junk repeated preambles (duplicated `import Mathlib` /
`import BookProof.*` lines) that earlier regeneration runs left behind.

Only `Definitions/Def_Chapter<X>.lean` files passed on the command line are
touched; with no arguments it processes the publish-order list
debug/upstream_list.txt.  Run debug/compile_check.sh afterwards.

Usage:
    python3 debug/sync_upstream_imports.py ChapterA ChapterB ...
    python3 debug/sync_upstream_imports.py            # whole upstream list
"""
import os
import re
import sys

WS = "/home/leo/prove2me_workspace"
SRC = "/home/leo/Projects/timepiece/BookProof"
DEFDIR = f"{WS}/Definitions"
LIST_DEFAULT = f"{WS}/debug/upstream_list.txt"


def chapters():
    if len(sys.argv) > 1:
        return [c for c in sys.argv[1:] if c]
    with open(LIST_DEFAULT) as f:
        return [ln.strip() for ln in f if ln.strip()]


def local_def_chapters():
    out = set()
    for fn in os.listdir(DEFDIR):
        if fn.startswith("Def_") and fn.endswith(".lean"):
            out.add(fn[4:-5])
    return out


def strip_junk(text):
    """Collapse duplicated `import Mathlib` and remove `import BookProof.*`
    lines (platform-fatal); keep a single leading `import Mathlib`."""
    lines = text.splitlines(keepends=False)
    out, seen_mathlib = [], False
    for i, ln in enumerate(lines):
        s = ln.strip()
        if s == "import Mathlib":
            if not seen_mathlib:
                out.append(ln)
                seen_mathlib = True
            continue
        if re.match(r"^import BookProof\.", s):
            continue
        out.append(ln)
    return "\n".join(out)


def needed_def_imports(chap):
    """Definitions.* imports chapter `chap`'s bundle should carry."""
    src = f"{SRC}/{chap}.lean"
    need = []
    if not os.path.exists(src):
        return need
    for m in re.finditer(r"^import BookProof\.(Chapter[A-Za-z0-9]*)", open(src).read(), re.M):
        dep = m.group(1)
        if dep != chap and dep in local_def_chapters():
            need.append(dep)
    return need


def main():
    todo = chapters()
    have = local_def_chapters()
    changed = []
    for chap in todo:
        path = f"{DEFDIR}/Def_{chap}.lean"
        if not os.path.exists(path):
            print(f"SKIP {chap}: no Def file")
            continue
        text = open(path).read()
        orig = text
        text = strip_junk(text)
        # find position after the last existing import line
        imports = re.findall(r"^import .*$", text, re.M)
        pos = 0
        for m in re.finditer(r"^import .*$", text, re.M):
            pos = m.end()
        existing = set(re.findall(r"^import (Definitions\.Def_[A-Za-z0-9]*)", text, re.M))
        add = []
        for dep in needed_def_imports(chap):
            mod = f"Definitions.Def_{dep}"
            if mod not in existing:
                add.append(f"import {mod}")
        if add or text != orig:
            head, tail = text[:pos], text[pos:]
            text = head + ("\n" if head else "") + "\n".join(add) + tail
            with open(path, "w") as f:
                f.write(text)
            changed.append((chap, len(add)))
            print(f"SYNC {chap}: +{len(add)} imports")
        else:
            print(f"ok   {chap}: no changes")
    print(f"\n{len(changed)} file(s) changed")


if __name__ == "__main__":
    main()
