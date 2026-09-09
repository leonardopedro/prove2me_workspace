#!/usr/bin/env python3
"""Add missing `import Definitions.Def_*` + `open BookProof.*` lines to def
bundles — v3 (namespace-aware).

The def bundles were generated with skeleton subtraction that DROPPED the
source chapters' cross-chapter `open BookProof.X` lines and the corresponding
imports.  When a bundle references a name defined in another chapter (not
inlined), it fails with "Unknown identifier".  v3 fixes exactly that:

  for each bundle on the command line (default debug/upstream_list.txt):
    1. build a global name -> (chapter, namespace) index from ALL local Def
       bundles (namespace nesting tracked),
    2. find every identifier the bundle references that is defined in some
       OTHER chapter and NOT declared in the bundle itself,
    3. add `import Definitions.Def_<chapter>` for each such chapter and
       `open <fully.qualified.namespace>` lines for the namespaces that
       provide the referenced names (skipping namespaces already opened),
    4. clean junk preambles (duplicate `import Mathlib`, `import BookProof.*`).

Names already declared inside the bundle are left alone (importing their
chapter as well would make references ambiguous — the v1 lesson).

Usage:  python3 debug/sync_imports_v3.py [ChapterA ChapterB ...]
"""
import os
import re
import sys
from collections import defaultdict

WS = "/home/leo/prove2me_workspace"
DEFDIR = f"{WS}/Definitions"
LIST_DEFAULT = f"{WS}/debug/upstream_list.txt"

DECL_RE = re.compile(
    r"^(?:noncomputable\s+)?(?:private\s+)?(?:abbrev|def|theorem|lemma|structure|class|inductive|instance)\s+([A-Za-z_][A-Za-z0-9_']*)",
    re.M)
OPEN_RE = re.compile(r"^(open\s+.+|open\s+scoped\s+.+)$", re.M)
IDENT_RE = re.compile(r"\b([A-Za-z_][A-Za-z0-9_']*)\b")


def chapters():
    if len(sys.argv) > 1:
        return [c for c in sys.argv[1:] if c]
    with open(LIST_DEFAULT) as f:
        return [ln.strip() for ln in f if ln.strip()]


def local_def_chapters():
    return {fn[4:-5] for fn in os.listdir(DEFDIR)
            if fn.startswith("Def_") and fn.endswith(".lean")}


def parse_bundle(text):
    """Return (declname -> fq namespace, set of opened namespace strings)."""
    ns_of = {}
    stack = []
    lines = text.splitlines()
    for ln in lines:
        s = ln.strip()
        m = re.match(r"^namespace\s+([A-Za-z0-9_.']+)$", s)
        if m:
            stack.append(m.group(1))
            continue
        m = re.match(r"^end\s+([A-Za-z0-9_.']+)$", s)
        if m and stack and stack[-1].endswith(m.group(1).split(".")[-1]):
            stack.pop()
            continue
        m = DECL_RE.match(s)
        if m:
            fqns = ".".join(stack)
            ns_of.setdefault(m.group(1), fqns)
    opened = set()
    for m in OPEN_RE.finditer(text):
        for tok in m.group(1).split()[1:]:
            if tok == "scoped":
                continue
            opened.add(tok)
    return ns_of, opened


def strip_junk(text):
    lines = text.splitlines()
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
    have = sorted(local_def_chapters())
    # global index: declname -> list of (chapter, fqns)
    index = defaultdict(list)
    parsed = {}
    for c in have:
        p = f"{DEFDIR}/Def_{c}.lean"
        ns_of, opened = parse_bundle(open(p).read())
        parsed[c] = (ns_of, opened)
        for n, f in ns_of.items():
            index[n].append((c, f))

    for chap in chapters():
        path = f"{DEFDIR}/Def_{chap}.lean"
        if not os.path.exists(path):
            print(f"SKIP {chap}: no Def file")
            continue
        text = open(path).read()
        orig = text
        text = strip_junk(text)
        own_ns, own_open = parse_bundle(text)
        own_names = set(own_ns)
        existing = set(re.findall(r"^import Definitions\.Def_([A-Za-z0-9]*)", text, re.M))
        ident = set(IDENT_RE.findall(text))
        add_imports, opens = set(), set()
        for n in sorted(ident & set(index)):
            if n in own_names:
                continue
            for (c, f) in index[n]:
                if c == chap:
                    continue
                short = f.rsplit(".", 1)[-1] if f else ""
                if f and (f in own_open or short in own_open or short in ident):
                    # already opened (possibly relatively) — just need import
                    add_imports.add(c)
                    continue
                add_imports.add(c)
                opens.add(f)
        add_imports -= existing
        add_imports.discard(chap)
        if add_imports or opens:
            pos = 0
            for m in re.finditer(r"^import .*$", text, re.M):
                pos = m.end()
            ins = "\n".join(sorted(f"import Definitions.Def_{c}" for c in add_imports))
            if opens:
                ins += "\n" + "\n".join(sorted(f"open {f}" for f in opens if f))
            head, tail = text[:pos], text[pos:]
            text = head + "\n" + ins + tail
        if text != orig:
            with open(path, "w") as f:
                f.write(text)
            print(f"SYNC {chap}: imports={sorted(add_imports)} opens={sorted(opens)}")
        else:
            print(f"ok   {chap}")


if __name__ == "__main__":
    main()
