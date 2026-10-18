#!/usr/bin/env python3
"""Offline-verdict the sols whose LATEST platform submission is red.

`check_pending_offline.py --kind sol` only visits ledger-`pending` items, and a
sol whose submission came back CE/FAILED sits at `done` in the ledger -- the
oracle never sees it, which is why 249 of the 304 red sols had no verdict at
all.  This wrapper calls the SAME `run_sol` two-phase oracle with an explicit
name list (ledger membership not required, the §2.31-3 method), then merges the
verdicts into `state/offline_pending_check.json` so the submission guard reads
them like any other.

Input:  state/failed_latest.json  (slug -> {status, error}, latest submission)
        /tmp/red_sol.txt          (one red slug per line; any list works)

Usage:
  PROVE2ME_SKIP_LOCAL_COMPILE=1 python3 debug/check_red_sols.py [--jobs 4]
  ... --only SUBSTR        # substring scope, repeatable
  ... --list               # print the target list and exit
"""
import argparse
import json
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.environ.get("PROVE2ME_WS") or os.path.dirname(HERE)
sys.path.insert(0, HERE)

import check_pending_offline as cpo  # noqa: E402


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--jobs", type=int, default=4)
    ap.add_argument("--only", action="append", default=[])
    ap.add_argument("--list", action="store_true")
    ap.add_argument("--input", default="/tmp/red_sol.txt")
    args = ap.parse_args()

    names = [l.strip() for l in open(args.input) if l.strip()]
    if args.only:
        names = [n for n in names if any(o in n for o in args.only)]
    if not names:
        raise SystemExit("no target sols")
    if args.list:
        print("\n".join(names))
        return 0
    if not os.path.isdir(cpo.MIRROR):
        print(f"no published mirror at {cpo.MIRROR}")
        return 2

    lean, env_path = cpo.lean_env()
    if not lean:
        print("could not read the Lean environment from `lake env`")
        return 2
    env = dict(os.environ)
    env["LEAN_PATH"] = env_path

    print(f"red sols to verdict: {len(names)} (jobs={args.jobs})", flush=True)
    res, built = cpo.run_sol(lean, env, names, None, args.jobs)
    bok = sum(1 for v in built.values() if v == "ok")
    print(f"  statement modules needed: {len(built)} ({bok} built, "
          f"{len(built) - bok} not)")
    for m, v in list(built.items()):
        if v != "ok":
            print(f"    {v[:110]}  ({m})")
    cpo.summarise(res, "sol")

    # Merge, same contract as the parent tool: verdicts outside this run's
    # scope survive, and a re-read at write time keeps a concurrent run's
    # thm verdicts.  Written via rename so the guard never sees a half-file.
    try:
        fresh = json.load(open(cpo.OUT))
        if not isinstance(fresh, dict):
            fresh = {}
    except (OSError, ValueError):
        fresh = {}
    sol = dict((fresh.get("sol") or {}).get("items", {}))
    sol.update(res)
    stmt = dict((fresh.get("sol") or {}).get("statement_modules", {}) or {})
    stmt.update(built)
    fresh["sol"] = {"items": sol, "statement_modules": stmt}
    tmp = cpo.OUT + ".tmp"
    with open(tmp, "w") as fh:
        json.dump(fresh, fh, indent=1)
    os.replace(tmp, cpo.OUT)

    ok = sorted(n for n, v in res.items() if v == "ok")
    with open("/tmp/red_sol_ok.txt", "w") as fh:
        fh.write("\n".join(ok) + ("\n" if ok else ""))
    with open("/tmp/red_sol_fail.txt", "w") as fh:
        fh.write("\n".join(sorted(n for n, v in res.items() if v != "ok")) + "\n")
    print(f"\nok={len(ok)} -> /tmp/red_sol_ok.txt; "
          f"fail={len(res) - len(ok)} -> /tmp/red_sol_fail.txt")
    print(f"wrote {cpo.OUT}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
