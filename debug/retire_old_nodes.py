#!/usr/bin/env python3
"""Retire the published (broken) nodes of the §2.64 dropped-include class.

contribute.md §retire: `PATCH /api/v1/theorems/:theorem_id` with
`{"deprecated": true}` hides a node without deleting it (imports keep
working), and the same PATCH should append a `natural_language_statement`
note explaining why and naming the corrected replacement's `theorem_name`.

Run AFTER the `<slug>_inc` thm+sol are Proved.  Also parks the old sol item
in the ledger: the old target type can never match any proof, so leaving the
item pending would burn an attempt per drain.

Usage:
  python3 debug/retire_old_nodes.py [--only SUBSTR] [--dry-run]
"""
import argparse
import json
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402


def targets():
    wave = json.load(open(os.path.join(WS, "pipeline", "wave_upload.json")))
    return [s for s in wave["thms"] if s.endswith("_inc")]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--only", default=None)
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    wave = json.load(open(os.path.join(WS, "pipeline", "wave_upload.json")))
    led_path = os.path.join(WS, "state", "pipeline.json")
    led = json.load(open(led_path))
    jobs = None

    for new_slug in sorted(targets()):
        old_slug = new_slug[: -len("_inc")]
        if args.only and args.only not in old_slug:
            continue
        old_ent = wave["thms"].get(old_slug)
        new_ent = wave["thms"].get(new_slug)
        if not old_ent or not new_ent:
            print("skip %s (missing wave entry)" % old_slug)
            continue
        # require the replacement to be Proved before retiring
        # drops: read the restored include line from the replacement stub
        drops = []
        stub = os.path.join(WS, "Theorems", "Thm_%s.lean" % new_slug)
        import re
        m = re.search(r"(?m)^include\s+(.+?)\s+in$",
                      open(stub, encoding="utf-8").read())
        if m:
            drops = m.group(1).split()
        if jobs is None:
            jobs = up.platform_jobs()
        rec = jobs.get(new_ent["name"]) or {}
        tid_new = rec.get("theorem_id")
        status = (up.api("GET", "theorems/%s" % tid_new) or {}).get("status") \
            if tid_new else None
        if status != "Proved":
            print("wait %s (replacement is %s)" % (old_slug, status))
            continue
        old_rec = jobs.get(old_ent["name"]) or {}
        tid_old = old_rec.get("theorem_id") \
            or (led["items"].get("thm:" + old_slug) or {}).get("theorem_id")
        if not tid_old:
            print("skip %s (no theorem_id)" % old_slug)
            continue
        note = (old_ent.get("nl") or "") + (
            "\n\nRETIRED: the stored statement omitted the included hypothes%s "
            "`%s` (the upstream declaration binds it with `include`), so the "
            "node could never be proved as published. Replaced by "
            "`%s` (same statement, hypothesis restored as a binder)."
            % ("es" if len(drops) > 1 else "is",
               "`, `".join(drops or ["?"]), new_ent["name"]))
        if args.dry_run:
            print("would retire %s (tid=%s) -> %s" % (old_ent["name"], tid_old,
                                                      new_ent["name"]))
            continue
        r = up.api("PATCH", "theorems/%s" % tid_old,
                   {"deprecated": True, "natural_language_statement": note})
        ok = bool(r)
        # park the old sol item
        item = "sol:" + old_slug
        if led["items"].get(item, {}).get("status") != "parked":
            led["items"][item] = {
                "status": "parked", "attempts": 0,
                "error": ("retired node: target type lacks the `%s` binder; "
                          "replaced by %s" % (
                              "`, `".join(drops or ["?"]),
                              new_ent["name"]))}
        print("%s retire %s (patch=%s)" % ("OK" if ok else "FAIL",
                                           old_slug, ok))
    if not args.dry_run:
        json.dump(led, open(led_path, "w"), separators=(",", ":"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
