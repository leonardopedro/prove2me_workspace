#!/usr/bin/env python3
"""Repair theorem stubs whose `thm_gate.json` verdict is a REAL elaboration error.

Distinct from the provider classes (`fix_missing_provider.py` / the
`already declared` dup class): here the statement text itself does not parse or
does not typecheck, so no import or `open` can save it.  Two mechanical shapes
were measured across the pending set (2026-11-04):

* `open `BookProof.HashimotoShiftInvert`.` -- the generator emitted a
  backticked module name with a trailing period where it meant `open M`; Lean
  answers `unexpected token; expected 'private', 'scoped' or identifier` on the
  *following* token, so the error line looks unrelated to the defect.
* A theorem that builds a structure (`IsExpOfSl2 ... where`) whose stub stops
  after the first field -- `Fields missing: expE, expF`.

This script implements only the first shape — a pure textual substitution.  The
structure-field, missing-instance, truncated-proof and ambiguous-name cases are
fixed in place and re-gated with `debug/gate_thm_ok.py`; see PIPELINE_PLAN §Session
34 for the measured list.

Usage:
    python3 debug/repair_stmt_elab.py            # report only
    python3 debug/repair_stmt_elab.py --apply
"""
import argparse
import os
import re
import shutil
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BAD_OPEN = re.compile(r"^open `([^`\n]+)`\.$", re.M)


def malformed_opens():
    out = []
    d = os.path.join(WS, "Theorems")
    for fn in sorted(os.listdir(d)):
        if not fn.endswith(".lean"):
            continue
        p = os.path.join(d, fn)
        txt = open(p, encoding="utf-8").read()
        if BAD_OPEN.search(txt):
            out.append((p, txt))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true")
    a = ap.parse_args()
    rows = malformed_opens()
    for p, txt in rows:
        fixed = BAD_OPEN.sub(lambda m: "open " + m.group(1), txt)
        print(f"{os.path.basename(p)[:-5]}\t" +
              ", ".join(sorted(set(BAD_OPEN.findall(txt)))))
        if a.apply:
            bak = p + ".bak_openfix"
            if not os.path.exists(bak):
                shutil.copy2(p, bak)
            open(p, "w", encoding="utf-8").write(fixed)
    print(f"malformed `open`: {len(rows)} file(s)"
          + ("" if a.apply else "  (dry run; pass --apply)"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
