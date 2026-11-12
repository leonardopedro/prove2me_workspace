#!/usr/bin/env python3
"""`_inc` twins for the duplicated-`variable` class of PUBLISHED theorems.

The published node's preamble carries the section `variable` block twice, so
its elaborated target is `... (hdense : Dense D) ... → P (Hs_1) (D_1) (A_1)`
— hypotheses about one `(Hs, D, A)` and a conclusion about another.  No proof
can exist, and the node can never leave `sol: pending`.

Because the statement (hence the theorem NAME's preamble) is immutable on the
platform, the repair is a twin: `<dotted>_inc` with the block deduped by
`debug/dedup_variable_binders.py`, submitted, and then the original retired by
`debug/retire_old_nodes.py`.

Also clones the sol, the wave entry (with `sol_order` — the pipeline iterates
`sol_order`, so an entry without a slot is never submitted) and seeds the
ledger.

Usage:
  python3 debug/clone_dupvar_inc.py --from-file state/scratch/fs_dupvar.txt [--dry-run]
"""
import argparse
import json
import os
import re
import shutil
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import dedup_variable_binders as dd  # noqa: E402

WAVE = os.path.join(WS, "pipeline", "wave_upload.json")
LEDGER = os.path.join(WS, "state", "pipeline.json")
IDENT_END = r"(?![A-Za-z0-9_'.!?])"


def clone(slug, dry=False):
    old = slug if slug.startswith("BookProof_") else "BookProof_" + slug
    stub = os.path.join(WS, "Theorems", "Thm_%s.lean" % old)
    sol = os.path.join(WS, "Solutions", "Sol_%s.lean" % old)
    if not os.path.exists(stub):
        return "NO-STUB", old
    if not os.path.exists(sol):
        return "NO-SOL", old
    txt = open(stub, encoding="utf-8").read()
    m = re.search(r"(?m)^theorem\s+([A-Za-z0-9_.']+)", txt)
    if not m:
        return "NO-DECL", old
    old_dotted = m.group(1)
    new_dotted = old_dotted + "_inc"
    new = old + "_inc"
    dst_stub = os.path.join(WS, "Theorems", "Thm_%s.lean" % new)
    dst_sol = os.path.join(WS, "Solutions", "Sol_%s.lean" % new)
    pat = re.compile(re.escape(old_dotted) + IDENT_END)
    if not dry:
        with open(dst_stub, "w", encoding="utf-8") as fh:
            fh.write(pat.sub(new_dotted, txt))
        with open(dst_sol, "w", encoding="utf-8") as fh:
            fh.write(pat.sub(new_dotted, open(sol, encoding="utf-8").read()))
        for p in (dst_stub, dst_sol):
            t, ch = dd.rewrite(open(p, encoding="utf-8").read())
            if ch:
                open(p, "w", encoding="utf-8").write(t)
    wave = json.load(open(WAVE, encoding="utf-8"))
    ent = wave["thms"].get(old)
    if ent is None:
        return "NO-WAVE", old
    if new in wave["thms"]:
        return "EXISTS", new
    if not dry:
        e = json.loads(json.dumps(ent))
        e["name"] = new_dotted
        e["file"] = "Theorems/Thm_%s.lean" % new
        e["sol"] = "Solutions/Sol_%s.lean" % new
        for k in ("title", "nl"):
            if e.get(k):
                e[k] = e[k].replace(old_dotted, new_dotted)
        e["nl"] = (e.get("nl") or "") + (
            "\n\nReplaces the published node `%s`, whose preamble declared the "
            "section `variable` block twice: Lean read the second `(Hs) (D) "
            "(A)` as new variables, so its target carried the hypotheses on "
            "one `(D, A)` and the conclusion on another and no proof could "
            "exist.  The `_inc` twin is the same statement with the "
            "re-declarations removed." % old)
        wave["thms"][new] = e
        so = wave.setdefault("sol_order", [])
        if new not in so:
            so.append(new)
        json.dump(wave, open(WAVE, "w", encoding="utf-8"),
                  ensure_ascii=False, separators=(",", ":"))
        led = json.load(open(LEDGER, encoding="utf-8"))
        rec = {"status": "pending", "attempts": 0}
        led["items"].setdefault("thm:" + new, dict(rec))
        led["items"].setdefault("sol:" + new, dict(rec))
        json.dump(led, open(LEDGER, "w", encoding="utf-8"),
                  separators=(",", ":"))
    return "CLONED", new


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("slugs", nargs="*")
    ap.add_argument("--from-file", default=None)
    ap.add_argument("--dry-run", action="store_true")
    a = ap.parse_args()
    slugs = list(a.slugs)
    if a.from_file:
        slugs += [l.strip() for l in open(a.from_file) if l.strip()]
    if not slugs:
        ap.error("no slugs")
    if not a.dry_run:
        for p in (WAVE, LEDGER):
            bak = p + ".bak_dupvar"
            if not os.path.exists(bak):
                shutil.copy(p, bak)
    from collections import Counter
    c = Counter()
    for s in dict.fromkeys(slugs):
        st, name = clone(s, a.dry_run)
        c[st] += 1
        print("%-8s %s" % (st, name))
    print(dict(c))
    return 0


if __name__ == "__main__":
    sys.exit(main())
