#!/usr/bin/env python3
"""Complete upstream `import Definitions.Def_ChapterX` lines in def bundles.

The generator only adds imports for DIRECT `import BookProof.ChapterX` lines in
the source.  Chapters written against the monolith reference namespaces from
TRANSITIVE imports (e.g. ChapterFriedrichsExtension uses FarisLavineCore's
`SymmetricOn`/`quadForm` but only imports ChapterHashimotoShiftInvert).  This
script scans each def bundle's body for `BookProof.<Ns>` tokens and adds an
import for the chapter that provides that namespace (when a Def file exists).

Usage: python3 debug/complete_upstream_imports.py [ChapterName ...]
       (default: all Definitions/Def_Chapter*.lean)
"""
import os
import re
import sys

WS = "/home/leo/prove2me_workspace"
DEF_DIR = f"{WS}/Definitions"
PROJ = "/home/leo/Projects/timepiece"

# namespace suffix -> chapter name, from `namespace BookProof.X` in sources
NS_TO_CHAPTER = {}
for fn in os.listdir(f"{PROJ}/BookProof"):
    if not fn.endswith(".lean"):
        continue
    name = fn[:-5]
    txt = open(f"{PROJ}/BookProof/{fn}", encoding="utf-8", errors="replace").read()
    for m in re.finditer(r"^namespace BookProof\.([A-Za-z0-9_.']+)", txt, re.M):
        ns = m.group(1)
        top = ns.split(".")[0]
        # store WITHOUT the Chapter prefix (def_exists uses Def_Chapter<name>)
        NS_TO_CHAPTER.setdefault(top, name.removeprefix("Chapter"))


def def_exists(chap):
    return os.path.exists(f"{DEF_DIR}/Def_Chapter{chap}.lean")


def imports_of(path):
    txt = open(path, encoding="utf-8", errors="replace").read()
    return set(re.findall(r"^import Definitions\.Def_Chapter([A-Za-z0-9]+)",
                          txt, re.M))


def add_imports(chap):
    path = f"{DEF_DIR}/Def_Chapter{chap}.lean"
    if not os.path.exists(path):
        return 0, ["no file"]
    txt = open(path, encoding="utf-8", errors="replace").read()
    cur = imports_of(path)
    # Namespaces referenced in the body (exclude import lines and the module's
    # own namespace declaration).
    body = re.sub(r"^import .*\n", "", txt, flags=re.M)
    refs = set(re.findall(r"\bBookProof\.([A-Za-z0-9_'.]+)", body))
    refs |= set(re.findall(r"\b(?:open\s+)?BookProof\.([A-Za-z0-9_'.]+)", body))
    # ALSO look at the SOURCE chapter's `open BookProof.X` and
    # `import BookProof.ChapterX` lines: the generator strips open lines from
    # bundles, so unqualified names (e.g. FarisLavine's SymmetricOn) lose their
    # provider, and transitive imports are not captured by direct imports.
    src = f"{PROJ}/BookProof/Chapter{chap}.lean"
    if os.path.exists(src):
        stxt = open(src, encoding="utf-8", errors="replace").read()
        for m in re.finditer(r"\bopen BookProof\.([A-Za-z0-9_.']+)", stxt):
            refs.add(m.group(1))
        for m in re.finditer(r"^import BookProof\.(?:Chapter)?([A-Za-z0-9]+)",
                             stxt, re.M):
            prov = m.group(1)
            if def_exists(prov):
                refs.add(prov)
    tops = {r.split(".")[0] for r in refs}
    added = []
    for top in sorted(tops):
        # resolve via namespace map, else assume import name == chapter name
        prov = NS_TO_CHAPTER.get(top, top)
        if not prov or prov == chap:
            continue
        if not def_exists(prov):
            continue
        if prov in cur:
            continue
        added.append(prov)
    if not added:
        return 0, []
    head_imports = [f"import Definitions.Def_Chapter{p}" for p in added]
    # Insert after the last existing `import Definitions...` line, before Mathlib
    lines = txt.split("\n")
    insert_at = 0
    for i, ln in enumerate(lines):
        if ln.startswith("import "):
            insert_at = i + 1
        else:
            break
    new_lines = lines[:insert_at] + head_imports + lines[insert_at:]
    open(path, "w").write("\n".join(new_lines))
    return len(added), added


def main():
    targets = sys.argv[1:] or sorted(
        f[len("Def_Chapter"):-len(".lean")]
        for f in os.listdir(DEF_DIR)
        if f.startswith("Def_Chapter") and f.endswith(".lean"))
    total = 0
    for chap in targets:
        n, added = add_imports(chap)
        if n:
            print(f"{chap}: +{n} {added}")
            total += n
    print(f"total imports added: {total}")


if __name__ == "__main__":
    main()