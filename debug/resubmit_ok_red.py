#!/usr/bin/env python3
"""Resubmit sols whose LATEST platform verdict is red but which are offline-ok.

The ledger marks a sol `done` the moment a submission is accepted into the
queue; the platform grades it later, and a CE/FAILED that arrives after that
leaves the ledger `done` while the sol sits red on the platform (§2.44
hidden-red, the other direction).  The submit loop skips `done` unconditionally,
so these need an explicit `done -> pending` flip -- but ONLY under the §2.46
rule: a fresh cached `ok`, file not edited after the verdict, own thm present,
not parked.  Everything else is left alone.

Writes /tmp/resubmit_ok_red.txt and flips the ledger (single writer: run only
when no other upload_pipeline process is alive).

Usage: python3 debug/resubmit_ok_red.py [--apply]
"""
import argparse
import json
import os
import sys
import time

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true", help="flip the ledger; default is a dry run")
    args = ap.parse_args()
    os.chdir(WS)

    red = [l.strip() for l in open('/tmp/red_sol.txt') if l.strip()]
    chk = json.load(open('state/offline_pending_check.json'))
    off = chk.get('sol', {}).get('items', {})
    stamp = os.path.getmtime('state/offline_pending_check.json')
    st = json.load(open('state/pipeline.json'))

    keep = []
    skipped = []
    for n in red:
        rec = st['items'].get(f'sol:{n}')
        if not rec:
            skipped.append((n, 'not in ledger'))
            continue
        if rec.get('status') == 'parked':
            skipped.append((n, f"parked: {(rec.get('error') or '')[:60]}"))
            continue
        if rec.get('flipped_at'):
            # Already flipped+resubmitted this session (accepted into the
            # platform's queue, grade pending) -- resubmitting again would
            # double-spend an attempt for no new information.
            skipped.append((n, 'already resubmitted this session'))
            continue
        if rec.get('status') != 'done':
            skipped.append((n, f"status={rec.get('status')}"))
            continue
        if off.get(n) != 'ok':
            skipped.append((n, f"verdict={str(off.get(n))[:30]}"))
            continue
        path = f'Solutions/Sol_{n}.lean'
        if not os.path.exists(path):
            skipped.append((n, 'no file'))
            continue
        if os.path.getmtime(path) > stamp:
            skipped.append((n, 'file edited after verdict'))
            continue
        keep.append(n)

    print(f"resubmit candidates: {len(keep)} / {len(red)} red")
    from collections import Counter
    c = Counter(w for _, w in skipped)
    for w, k in c.most_common():
        print(f"  skip x{k}: {w}")

    with open('/tmp/resubmit_ok_red.txt', 'w') as fh:
        fh.write('\n'.join(keep) + ('\n' if keep else ''))

    if args.apply:
        if os.system("pgrep -f '[u]pload_pipeline.py' >/dev/null") == 0:
            print("ABORT: an upload_pipeline process is alive (single-writer rule)")
            return 2
        for n in keep:
            rec = st['items'][f'sol:{n}']
            rec['prev_status'] = 'done'
            rec['status'] = 'pending'
            rec['flipped_at'] = time.strftime('%Y-%m-%d %H:%M:%S')
        tmp = 'state/pipeline.json.tmp'
        with open(tmp, 'w') as fh:
            json.dump(st, fh, indent=1)
        os.replace(tmp, 'state/pipeline.json')
        print(f"flipped {len(keep)} sol(s) done -> pending")
    return 0


if __name__ == '__main__':
    sys.exit(main())
