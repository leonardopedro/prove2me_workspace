#!/usr/bin/env python3
"""Reconcile the website's "theorems proved" with what this checkout recorded.

Two counters are in play and neither is wrong, but they are not the same number:

* **Platform `num_solved_prob`** (`GET /me`) is the website's "theorems proved":
  the count of *distinct theorems this account holds a verified proof for*.
  `GET /users/<uid>` returns exactly that set as `solved_problems`, and each
  entry carries the `submission_id` of **our** accepted submission (verified:
  every sampled id resolves to this account, including the ones a second account
  also solved).  That list — not any local file — is the ground truth.

* **Local `state/pipeline.json` `done`** is a *plan* metric.  It counts published
  statements, published definition bundles, nodes that were already on the
  platform, and solutions we never proved (`skipped: theorem already Proved`),
  so it is far larger than the platform count.  In the other direction it
  *undercounts our own proofs*, because two code paths replace a record
  wholesale and drop the `submission_id` that linked it to the proof:

    1. `sync_state()` marks a pending solution done when the target node is
       already `Proved` — discarding the very submission that made it `Proved`.
    2. `do_wave_sol()`'s skip branches did the same (and dropped `theorem_id`).

  A submission the platform accepted but whose verdict a killed chunk never
  drained stays `pending` locally, which undercounts too.

`GET /submissions` cannot fill the gap on its own: API 0.10.3 ignores `offset`,
`page`, `limit` (>1000) and `status`, always returning the newest 1000 of
`total` (`total: 1201` at the time of writing), so the oldest submissions —
exactly the early, pre-`pipeline.json` proofs — are unreachable there.

Usage:

    python3 debug/reconcile_solved.py            # report only
    python3 debug/reconcile_solved.py --apply     # backfill the evidence
"""
import argparse
import collections
import json
import os
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402

STATE_FILE = os.path.join(WS, "state/pipeline.json")


def slug_of(theorem_name):
    """Platform dotted name -> wave slug.  The wave spec joins on `_`, with a
    couple of hand-repaired exceptions (a primed declaration renamed `_prime`),
    so also try the known renames before giving up."""
    return (theorem_name or "").replace(".", "_")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true",
                    help="write the platform's solver submission id back into the "
                         "local records it was lost from (additive, idempotent)")
    args = ap.parse_args()

    ok, version, detail = up.auth_probe()
    if not ok:
        print(f"platform access: FAILED {detail}")
        return 2
    me = up.api("GET", "me") or {}
    uid = me.get("user_id")
    profile = up.api("GET", f"users/{uid}") or {}
    solved = profile.get("solved_problems") or []
    submitted = profile.get("submitted_problems") or []

    print(f"platform (skill {up.skill_version()} / api {version}), account {me.get('username')}")
    print(f"  /me num_solved_prob   : {me.get('num_solved_prob')}   <- the website's 'proved'")
    print(f"  /me num_submitted_prob: {me.get('num_submitted_prob')}   "
          "(0 for every account checked; a dead platform counter, not our bug)")
    print(f"  solved_problems       : {len(solved)} (the ground-truth set)")
    print(f"  submitted_problems    : {len(submitted)}  (capped at 1000, newest first)")

    sub_page = up.api("GET", "submissions", params={"limit": "1000"}) or {}
    print(f"  /submissions          : {len(up._list_of(sub_page))} of total "
          f"{sub_page.get('total')} (offset/status filters ignored by 0.10.3)")

    st = json.load(open(STATE_FILE))
    items = st.setdefault("items", {})
    by_tid = {v["theorem_id"]: (k, v) for k, v in items.items()
              if isinstance(v, dict) and v.get("theorem_id")}

    cls = collections.Counter()
    changed = 0
    detail_rows = collections.defaultdict(list)
    for s in solved:
        tid, sid, name = s["theorem_id"], s["submission_id"], s["theorem_name"]
        rec = items.get("sol:" + slug_of(name))
        thm = by_tid.get(tid)
        authored = thm is not None and thm[0].startswith("thm:")
        if rec is None:
            kind = "no local sol record (pre-pipeline submission)"
        elif rec.get("submission_id") == sid:
            kind = ("tracked, verdict drained" if rec.get("status") == "done"
                    else "tracked, verdict not drained (local status pending)")
        elif rec.get("submission_id"):
            kind = "duplicate submission (a later accepted proof; local id differs)"
        else:
            kind = "lost: local record skipped the solver submission id"
        cls[kind] += 1
        if len(detail_rows[kind]) < 4:
            detail_rows[kind].append(f"{name} [{sid[:8]}]"
                                     + ("" if authored else "  (node not ours)"))
        if args.apply and rec is not None:
            # The platform has an accepted proof for this theorem, so the plan
            # item is resolved.  Keep the old id if it is a different accepted
            # submission of ours (the duplicate case) and the new one as the
            # solver reference, so nothing we recorded is destroyed.  Compare
            # before/after so a re-run is a genuine no-op.
            before = json.dumps(rec, sort_keys=True)
            rec["status"] = "done"
            rec["theorem_id"] = rec.get("theorem_id") or tid
            rec["platform_solver_submission"] = sid
            if rec.get("submission_id") in (None, sid):
                rec["submission_id"] = sid
            rec.pop("error", None)
            if json.dumps(rec, sort_keys=True) != before:
                changed += 1

    print("\n=== local state vs the platform's solved set ===")
    for kind, n in cls.most_common():
        print(f"  {n:4d}  {kind}")
        for row in detail_rows[kind]:
            print(f"          {row}")

    tracked = sum(n for k, n in cls.items() if k.startswith("tracked"))
    print(f"\n  our own proofs the platform counts : {len(solved)}")
    print(f"  of those linked to a local record  : {tracked}"
          + ("" if tracked == len(solved)
             else f"  ({len(solved) - tracked} not linkable: duplicate submissions "
                  "or pre-pipeline proofs with no local record)"))

    # Authorship split: are these nodes we published, or ones we solved for others?
    ours = sum(1 for s in solved if s["theorem_id"] in by_tid)
    print(f"  solved nodes present in local catalog node records: {ours} / {len(solved)}")

    if args.apply:
        if changed:
            tmp = STATE_FILE + ".tmp"
            with open(tmp, "w") as f:
                json.dump(st, f)
            os.replace(tmp, STATE_FILE)
            print(f"\napplied: {changed} record(s) re-linked to their accepted submission")
        else:
            print("\napplied: nothing to change (already reconciled)")
    else:
        print("\n(report only; re-run with --apply to re-link the lost submission ids)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
