#!/usr/bin/env python3
"""Fine-grained taxonomy of FAILED publish jobs (read-only).

Unlike debug/job_failures.py (which buckets by coarse class), this script
sub-classifies each failure by the SHAPE of the server's error message so a
generator defect can be matched to the code that emits it.  Output:
counts per (kind, shape), samples, and --dump FILE for offline inspection.

Usage: python3 debug/failure_taxonomy.py [--dump /tmp/fails.json] [--kind problem]
"""
import argparse
import json
import os
import re
import sys
from collections import Counter, defaultdict

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402

# Order matters: first matching rule names the shape.
SHAPES = [
    (r"has already been declared", "DUPLICATE_DECL"),
    (r"theorem_name must be a valid Lean identifier", "BAD_THEOREM_NAME"),
    (r"Imported platform theorems must be Proved", "IMPORTED_THM_NOT_PROVED"),
    (r"theorem dependency not proved yet", "DEP_NOT_PROVED"),
    (r"Import parser timed out", "IMPORT_PARSER_TIMEOUT"),
    (r"could not lex|Token scanner failed", "LEX_FAILURE"),
    (r"unexpected token|unexpected identifier", "SYNTAX_ERROR"),
    (r"Unknown identifier `([^`]*)`", "UNKNOWN_IDENTIFIER"),
    (r"Unknown constant `([^`]*)`", "UNKNOWN_CONSTANT"),
    (r"unknown namespace ([^\s;]+)", "UNKNOWN_NAMESPACE"),
    (r"Ambiguous term ([^\s;]+)", "AMBIGUOUS_NAME"),
    (r"Invalid field `([^`]*)`", "INVALID_FIELD"),
    (r"Invalid argument name `([^`]*)`", "INVALID_ARG_NAME"),
    (r"Function expected at\s*([^\s;]+)", "FUNCTION_EXPECTED"),
    (r"failed to synthesize instance of type class ([^\s;]+)", "MISSING_INSTANCE"),
    (r"Application type mismatch", "APP_TYPE_MISMATCH"),
    (r"type mismatch", "TYPE_MISMATCH"),
    (r"unsolved goals", "UNSOLVED_GOALS"),
    (r"unknown identifier", "UNKNOWN_IDENTIFIER"),
    (r"unknown/unavailable import|unknown import", "UNKNOWN_IMPORT"),
    (r"duplicate|already exists", "DUPLICATE"),
    (r"timeout", "TIMEOUT"),
    (r"sorry", "SORRY"),
]


def shape_of(msg):
    m = msg or ""
    for pat, label in SHAPES:
        g = re.search(pat, m, re.I)
        if g:
            extra = g.group(1) if g.groups() else ""
            return label, extra
    return "OTHER", (re.sub(r"\s+", " ", m.strip())[:70])


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dump", help="write full failing jobs as JSON here")
    ap.add_argument("--kind", choices=["definition", "problem"], default=None)
    ap.add_argument("--samples", type=int, default=3)
    args = ap.parse_args()

    ok, _, detail = up.auth_probe()
    if not ok:
        print(f"auth failed: {detail}")
        return 2

    all_jobs = []
    for kind in ("definition", "problem"):
        if args.kind and args.kind != kind:
            continue
        page = up._paged("publish-jobs", {"kind": kind})
        all_jobs.extend(page)
        print(f"read {len(page)} {kind} job(s)")

    fails = [j for j in all_jobs if j.get("status") == "FAILED"]
    print(f"total FAILED jobs (all attempts): {len(fails)}")

    counts = defaultdict(Counter)
    samples = defaultdict(list)
    extras = defaultdict(Counter)
    for j in fails:
        kind = j.get("kind") or "?"
        shape, extra = shape_of(j.get("error_message") or j.get("error") or "")
        counts[kind][shape] += 1
        extras[kind][(shape, extra)] += 1
        if len(samples[(kind, shape)]) < args.samples:
            samples[(kind, shape)].append(
                (j.get("theorem_name"), (j.get("error_message") or "")[:220]))

    for kind in sorted(counts):
        print(f"\n=== {kind}: {sum(counts[kind].values())} failed job(s)")
        for shape, n in counts[kind].most_common():
            print(f"  {n:5d}  {shape}")
        print(f"  --- top (shape, token) pairs:")
        for (shape, extra), n in extras[kind].most_common(25):
            print(f"  {n:5d}  {shape} :: {extra}")

    if args.dump:
        with open(args.dump, "w") as f:
            json.dump(fails, f, indent=1)
        print(f"\ndumped {len(fails)} job record(s) -> {args.dump}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
