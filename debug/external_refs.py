#!/usr/bin/env python3
"""Which upstream def bundles must a def bundle import?  (§5d, mechanised.)

A def bundle referencing project names it does not declare (and does not import
them) compiles nowhere: the platform reports the first one as
`Unknown identifier`, one error per round trip.  This lists every referenced
name that is declared in another `Definitions/Def_*.lean`, together with the
bundle that declares it and that bundle's namespace — i.e. exactly the
`import` + `open` pair to add.

It is a *static approximation* of the compiler, deliberately: it over-reports
(names common with Mathlib included), so treat the output as candidates, not
proofs.  Runbook §5d still applies — the compiler is the only oracle.

Usage: python3 debug/external_refs.py Definitions/Def_ChapterQgHermiteFriedrichs.lean
"""
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DECL = re.compile(r"(?m)^\s*(?:noncomputable\s+|private\s+|protected\s+|@\[[^\]]*\]\s*)*"
                  r"(?:def|abbrev|theorem|lemma|structure|inductive|class|instance|notation)\s+"
                  r"([A-Za-z_][A-Za-z0-9_'.]*)")
NS = re.compile(r"(?m)^namespace\s+(\S+)")
TOKEN = re.compile(r"\b([a-zA-Z_][A-Za-z0-9_']*)\b")
IMPORT = re.compile(r"(?m)^import\s+Definitions\.Def_(\S+)")

# Lean keywords / very common Mathlib names that would otherwise dominate output
STOP = {
    "import", "namespace", "end", "variable", "theorem", "def", "abbrev", "structure",
    "inductive", "class", "instance", "lemma", "noncomputable", "section", "open",
    "by", "fun", "let", "have", "show", "exact", "rw", "simp", "intro", "apply",
    "refine", "constructor", "simp", "simpa", "using", "where", "then", "else",
    "if", "match", "with", "deriving", "attribute", "scoped", "notation", "infix",
    "prefix", "postfix", "macro", "syntax", "elab", "termination_by", "decreasing_by",
    "Mathlib", "Prop", "Type", "Sort", "True", "False", "and", "or", "not", "iff",
    "forall", "exists", "Nat", "Int", "Real", "Complex", "Set", "Finset", "List",
    "Continuous", "Dense", "IsClosed", "Function", "Submodule", "LinearMap", "inner",
    "norm", "volume", "Measure", "MvPolynomial", "EuclideanSpace", "Fin", "Lp", "Memℓp",
}


def declarations(path):
    txt = open(path, encoding="utf-8").read()
    return {m.split(".")[0] for m in DECL.findall(txt)}, txt


def main():
    if len(sys.argv) != 2:
        print(__doc__)
        return 2
    target = sys.argv[1]
    if not os.path.isabs(target):
        target = os.path.join(WS, target)
    if not os.path.exists(target):
        print(f"no such file: {target}")
        return 1

    local, txt = declarations(target)
    own_imports = set(IMPORT.findall(txt))
    used = {t for t in TOKEN.findall(txt) if len(t) > 2 and t not in STOP}

    providers = {}
    for fn in sorted(os.listdir(os.path.join(WS, "Definitions"))):
        if not fn.startswith("Def_") or not fn.endswith(".lean"):
            continue
        bundle = fn[len("Def_"):-len(".lean")]
        names, other = declarations(os.path.join(WS, "Definitions", fn))
        ns = NS.search(other)
        for n in names & used:
            providers.setdefault(n, (bundle, ns.group(1) if ns else "?"))

    externals = {n: p for n, p in providers.items() if p[0] != os.path.basename(target)[len("Def_"):-len(".lean")]}
    needed_bundles = sorted({p[0] for p in externals.values()})
    print(f"{os.path.basename(target)}")
    print(f"  imports            : {sorted(own_imports) or ['(none beyond Mathlib)']}")
    print(f"  external references: {len(externals)} name(s) from {len(needed_bundles)} bundle(s)")
    for n, (bundle, ns) in sorted(externals.items(), key=lambda kv: kv[1][0]):
        state = "imported" if bundle in own_imports else "**NOT IMPORTED**"
        print(f"    {n:38s} <- {bundle:32s} ns={ns:42s} {state}")
    print("\n  suggested (deps-first):")
    for b in needed_bundles:
        if b not in own_imports:
            ns = next(p[1] for p in externals.values() if p[0] == b)
            print(f"    import Definitions.Def_{b}")
            print(f"    open {ns}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
