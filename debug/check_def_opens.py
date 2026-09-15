"""Check that every `open BookProof.X` in a Definitions/ or Theorems/ file is
declared by a module the file imports **directly** (SKILL.md §1e).

Why this class exists (measured, not theorised): the platform compiles ONE
module at a time and does not carry a transitive import's namespaces into scope.
A bundle that opens a namespace its *indirect* dependency declares is rejected
with `unknown namespace BookProof.X` even though the import chain looks right.
That is what parked `def:ChapterHermiteBandCalculusHigher` at attempt 5 — it
opens `BookProof.HermiteBand` (declared by the published bundle
`ChapterHermiteBandCalculus`) while importing only `Def_ChapterFarisLavine`,
`Def_ChapterHermiteProductBasis`, `Def_ChapterHermiteProductCore`,
`Def_ChapterNavierStokes*`, `Def_ChapterYangMillsHermite`.

Ground truth is the PLATFORM, not the checkout: `state/defs_index.json` (built by
`debug/platform_def_index.py`) records, per published bundle, the namespaces its
source text declares.  A local Definitions file may be empty, stale, or
self-contained, so it is never trusted here.

Outcomes per opened namespace:
  OK                 an imported module owns it
  ALIASED            the same namespace under the generator's synthetic
                     `Chapter` infix (BookProof.A.B <-> BookProof.ChapterA.B);
                     the direct import is present, so nothing to do
  MISSING IMPORT     the owner bundle is published but not imported directly
                     -> `--fix` inserts `import Definitions.Def_<owner>`
  NO PROVIDER        no published bundle declares it; not fixable here
                     (needs the declaring bundle regenerated/published first)

Usage:
  python3 debug/check_def_opens.py                  # all Definitions/Def_Chapter*.lean
  python3 debug/check_def_opens.py --theorems       # Theorems/Thm_*.lean instead
  python3 debug/check_def_opens.py --only SUBSTR    # repeatable filter on the file name
  python3 debug/check_def_opens.py --fix            # insert the missing imports (.bak kept)
"""
import argparse
import collections
import json
import os
import re
import sys

WS = (os.environ.get("PROVE2ME_WS")
      or os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
INDEX = f"{WS}/state/defs_index.json"
IMPORT_RE = re.compile(r"^import\s+(\S+)", re.M)
OPEN_RE = re.compile(r"^open\s+([^\n]+)", re.M)
SKIP_TOKENS = {"scoped", "in", "hiding", "renaming"}


def load_owners():
    if not os.path.exists(INDEX):
        sys.exit(f"no platform index at {INDEX} - run debug/platform_def_index.py first")
    idx = json.load(open(INDEX))
    owners = dict(idx.get("namespace_owner") or {})
    return owners, idx


def alias_variants(ns):
    """BookProof.A.B <-> BookProof.ChapterA.B, component-wise (§1j)."""
    parts = ns.split(".")
    out = []
    for i in range(1, len(parts)):          # never the `BookProof` head
        if parts[i].startswith("Chapter") and len(parts[i]) > len("Chapter"):
            v = list(parts)
            v[i] = parts[i][len("Chapter"):]
            out.append(".".join(v))
        else:
            v = list(parts)
            v[i] = "Chapter" + parts[i]
            out.append(".".join(v))
    return out


def owner_of(ns, owners):
    """(owner, aliased) for a namespace, or (None, False)."""
    if ns in owners:
        return owners[ns], False
    for v in alias_variants(ns):
        if v in owners:
            return owners[v], True
    return None, False


def imports_of(text):
    return set(IMPORT_RE.findall(text))


def opens_of(text):
    body = IMPORT_RE.sub("", text)
    toks = collections.Counter()
    for line in OPEN_RE.findall(body):
        for t in line.split():
            t = t.strip("(){},")
            if t in SKIP_TOKENS or not t:
                continue
            toks[t] += 1
    return toks


def check(path, owners):
    text = open(path, encoding="utf-8", errors="replace").read()
    have = imports_of(text)
    rows = []
    for tok in opens_of(text):
        if not tok.startswith("BookProof."):
            continue
        owner, aliased = owner_of(tok, owners)
        if owner is None:
            rows.append(("NO PROVIDER", tok, None))
            continue
        need = f"Definitions.Def_{owner}"
        if need in have or f"Definitions.Def_{owner}" in have:
            rows.append(("ALIASED" if aliased else "OK", tok, owner))
        else:
            rows.append(("MISSING IMPORT", tok, owner))
    return rows, have


def insert_imports(path, owners_to_add):
    text = open(path, encoding="utf-8", errors="replace").read()
    lines = text.split("\n")
    at = 0
    for i, ln in enumerate(lines):
        if ln.startswith("import "):
            at = i + 1
        else:
            break
    new = [f"import Definitions.Def_{o}" for o in sorted(owners_to_add)]
    if os.path.exists(path + ".bak_opens") is False:
        open(path + ".bak_opens", "w").write(text)
    lines[at:at] = new
    open(path, "w").write("\n".join(lines))
    return new


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--theorems", action="store_true",
                    help="check Theorems/Thm_*.lean instead of Definitions/")
    ap.add_argument("--solutions", action="store_true",
                    help="check Solutions/Sol_*.lean instead of Definitions/")
    ap.add_argument("--pending", action="store_true",
                    help="with --solutions: only files backing a non-done plan item")
    ap.add_argument("--only", action="append", default=None, metavar="SUBSTR")
    ap.add_argument("--fix", action="store_true",
                    help="insert the missing direct imports (writes a .bak_opens)")
    args = ap.parse_args()

    owners, idx = load_owners()
    print(f"platform index: {len(owners)} namespace owners, "
          f"{idx.get('job_total')} definition job(s)")
    if args.solutions:
        d, pre = "Solutions", "Sol_"
    elif args.theorems:
        d, pre = "Theorems", "Thm_"
    else:
        d, pre = "Definitions", "Def_"
    files = sorted(f for f in os.listdir(f"{WS}/{d}") if f.startswith(pre) and f.endswith(".lean"))
    if args.only:
        files = [f for f in files if any(s in f for s in args.only)]
    if args.pending:
        state = json.load(open(f"{WS}/state/pipeline.json"))["items"]
        live = {k[len("sol:"):] for k, v in state.items()
                if k.startswith("sol:") and v.get("status") != "done"}
        files = [f for f in files if f[len(pre):-len(".lean")] in live]
    counts = collections.Counter()
    fixed = 0
    for f in files:
        rows, have = check(f"{WS}/{d}/{f}", owners)
        if not rows:
            continue
        missing = sorted({o for kind, _, o in rows if kind == "MISSING IMPORT"})
        for kind, _, _ in rows:
            counts[kind] += 1
        if not missing:
            continue
        print(f"\n{f}: {'MISSING ' + ', '.join(missing)}")
        for kind, tok, owner in rows:
            if kind in ("MISSING IMPORT", "NO PROVIDER"):
                print(f"    {kind:14s} {tok}" + (f"  (owner {owner})" if owner else ""))
        if args.fix:
            added = insert_imports(f"{WS}/{d}/{f}", missing)
            fixed += 1
            print(f"    + {', '.join(added)}")
    print(f"\n{len(files)} file(s) checked: " + ", ".join(f"{k}={v}" for k, v in sorted(counts.items()))
          + (f"; {fixed} file(s) repaired" if args.fix else "; nothing written (--fix to insert)"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
