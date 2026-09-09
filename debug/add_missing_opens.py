#!/usr/bin/env python3
"""Re-add `open BookProof.X` lines from the source chapter into each def bundle
(the generator used to strip them; bundle bodies reference the opened
identifiers unqualified and the namespaces are declared by upstream Def
bundles).  Opens already present in the bundle are skipped.

Only opens whose namespace is declared by a Def bundle **in the bundle's own
import closure** are added: an open for a namespace that no imported module
declares is a hard error ("unknown namespace").
"""
import os
import re

DEF_DIR = "Definitions"
SRC_DIR = "BookProof"


def imports_of(path):
    txt = open(path, encoding="utf-8", errors="replace").read()
    return [
        m.group(1)
        for m in re.finditer(r"^import\s+(Definitions\.Def_Chapter[A-Za-z0-9_]+)", txt, re.M)
    ]


def main():
    # Map namespace -> def bundle declaring it.
    ns_to_bundle = {}
    for fn in sorted(os.listdir(DEF_DIR)):
        if not fn.startswith("Def_Chapter") or not fn.endswith(".lean"):
            continue
        txt = open(os.path.join(DEF_DIR, fn), encoding="utf-8", errors="replace").read()
        for m in re.finditer(r"^namespace\s+(BookProof\.[A-Za-z0-9_.]+)\s*$", txt, re.M):
            ns_to_bundle.setdefault(m.group(1), fn)

    fixed = 0
    for fn in sorted(os.listdir(DEF_DIR)):
        if not fn.startswith("Def_Chapter") or not fn.endswith(".lean"):
            continue
        chap = fn[len("Def_Chapter"):-len(".lean")]
        src = os.path.join(SRC_DIR, f"Chapter{chap}.lean")
        if not os.path.exists(src):
            continue
        stxt = open(src, encoding="utf-8", errors="replace").read()
        opens = []
        for m in re.finditer(r"^open ((?:BookProof\.[A-Za-z0-9_.]+\s*)+)", stxt, re.M):
            for name in re.findall(r"BookProof\.[A-Za-z0-9_.]+", m.group(1)):
                if name not in opens:
                    opens.append(name)
        if not opens:
            continue
        path = os.path.join(DEF_DIR, fn)
        txt = open(path, encoding="utf-8", errors="replace").read()
        have = set()
        for m in re.finditer(r"^open ((?:BookProof\.[A-Za-z0-9_.]+\s*)+)", txt, re.M):
            have |= set(re.findall(r"BookProof\.[A-Za-z0-9_.]+", m.group(1)))

        # Import closure of this bundle (transitive).
        closure = set()
        stack = [fn]
        while stack:
            cur = stack.pop()
            if cur in closure:
                continue
            closure.add(cur)
            for imp in imports_of(os.path.join(DEF_DIR, cur)):
                prov = imp.split(".")[-1]
                if prov.startswith("Def_Chapter"):
                    prov = prov[len("Def_"):]
                prov_fn = f"Def_{prov}.lean"
                if prov_fn not in closure and os.path.exists(os.path.join(DEF_DIR, prov_fn)):
                    stack.append(prov_fn)

        missing = []
        for o in opens:
            if o in have:
                continue
            prov = ns_to_bundle.get(o)
            if prov is None or prov not in closure:
                # Cannot safely open: either no def bundle declares it or it is
                # not reachable from this bundle's imports.
                continue
            missing.append(o)

        # Remove existing opens that are NOT declared by an in-closure bundle
        # (these were added by an earlier buggy run and hard-error).
        lines = txt.splitlines()
        keep = []
        removed = []
        for l in lines:
            m = re.match(r"^open ((?:BookProof\.[A-Za-z0-9_.]+\s*)+)$", l)
            if not m:
                keep.append(l)
                continue
            names = re.findall(r"BookProof\.[A-Za-z0-9_.]+", m.group(1))
            if all(ns_to_bundle.get(n) in closure for n in names):
                keep.append(l)
            else:
                removed.extend(names)
        if removed:
            print(f"removed bad opens from {fn}: {removed}")
            fixed += 1
        if missing:
            # Insert after the last import line.
            last_import = 0
            for i, l in enumerate(keep):
                if l.startswith("import "):
                    last_import = i
            for o in reversed(missing):
                keep.insert(last_import + 1, f"open {o}")
            print(f"added opens to {fn}: {missing}")
            fixed += 1
        if removed or missing:
            open(path, "w", encoding="utf-8").write("\n".join(keep) + "\n")
    print(f"total: {fixed}")


if __name__ == "__main__":
    main()