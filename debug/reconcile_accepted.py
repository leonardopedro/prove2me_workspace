#!/usr/bin/env python3
"""Reconcile the ledger against the platform: which sols are ALREADY ACCEPTED?

`state/pipeline.json` remembers only the LAST attempt per item, so an item can be
painted `failed` (5 attempts, a red CE in the log) while a LATER submission of the
same file was accepted by the platform.  Measured 2026-10-12 on
`BookProof_TensorCore_derPow_symm_tmul`: the ledger says
`failed / verdict CE / attempts 5`, and the platform shows `ACCEPTED 2026-10-11
09:00:42` for text byte-identical to the local file.  Re-submitting would waste an
attempt on a solved target; leaving it red keeps it out of every uploadable list.

This asks the platform directly (read-only, never submits) for each candidate
slug: list the theorem's submissions and look for one of ours that is ACCEPTED.
The acceptance text is compared with the local file so a stale ACCEPTED (an older
draft that was later retracted) is not mistaken for the current one.

Writes:
    state/reconciled_accepted.json   {slug: {submission_id, created_at, text_match}}
    /tmp/reconciled_accepted.txt     slugs the ledger should close

Usage:
  python3 debug/reconcile_accepted.py [--workers 12] [--limit N]
  python3 debug/reconcile_accepted.py --all-pending   # every pending sol, not just red ones
  python3 debug/reconcile_accepted.py --apply         # mark the ledger done (with a note)
"""
import argparse
import concurrent.futures
import json
import os
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402


def check(args):
    slug, tid = args
    try:
        r = up.api("GET", f"theorems/{tid}/submissions", params={"limit": 100}) or {}
    except Exception as e:
        return slug, {"error": f"API {str(e)[:120]}"}
    subs = [s for s in (r.get("submissions") or [])
            if s.get("username") == up.me_username
            and s.get("status") == "ACCEPTED"]
    if not subs:
        return slug, None
    subs.sort(key=lambda s: str(s.get("created_at") or ""), reverse=True)
    best = subs[0]
    text = None
    try:
        text = up.api("GET", f"submissions/{best['id']}/solution").get("content")
    except Exception:
        pass
    local = None
    p = up.item_source(f"sol:{slug}")
    if os.path.exists(p):
        local = open(p, encoding="utf-8").read()
    return slug, {"submission_id": best["id"],
                  "created_at": best.get("created_at"),
                  "text_match": (text == local) if (text is not None and local is not None) else None,
                  "n_accepted": len(subs)}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--workers", type=int, default=12)
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--all-pending", action="store_true",
                    help="check every pending sol, not only ledger-failed ones")
    ap.add_argument("--apply", action="store_true",
                    help="mark the reconciled items done in state/pipeline.json")
    a = ap.parse_args()

    ok, ver, det = up.auth_probe()
    if not ok:
        print(f"platform access: FAILED {det}")
        return 2
    me = up.api("GET", "me") or {}
    up.me_username = me.get("username")

    st = up.load_state()["items"]
    want = set()
    if os.path.exists(f"{WS}/state/failed_submissions.json"):
        want |= set(json.load(open(f"{WS}/state/failed_submissions.json")))
    for k, v in st.items():
        if not k.startswith("sol:"):
            continue
        if v.get("status") == "failed" or (a.all_pending and v.get("status") == "pending"):
            want.add(k[4:])

    targets = []
    for slug in sorted(want):
        rec = st.get(f"sol:{slug}") or {}
        tid = rec.get("theorem_id")
        if not tid:
            # pending sols have no theorem_id until published; fall back to the
            # failed-submissions catalogue, which does record it.
            tid = (json.load(open(f"{WS}/state/failed_submissions.json"))
                   .get(slug, {}).get("theorem_id")) if os.path.exists(
                       f"{WS}/state/failed_submissions.json") else None
        if tid:
            targets.append((slug, tid))
    if a.limit:
        targets = targets[:a.limit]
    print(f"user={up.me_username}; checking {len(targets)} sol(s) "
          f"({len(want)} candidates) for an ACCEPTED submission")

    hits, errs = {}, 0
    with concurrent.futures.ThreadPoolExecutor(a.workers) as ex:
        for i, (slug, res) in enumerate(ex.map(check, targets), 1):
            if res and res.get("error"):
                errs += 1
            elif res:
                hits[slug] = res
            if i % 200 == 0:
                print(f"  {i}/{len(targets)}  accepted-but-red={len(hits)}  errors={errs}",
                      flush=True)

    json.dump(hits, open(f"{WS}/state/reconciled_accepted.json", "w"),
              indent=1, sort_keys=True)
    with open("/tmp/reconciled_accepted.txt", "w") as fh:
        fh.write("".join(s + "\n" for s in sorted(hits)))
    nmatch = sum(1 for v in hits.values() if v.get("text_match") is True)
    nstale = sum(1 for v in hits.values() if v.get("text_match") is False)
    print(f"\nledger says NOT-done but the platform ACCEPTED: {len(hits)}")
    print(f"  accepted text == local file : {nmatch}")
    print(f"  accepted text != local file : {nstale}  (older draft; still solved)")
    print(f"  -> /tmp/reconciled_accepted.txt, state/reconciled_accepted.json")
    for s in sorted(hits)[:20]:
        v = hits[s]
        print(f"  {s[:66]:66s} match={v['text_match']} {str(v['created_at'])[:19]}")

    if a.apply:
        # `load_state()` re-reads the JSON on EVERY call, so `save_state(load_state())`
        # would persist a freshly-read copy and silently discard the edits above --
        # which is exactly what the first version did: it printed "applied: 2 ledger
        # item(s) closed as done" while state/pipeline.json still showed both as
        # `failed`.  Mutate one object and save THAT object, then verify by re-reading.
        cur = up.load_state()
        items = cur["items"]
        changed = 0
        for slug, v in hits.items():
            k = f"sol:{slug}"
            rec = items.get(k)
            if not rec or rec.get("status") == "done":
                continue
            rec["status"] = "done"
            rec["note"] = (f"reconciled: platform ACCEPTED {v['submission_id'][:8]} "
                           f"{str(v['created_at'])[:19]} (text_match={v['text_match']})")
            changed += 1
        if changed:
            up.save_state(cur)
            reread = up.load_state()["items"]
            still = [s for s in hits if reread.get(f"sol:{s}", {}).get("status") != "done"]
            if still:
                print(f"applied: {changed} written but {len(still)} NOT persisted "
                      f"(e.g. {still[0]}) -- investigate")
            else:
                print(f"applied and verified: {changed} ledger item(s) now `done`")
        else:
            print("applied: nothing to change")
    return 0


if __name__ == "__main__":
    sys.exit(main())
