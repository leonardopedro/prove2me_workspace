#!/usr/bin/env python3
"""Find sols that use a NAMESPACED declaration without opening its namespace.

The class-D repairs found three separate ways a generated file can lose access to
a name it clearly means:

  * the module declaring it is never imported        (`fix_missing_provider.py`)
  * the module is imported but the name is namespaced (`lpFiniteModes` lives at
    `BookProof.NavierStokesFlow`, `mulRep` at `BookProof.ChapterAbelianGelfandModel`)
    -- an import alone is not enough, the file must `open` that namespace

This tool detects the second shape statically against the SERVED bundle text:
for every `Solutions/Sol_*.lean` it collects the bare identifiers the file uses,
keeps those whose only served declarations sit inside a namespace, and reports
the file when it neither opens that namespace nor declares it itself.  The
provider bundle must already be imported, otherwise the defect is the import
class and `fix_missing_provider.py` owns it.

Verification is by compile: a candidate is only real if the mirror says
`Unknown identifier <name>`.  `--verify` does that per candidate (slow, exact).

READ-ONLY.

Usage:
  python3 debug/find_missing_opens.py                        # report all sols
  python3 debug/find_missing_opens.py --status pending       # ledger filter
  python3 debug/find_missing_opens.py --status pending --verify
"""
import argparse
import glob
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import audit_dup_providers as A  # noqa: E402

WS = A.WS
LEDGER = f"{WS}/state/pipeline.json"

OPEN = re.compile(r"(?m)^open\s+([A-Za-z0-9_.]+)\s*$")
NSDECL = re.compile(r"(?m)^namespace\s+([A-Za-z0-9_.]+)")
IMPORT = re.compile(r"(?m)^import\s+(\S+)")
DECLLINE = re.compile(
    r"(?m)^(?:@\[[^\]]*\]\s*)?(?:noncomputable\s+|protected\s+|private\s+)*"
    r"(?:def|theorem|lemma|abbrev|structure|class|inductive|opaque|instance)\s+([^\s:({⟨\[]+)")
IDENT = re.compile(r"(?<![\w.'])([A-Za-z_][A-Za-z0-9_']*)(?![\w'])")
COMMENT = re.compile(r"/-.*?-/|--[^\n]*", re.S)


def served_index():
    """bare name -> set of (fq, namespace, module) over the served bundles."""
    idx = {}
    for bundle, (decls, _path) in A.published_bundles().items():
        mod = f"Definitions.Def_{bundle}"
        for fq, _kind in decls:
            if "." not in fq:
                continue
            ns, _, bare = fq.rpartition(".")
            idx.setdefault(bare, set()).add((fq, ns, mod))
    return idx


def ledger_status():
    items = json.load(open(LEDGER, encoding="utf-8")).get("items", {})
    return {k[len("sol:"):]: v.get("status") for k, v in items.items()
            if k.startswith("sol:")}


def scan_file(path, idx):
    raw = open(path, encoding="utf-8").read()
    txt = COMMENT.sub("", raw)
    opened = {m.group(1) for m in OPEN.finditer(txt)}
    declared_ns = {m.group(1) for m in NSDECL.finditer(txt)}
    imports = {m.group(1) for m in IMPORT.finditer(txt)}
    own_names = {m.group(1) for m in DECLLINE.finditer(txt)}
    hits = {}
    for m in IDENT.finditer(txt):
        tok = m.group(1)
        if tok in hits or tok in own_names:
            continue
        provs = idx.get(tok)
        if not provs:
            continue
        for fq, ns, mod in sorted(provs):
            if mod not in imports:
                continue                    # import class, not this one
            if ns in opened or ns in declared_ns:
                continue
            if any(ns == o or ns.startswith(o + ".") for o in opened):
                # `open A` with the decl in `A.B.C` does NOT expose it; only the
                # exact namespace (or the file's own) does.
                pass
            hits[tok] = f"{ns} ({mod.split('.')[-1]})"
            break
    return hits


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--status", help="only sols with this ledger status")
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--verify", action="store_true")
    args = ap.parse_args()

    idx = served_index()
    status = ledger_status() if args.status else None
    rows = []
    for f in sorted(glob.glob(f"{WS}/Solutions/Sol_*.lean")):
        slug = os.path.basename(f)[len("Sol_"):-len(".lean")]
        if status is not None and status.get(slug) != args.status:
            continue
        hits = scan_file(f, idx)
        if hits:
            rows.append((slug, status.get(slug) if status else None, hits))
    if args.limit:
        rows = rows[:args.limit]
    for slug, st, hits in rows:
        print(f"{str(st):8s} {slug}")
        for tok, where in sorted(hits.items()):
            print(f"          {tok:28s} <- {where}")
    print(f"\ncandidates: {len(rows)}")

    if args.verify and rows:
        sys.path.insert(0, f"{WS}/pipeline")
        import upload_pipeline as up
        print("\n-- compile check --")
        for slug, _st, hits in rows:
            path = f"{WS}/Solutions/Sol_{slug}.lean"
            ok, err = up.local_compile(path)
            names = re.findall(r"Unknown (?:identifier|constant) [`']([^`']+)[`']", err or "")
            real = sorted(set(names) & set(hits))
            print(f"  {'FAIL' if not ok else 'OK  '} {slug}"
                  + (f"  real={real}" if real else f"  ({', '.join(sorted(hits))})"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
