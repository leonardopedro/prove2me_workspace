#!/usr/bin/env python3
"""Retire the published nodes of the duplicated-`variable` class (§8.1).

`PATCH /api/v1/theorems/:id {"deprecated": true}` hides a node without deleting
it (imports keep working) and the same PATCH replaces its
`natural_language_statement`, which is where the reason and the replacement's
`theorem_name` belong.

Refuses to retire a node whose `_inc` twin is not `Proved` yet: retiring first
would leave the statement with no provable node at all.

Also parks the old sol item, because its target type can never match any proof
-- leaving it pending would burn one attempt per drain.

Usage:
  python3 debug/retire_dupvar_nodes.py --from-file state/scratch/fs_dupvar.txt
  python3 debug/retire_dupvar_nodes.py --slug BookProof_..._esa [--dry-run]
"""
import argparse
import json
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--slug", action="append", default=[])
    ap.add_argument("--from-file", default=None)
    ap.add_argument("--dry-run", action="store_true")
    a = ap.parse_args()
    slugs = list(a.slug)
    if a.from_file:
        slugs += [l.strip() for l in open(a.from_file) if l.strip()]
    if not slugs:
        ap.error("no slugs")

    wave = json.load(open(os.path.join(WS, "pipeline", "wave_upload.json"),
                          encoding="utf-8"))["thms"]
    led_path = os.path.join(WS, "state", "pipeline.json")
    led = json.load(open(led_path, encoding="utf-8"))
    jobs = None
    todo, skipped = 0, 0
    for old_slug in slugs:
        new_slug = old_slug + "_inc"
        old_ent, new_ent = wave.get(old_slug), wave.get(new_slug)
        if not old_ent or not new_ent:
            print("skip %s (missing wave entry)" % old_slug)
            skipped += 1
            continue
        if jobs is None:
            jobs = up.platform_jobs()

        def node(ent):
            tid = (jobs.get(ent["name"]) or {}).get("theorem_id")
            return (tid, up.api("GET", "theorems/%s" % tid) if tid else {})

        tid_new, d_new = node(new_ent)
        if d_new.get("status") != "Proved":
            print("wait %s (twin is %s)" % (old_slug, d_new.get("status")))
            skipped += 1
            continue
        tid_old, d_old = node(old_ent)
        if not tid_old:
            print("skip %s (no theorem_id)" % old_slug)
            skipped += 1
            continue
        if d_old.get("deprecated_at"):
            print("done %s (already deprecated)" % old_slug)
            continue
        note = (old_ent.get("nl") or "") + (
            "\n\nRETIRED: the published preamble declared the section `variable` "
            "block twice -- %s -- and Lean reads a re-declaration as NEW "
            "variables, so the target carried the hypotheses on one `(D, A)` and "
            "the conclusion on another and no proof could exist. Replaced by "
            "`%s` (same statement, re-declarations removed)."
            % ("`variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : "
               "D →ₗ[ℂ] Hs.carrier)` after the block that binds the same names "
               "with `hdense`/`hsym`/`hesa`",
               new_ent["name"]))
        if a.dry_run:
            print("would retire %s (tid=%s) -> %s"
                  % (old_ent["name"], tid_old, new_ent["name"]))
            continue
        r = up.api("PATCH", "theorems/%s" % tid_old,
                   {"deprecated": True, "natural_language_statement": note})
        item = "sol:" + old_slug
        if led["items"].get(item, {}).get("status") != "parked":
            led["items"][item] = {
                "status": "parked", "attempts": 0,
                "error": ("retired node: preamble re-declared the section "
                          "`variable` block, so the target's hypotheses and "
                          "conclusion use different `(Hs, D, A)`; replaced by "
                          + new_ent["name"])}
        print("%s retire %s (patch=%s)" % ("OK" if r else "FAIL", old_slug, bool(r)))
        todo += 1
    if not a.dry_run:
        json.dump(led, open(led_path, "w", encoding="utf-8"),
                  separators=(",", ":"))
    print("retired %d, skipped %d" % (todo, skipped))
    return 0


if __name__ == "__main__":
    sys.exit(main())
