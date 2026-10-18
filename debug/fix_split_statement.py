#!/usr/bin/env python3
"""Repair the split-statement corruption family (PIPELINE_PLAN §2.52-4).

Shape, measured on 74 Solutions files (FockSecondQuantization, SirkGramWhitening,
YangMillsFriedrichsLimit, ...):

    gramOp w = Matrix.toEuclideanCLM (klass := klass) (gramMatrix w) :=
      CLM (klass := ℂ) (gramMatrix w) := by
      <proof>

The statement line lost its trailing ` by` and the NEXT line carries a
left-truncated duplicate of the statement's tail ending in `:= by`.  Neither
line parses alone: Lean reports the fragment's first token as an unknown
identifier (`A j v))` -> `Unknown identifier 'A'`, `sDerivAt` -> ...), which
is why these surfaced across miss-ident/parse classes instead of one bucket.

Repair, verify-first per file:
  1. candidate = statement line + ` by`;
  2. the fragment (stripped) must be a SUFFIX of candidate -- that is exactly
     the duplication invariant; if the fragment itself ends in `:=` (the `by`
     was cut off too), `fragment + " by"` must be the suffix instead;
  3. on success: back up to `<file>.bak_splitfix` (first hit only) and write
     the merged line; on failure: report, touch nothing (§5d manual).

Usage:
  python3 debug/fix_split_statement.py            # dry run: census + reports
  python3 debug/fix_split_statement.py --apply    # repair what verifies
  python3 debug/fix_split_statement.py --apply Solutions/Sol_X.lean ...
"""
import glob
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ASSIGN_END = re.compile(r":=\s*$")
FRAG = re.compile(r"^\s{2,}\S.*:=\s*(by)?\s*$")


def hits_in(path):
    lines = open(path, encoding="utf-8").read().splitlines()
    out = []
    for i in range(len(lines) - 1):
        if ASSIGN_END.search(lines[i]) and FRAG.match(lines[i + 1]) \
                and "theorem" not in lines[i + 1][:12]:
            out.append(i)
    return lines, out


def reconstruct(stmt, frag):
    """(merged_line, None) if the duplication invariant holds, else (None, why)."""
    cand = stmt.rstrip() + " by"
    f = frag.strip()
    if cand.endswith(f):
        return cand, None
    if cand.endswith(f + " by"):        # fragment lost its own trailing `by`
        return cand, None
    return None, f"fragment not a suffix of statement (frag={f[:50]!r})"


def main(argv):
    apply = "--apply" in argv
    paths = [a for a in argv if not a.startswith("--")]
    if paths:
        files = paths
    else:
        files = sorted(glob.glob(os.path.join(WS, "Solutions", "*.lean"))
                       + glob.glob(os.path.join(WS, "Theorems", "*.lean"))
                       + glob.glob(os.path.join(WS, "Definitions", "*.lean")))
    fixed, reported, skipped = [], [], []
    for p in files:
        rel = os.path.relpath(p, WS)
        if os.path.exists(p + ".bak_splitfix"):
            pass  # still repairable: backup exists from an earlier partial run
        lines, idxs = hits_in(p)
        if not idxs:
            continue
        new = list(lines)
        bad = []
        for i in sorted(idxs, reverse=True):
            merged, why = reconstruct(lines[i], lines[i + 1])
            if merged is None:
                bad.append((i + 1, why))
                continue
            new[i:i + 2] = [merged]
        if bad:
            reported.append((rel, bad))
            continue
        if not apply:
            skipped.append((rel, len(idxs)))
            continue
        bak = p + ".bak_splitfix"
        if not os.path.exists(bak):
            with open(bak, "w", encoding="utf-8") as fh:
                fh.write("\n".join(lines) + "\n")
        with open(p, "w", encoding="utf-8") as fh:
            fh.write("\n".join(new) + "\n")
        fixed.append((rel, len(idxs)))
    for rel, n in skipped:
        print(f"  WOULD-FIX  {rel}  ({n} split region{'s' if n > 1 else ''})")
    for rel, bad in reported:
        for ln, why in bad:
            print(f"  MANUAL     {rel}:{ln + 1}  {why}")
    for rel, n in fixed:
        print(f"  FIXED      {rel}  ({n} split region{'s' if n > 1 else ''})")
    print(f"\nfixed={len(fixed)} would-fix={len(skipped)} manual={len(reported)}")
    return 1 if reported else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
