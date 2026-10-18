#!/usr/bin/env python3
"""Diagnose ledger-failed sols against what the platform ACTUALLY serves.

The platform's published def bundles are not the local files: 47 of 547 carry no
declaration at all (`Def_ChapterKatoRellichDeficiency` publishes 9 lines -- the
docstring and an empty `noncomputable section` -- while the local file declares
`namespace BookProof.KatoRellich`).  A sol that says `open BookProof.KatoRellich`
or calls `potentialOp_apply` therefore dies with `unknown namespace` /
`Unknown identifier` even though its imports look complete, and every repair
attempted against the LOCAL text is aimed at the wrong file.

For each red sol this reports, per missing identifier the platform complained
about, which of four things is true:

  stub-missing     a `Theorems/Thm_BookProof_<Ch>_<decl>.lean` exists locally ->
                   add that one `import` line (the def-side repair, §2.42-3).
  bundle-hollow    the importing bundle PUBLISHES zero declarations but the local
                   file has them -> the platform copy is stale; the namespace /
                   identifier cannot exist there.  Republishing the bundle is the
                   only fix; editing the sol cannot help.
  decl-not-served  declared in the local bundle, and the platform bundle has
                   declarations, but not this one -> the published bundle predates
                   the declaration.
  absent           nowhere in stubs, bundles or the timepiece source -> the sol
                   names something that does not exist.

Usage:
  python3 debug/diagnose_failed_sols.py            # all ledger-failed sols
  python3 debug/diagnose_failed_sols.py --sols a b
"""
import argparse
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TP = os.path.join(os.path.dirname(WS), "timepiece331")
PUB = f"{WS}/state/published_bundles"

# Attributes first: a source `@[simp] lemma gaugeSchwartz_apply` was indexed as
# nothing because the regex demanded `def|lemma` right after optional
# `noncomputable`, so every attributed declaration was reported ABSENT -- which
# reads as "the name does not exist" when it is in fact a generator gap.
RE_DECL = re.compile(
    r"(?:^|\n)\s*(?:@\[[^\]]*\]\s*)?"
    r"(?:protected\s+|private\s+|noncomputable\s+)*"
    r"(?:def|abbrev|structure|class|theorem|lemma)\s+([A-Za-z_][\w'!\.]*)")


def decls(path):
    try:
        return set(RE_DECL.findall(open(path, encoding="utf-8").read()))
    except OSError:
        return set()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--sols", nargs="*", default=None)
    ap.add_argument("--ledger", default="failed")
    a = ap.parse_args()

    st = json.load(open(f"{WS}/state/pipeline.json"))["items"]
    if a.sols:
        slugs = a.sols
    else:
        slugs = sorted(k[4:] for k, v in st.items()
                       if k.startswith("sol:") and v.get("status") == a.ledger)

    # Index: bare decl -> where it is served from.
    stub = {}
    for fn in os.listdir(f"{WS}/Theorems"):
        if fn.startswith("Thm_BookProof_") and fn.endswith(".lean"):
            rest = fn[len("Thm_BookProof_"):-len(".lean")]
            ch, _, decl = rest.partition("_")
            stub.setdefault(decl, []).append((ch, fn[len("Thm_"):-len(".lean")]))

    src = {}
    for dirpath, _d, files in os.walk(os.path.join(TP, "BookProof")):
        for fn in files:
            if fn.endswith(".lean"):
                p = os.path.join(dirpath, fn)
                for d in decls(p):
                    src.setdefault(d, []).append(os.path.relpath(p, TP))

    # Which bundle publishes what, vs what it declares locally.
    pub_decl = {}
    for fn in os.listdir(PUB) if os.path.isdir(PUB) else []:
        if fn.endswith(".lean"):
            pub_decl[fn] = decls(os.path.join(PUB, fn))
    loc_decl = {fn: decls(f"{WS}/Definitions/{fn}")
                for fn in os.listdir(f"{WS}/Definitions") if fn.endswith(".lean")}

    for slug in slugs:
        path = f"{WS}/Solutions/Sol_{slug}.lean"
        if not os.path.exists(path):
            print(f"{slug}\n  NO LOCAL FILE\n")
            continue
        rec = st.get(f"sol:{slug}", {})
        err = str(rec.get("error") or "")
        idents = re.findall(r"Unknown identifier [`']([^`']+)", err)
        idents += re.findall(r"unknown namespace [`']([^`']+)", err)
        print(f"{slug}")
        # The imports the sol declares, and whether their bundles are hollow.
        imps = re.findall(r"(?m)^import\s+Definitions\.(\S+)", open(path, encoding="utf-8").read())
        hollow = [b for b in imps
                  if b + ".lean" in pub_decl and not pub_decl[b + ".lean"]]
        if hollow:
            grown = [b for b in hollow
                     if len(loc_decl.get(b + ".lean", set())) > 0]
            print(f"  hollow on the platform ({len(hollow)}): {hollow[:4]}"
                  + (f"  -- local has decls: {grown}" if grown else
                      "  -- locally empty too"))
        if not idents:
            print(f"  no identifier in the recorded error: {err[:110]}")
        for ident in sorted(set(idents)):
            base = ident.split(".")[-1]
            if base in stub:
                print(f"  STUB-MISSING   {ident:44s} -> "
                      + ",".join(c for c, _ in stub[base][:3]))
            elif any(base in d for d in pub_decl.values()):
                print(f"  SERVED         {ident:44s} (some published bundle has it)")
            elif base in src:
                print(f"  SOURCE-ONLY    {ident:44s} -> {src[base][0]}")
            else:
                print(f"  ABSENT         {ident}")
        print()
    return 0


if __name__ == "__main__":
    sys.exit(main())
