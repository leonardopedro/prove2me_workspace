#!/usr/bin/env python3
"""Why the platform shows fewer ACCEPTED submissions than theorems proved.

The profile says **517 theorems proved** (`/me num_solved_prob`) while
`GET /submissions` only lists **394 ACCEPTED**.  Fewer accepted submissions than
proved theorems looks impossible — every proof needs at least one accepted
submission — so either the account counter over-counts or the submission list
under-counts.  This tool measures both sides against the platform's own data and
prints the reconciliation, no local state involved:

* **Ground truth for "proved"** is `/users/<uid> solved_problems`: one entry per
  solved theorem, each carrying the `submission_id` the profile credits.  The
  credited submission is fetched back from
  `/theorems/<tid>/submissions` and checked to be ours.
* **Accepted submissions** are then counted the only complete way available:
  per theorem, over the whole history.  `GET /submissions` cannot do this —
  API 0.10.3 ignores `offset`, `page`, `status` and `limit > 1000` and always
  returns the newest 1000 of `total`, so the list is a *window*, not the account.
* The difference between the per-theorem count and the window count is exactly
  the accepted submissions the window cannot show, and every credited proof
  timestamped before the window's oldest entry accounts for them.

Usage:

    python3 debug/audit_submissions.py            # full audit (517 API reads)
    python3 debug/audit_submissions.py --limit 50 # first 50 solved theorems
"""
import argparse
import collections
import concurrent.futures
import json
import os
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402

ACCEPTED = ("ACCEPTED", "SKETCH_ACCEPTED")
WORKERS = 10


def theorem_submissions(tid):
    payload = up.api("GET", f"theorems/{tid}/submissions") or {}
    return up._list_of(payload)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--limit", type=int, default=0,
                    help="only audit the first N solved theorems (0 = all)")
    args = ap.parse_args()

    ok, version, detail = up.auth_probe()
    if not ok:
        print(f"platform access: FAILED {detail}")
        return 2
    me = up.api("GET", "me") or {}
    uid = me.get("user_id")
    profile = up.api("GET", f"users/{uid}") or {}
    solved = profile.get("solved_problems") or []
    n_solved = len(solved)

    print(f"platform {version} (skill {up.skill_version()}), account {me.get('username')} ({uid[:8]})")
    print(f"\n=== A. the platform's 'proved' counter ===")
    print(f"  /me num_solved_prob          : {me.get('num_solved_prob')}")
    print(f"  /users/<uid> solved_problems : {n_solved}   (one entry per solved theorem,")
    print( "                                   each with the credited submission_id)")
    credited_ids = [s.get("submission_id") for s in solved]
    print(f"  distinct credited submissions: {len(set(credited_ids))}"
          + ("" if len(set(credited_ids)) == n_solved
             else f"  <-- {n_solved - len(set(credited_ids))} theorem(s) share a credited id"))

    target = solved[:args.limit] if args.limit else solved
    print(f"\n=== B. per-theorem audit of {len(target)} solved theorem(s) ===")
    print(f"  ({WORKERS} parallel readers; this is every submission ever made on each)")

    errs = []
    per_theorem_ours = {}
    credited_check = {"ours": 0, "missing": 0, "other": 0}
    mine_accepted = []          # (submission_id, theorem_id, created_at)
    others_accepted = collections.Counter()

    def one(s):
        tid = s["theorem_id"]
        try:
            subs = theorem_submissions(tid)
        except Exception as e:  # keep the audit running; report at the end
            return s, None, f"{type(e).__name__}: {e}"
        return s, subs, None

    with concurrent.futures.ThreadPoolExecutor(max_workers=WORKERS) as ex:
        for i, (s, subs, err) in enumerate(ex.map(one, target), 1):
            if err:
                errs.append((s["theorem_name"], err))
                continue
            tid = s["theorem_id"]
            ours = [x for x in subs if x.get("user_id") == uid and x.get("status") in ACCEPTED]
            per_theorem_ours[tid] = ours
            mine_accepted.extend((x["id"], tid, x.get("created_at")) for x in ours)
            for x in subs:
                if x.get("status") in ACCEPTED and x.get("user_id") != uid:
                    others_accepted[x.get("username") or x.get("user_id", "?")[:8]] += 1
            cred = next((x for x in subs if x.get("id") == s.get("submission_id")), None)
            if cred is None:
                credited_check["missing"] += 1
            elif cred.get("user_id") == uid:
                credited_check["ours"] += 1
            else:
                credited_check["other"] += 1
            if i % 100 == 0:
                print(f"    ... {i}/{len(target)}")

    audited = len(per_theorem_ours)
    n_ours = len(mine_accepted)
    dups = {t: len(v) for t, v in per_theorem_ours.items() if len(v) > 1}
    extra = sum(n - 1 for n in dups.values())
    print(f"\n  solved theorems audited                              : {audited}")
    print(f"  our ACCEPTED|SKETCH_ACCEPTED submissions found on them: {n_ours}")
    print(f"    of which the profile's credited submission         : {credited_check['ours']}"
          + (f"  (credits NOT ours: {credited_check['other']})" if credited_check["other"] else ""))
    print(f"  theorems with >1 of our accepted submissions         : {len(dups)}"
          f"  (+{extra} extra submissions)")
    print(f"  other accounts' accepted submissions seen            : {sum(others_accepted.values())}"
          + (f"  {dict(others_accepted.most_common(4))}" if others_accepted else ""))
    if errs:
        print(f"  UNREADABLE theorems                                  : {len(errs)}")
        for name, e in errs[:5]:
            print(f"      {name}: {e}")

    n_distinct = len({i for i, _, _ in mine_accepted})
    print(f"\n  => accepted submissions on solved theorems (distinct ids): {n_distinct}")

    # ---- the /submissions window ----
    page = up.api("GET", "submissions", params={"limit": "1000"}) or {}
    window = up._list_of(page)
    total = page.get("total")
    win_acc = [x for x in window if x.get("status") in ACCEPTED]
    win_acc_plain = [x for x in window if x.get("status") == "ACCEPTED"]
    win_sketch = [x for x in window if x.get("status") == "SKETCH_ACCEPTED"]
    win_ids = {x["id"] for x in win_acc}
    oldest = min((x.get("created_at") or "") for x in window) if window else ""
    newest = max((x.get("created_at") or "") for x in window) if window else ""
    st = collections.Counter(x.get("status") for x in window)

    print(f"\n=== C. the /submissions list is a WINDOW, not the account ===")
    print(f"  GET /submissions?limit=1000 -> {len(window)} rows, total={total}"
          f"  ({total - len(window)} not returned)")
    print(f"  window covers {oldest} ..  {newest}")
    print(f"  statuses in window: {dict(st.most_common())}")
    print(f"  ACCEPTED in window: {len(win_acc_plain)}, SKETCH_ACCEPTED: {len(win_sketch)}"
          f"  (both: {len(win_acc)})")

    if args.limit == 0:
        hidden_credited = [c for c in credited_ids
                           if c and c not in win_ids]
        # every credited proof is an accepted submission; those outside the window
        # are precisely accepted submissions the list cannot show
        in_audit = {i for i, _, _ in mine_accepted}
        outside_window = sorted(i for i in in_audit if i not in win_ids)
        print(f"\n  our accepted submissions (audited set, whole history): {n_distinct}")
        print(f"  ... of those, absent from the /submissions window    : {len(outside_window)}")
        print(f"  ... and the {len(win_acc)} shown in the window                       : "
              f"{len(win_ids & in_audit)}")
        print(f"  credited proofs whose submission is outside the window: {len(hidden_credited)}")
        if outside_window:
            ts = sorted((t or "") for i, _, t in mine_accepted if i in outside_window)
            outside_after_window = [t for t in ts if t >= oldest]
            print(f"     (oldest window row {oldest}; accepted submissions older than it:"
                  f" {len(ts) - len(outside_after_window)})")
        print("\n  => the list endpoint truncates, the counter does not.  "
              f"{n_distinct} accepted submissions exist for the "
              f"{n_solved} proved theorems; the window can only show "
              f"{len(win_acc)} of them.")
    else:
        print("\n  (--limit set: run without it for the full reconciliation)")

    print("\n=== result ===")
    if errs:
        print("  INCOMPLETE — some theorems could not be read; rerun before quoting numbers")
    elif args.limit:
        print("  partial audit (--limit); rerun without it for the full reconciliation")
    elif n_distinct >= n_solved and credited_check["other"] == 0 and credited_check["missing"] == 0:
        print(f"  CONSISTENT.  {n_solved} theorems proved, each with a credited accepted")
        print(f"  submission of ours, {n_distinct} accepted submissions in total.")
        print(f"  The smaller {len(win_acc)} figure is the truncated /submissions list.")
    elif credited_check["other"]:
        print(f"  ATTRIBUTION PROBLEM: {credited_check['other']} credited submission(s) are not ours")
    else:
        print(f"  UNEXPLAINED: only {n_distinct} accepted submissions found for {n_solved} proved theorems")
    return 0


if __name__ == "__main__":
    sys.exit(main())
