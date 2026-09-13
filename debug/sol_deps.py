#!/usr/bin/env python3
"""Which `Theorems.Thm_*` modules must a generated solution import?

The wave generator emits `import Theorems.Thm_<own chapter>_<dep>` for sibling
theorems *inside the target chapter*, but never for a declaration the target
chapter inherits from a chapter it imports.  A generated solution imports only
`Definitions.Def_<own chapter>` — definition-only bundles — so every such
reference is an `Unknown identifier` at compile time, and the compiler stops at
the first one, so it surfaces one round trip at a time.

This resolves the whole set statically.  It indexes what every `Theorems` stub
and `Definitions` bundle declares, walks each file's import closure, and reports
the references that are declared in the project but unreachable from the file.

Precision comes from the runbook's own ambiguity rule: a candidate is only
reported when the file **already opens the declaring namespace**.  A file that
opens `BookProof.ChapterH6` clearly intends `sirk_error_decay_exponential` to be
in scope and merely lacks the import; a same-named declaration in a namespace the
file never opens is a coincidence, and importing it could introduce an
ambiguity.  Comments are stripped, the file's own target theorem is excluded
(never import your own target), and local binders are excluded.

Usage:
  python3 debug/sol_deps.py Solutions/Sol_BookProof_ChapterSirkEndToEnd_*.lean
  python3 debug/sol_deps.py --chapter ChapterSirkEndToEnd ChapterSirkPerSystem
  python3 debug/sol_deps.py --all          # every solution, summary only
"""
import glob
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

DECL = re.compile(
    r"(?m)^\s*(?:noncomputable\s+|private\s+|protected\s+|@\[[^\]]*\]\s*)*"
    r"(?:def|abbrev|theorem|lemma|structure|inductive|class|instance)\s+"
    r"([A-Za-z_][A-Za-z0-9_'.]*)")
IMPORT = re.compile(r"(?m)^import\s+(Definitions\.Def_\S+|Theorems\.Thm_\S+)")
TOKEN = re.compile(r"\b([a-zA-Z_][A-Za-z0-9_']*)\b")
LINE_COMMENT = re.compile(r"(?m)--.*$")
BLOCK_COMMENT = re.compile(r"/-.*?-/", re.S)
GEN_HEADER = re.compile(r"solution of (\S+)")
OPEN = re.compile(r"(?m)^open\s+(.+?)\s*$")
BINDERS = re.compile(r"(?ms)theorem\s+solution\b(.*?)\s*:\s*\n")

STOP = {
    "import", "namespace", "end", "variable", "theorem", "def", "abbrev",
    "structure", "inductive", "class", "instance", "lemma", "noncomputable",
    "section", "open", "by", "fun", "let", "have", "show", "exact", "rw",
    "simp", "intro", "apply", "refine", "constructor", "simpa", "using",
    "where", "then", "else", "if", "match", "with", "deriving", "attribute",
    "scoped", "notation", "infix", "prefix", "postfix", "macro", "syntax",
    "elab", "Mathlib", "True", "False", "and", "or", "not", "iff", "forall",
    "exists", "Nat", "Int", "Real", "Complex", "Set", "Finset", "List",
    "Prop", "Type", "Sort", "Fin", "Function", "Submodule", "Continuous",
    "Dense", "IsClosed", "MvPolynomial", "EuclideanSpace", "norm", "inner",
    "Measure", "volume", "Lp", "map", "comp", "id", "prod", "sum", "of",
}


def strip_comments(txt):
    return LINE_COMMENT.sub("", BLOCK_COMMENT.sub("", txt))


def index():
    """name -> (module, qualified prefix).  Longest qualified form wins."""
    decls, imports_of = {}, {}
    for root in ("Definitions", "Theorems"):
        for fn in sorted(os.listdir(os.path.join(WS, root))):
            if not fn.endswith(".lean"):
                continue
            mod = f"{root}.{fn[:-len('.lean')]}"
            txt = strip_comments(open(os.path.join(WS, root, fn), encoding="utf-8").read())
            for raw in DECL.findall(txt):
                short = raw.split(".")[-1]
                prefix = raw.rsplit(".", 1)[0] if "." in raw else ""
                prev = decls.get(short)
                if prev is None or len(prefix) > len(prev[1]):
                    decls[short] = (mod, prefix)
            imports_of[mod] = set(IMPORT.findall(txt))
    return decls, imports_of


def reachable(mod, imports_of, seen):
    for dep in imports_of.get(mod, ()):
        if dep not in seen:
            seen.add(dep)
            reachable(dep, imports_of, seen)
    return seen


def opened_namespaces(txt):
    nss = set()
    for line in OPEN.findall(txt):
        for ns in line.split():
            if ns.startswith("BookProof"):
                nss.add(ns)
    return nss


def local_binders(txt):
    m = BINDERS.search(txt)
    if not m:
        return set()
    body = m.group(1)
    names = set()
    # `(x y : T)`, `{E : Type*}`, `[NormedAddCommGroup E]` — take the binder
    # names (identifiers before the `:`), not the types.
    for grp in re.finditer(r"[\(\{\[]([^\(\)\{\}\[\]]*)[\)\}\]]", body):
        seg = grp.group(1)
        for part in seg.split(":"):
            for t in TOKEN.findall(part):
                names.add(t)
    return names


def analyse(path, decls, imports_of):
    raw = open(path, encoding="utf-8").read()
    txt = strip_comments(raw)
    hdr = GEN_HEADER.search(raw)
    target = hdr.group(1).split(".")[-1] if hdr else None

    reach = set()
    for dep in IMPORT.findall(txt):
        reach.add(dep)
        reachable(dep, imports_of, reach)

    skip = local_binders(txt) | {target}
    opens = opened_namespaces(txt)
    used = set()
    for t in TOKEN.findall(txt):
        if len(t) <= 2 or t in STOP:
            continue
        # A name that only ever appears as a match-arm pattern (`| add p q =>`)
        # is a constructor case, not a reference to a declaration of that name.
        pat = r'(?<![\w.\'"])(?<![\w.])' + re.escape(t) + r'(?![\w\'])'
        hits = [m.start() for m in re.finditer(pat, txt)]
        if hits and all(re.search(r"\|\s*$", txt[max(0, h - 4):h]) for h in hits):
            continue
        used.add(t)

    missing = {}
    for n in used:
        if n in skip:
            continue
        prov = decls.get(n)
        if not prov:
            continue
        mod, prefix = prov
        if mod in reach or not prefix:
            continue
        # Only when the file already opens the declaring namespace (or a parent
        # of it) — that is the intent signal, and it keeps name collisions out.
        if not any(prefix == ns or prefix.startswith(ns + ".") for ns in opens):
            continue
        missing.setdefault(mod, set()).add(n)
    return missing


def main():
    args = sys.argv[1:]
    files, summary = [], False
    if args and args[0] == "--all":
        summary = True
        files = sorted(glob.glob(os.path.join(WS, "Solutions", "*.lean")))
    elif args and args[0] == "--chapter":
        for ch in args[1:]:
            files += sorted(glob.glob(os.path.join(WS, "Solutions", f"Sol_BookProof_{ch}_*.lean")))
    else:
        for a in args:
            files += sorted(glob.glob(a if os.path.isabs(a) else os.path.join(WS, a)))
    if not files:
        print(__doc__)
        return 2

    decls, imports_of = index()
    total = 0
    dirty = []
    for path in files:
        missing = analyse(path, decls, imports_of)
        if not missing:
            if not summary:
                print(f"{os.path.basename(path)}\n  ok")
            continue
        dirty.append((path, missing))
        total += sum(len(v) for v in missing.values())
    if summary:
        print(f"{len(files)} solution(s) scanned, {len(dirty)} need cross-chapter imports, "
              f"{total} unresolved reference(s)")
        per = {}
        for path, missing in dirty:
            for mod in missing:
                per[mod] = per.get(mod, 0) + 1
        for mod, n in sorted(per.items(), key=lambda kv: -kv[1]):
            print(f"   {n:4}x import {mod}")
    else:
        for path, missing in dirty:
            print(os.path.basename(path))
            for mod in sorted(missing):
                print(f"  import {mod}")
                print(f"        provides: {', '.join(sorted(missing[mod]))}")
        print(f"\n{len(files)} file(s), {len(dirty)} needing imports, {total} reference(s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
