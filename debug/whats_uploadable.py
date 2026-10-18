#!/usr/bin/env python3
"""Which pending items can be submitted RIGHT NOW, per the production guard?

"Upload what you can" needs one answer that is not a hand-rolled re-check:
the sequencer's dry stop means the guard deferred everything it saw, but the
guard's inputs change constantly (a def publishes, a def bundle gets staged
into the offline mirror, a verdict goes stale).  Re-deriving the conditions by
hand in an ad-hoc script is how a runbook drifts from the code -- this tool
calls `upload_pipeline.submission_guard`, the SAME function the submit loop
calls, so its verdict is the production verdict.

For every pending item of a kind it records either `SUBMIT` (guard returned no
verdict) or the guard's own `defer`/`park` reason, and writes the submittable
names to /tmp/uploadable_<kind>.txt.

Usage:
  PROVE2ME_SKIP_LOCAL_COMPILE=1 python3 debug/whats_uploadable.py [--kind sol]
  python3 debug/whats_uploadable.py --kind thm --kind def --reason
"""
import argparse
import collections
import json
import os
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))

import upload_pipeline as up  # noqa: E402


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--kind", action="append", default=None,
                    choices=["def", "thm", "sol"])
    ap.add_argument("--reason", action="store_true",
                    help="also print one example item per defer reason")
    args = ap.parse_args()
    kinds = args.kind or ["def", "thm", "sol"]

    st = up.load_state()
    items = st["items"]
    # The guard's platform-catalogue lookups (published defs/theorems) are
    # truthiness-gated and refuse on an API failure; failing here is better than
    # reporting a submittable set computed with dependency checking off.
    #
    # `published` is reused as the chunk's own pre-gate input (do_wave's fill()
    # calls blocked_by(item, published) BEFORE submission_guard ever runs).  A
    # verifier that only calls submission_guard reports SUBMIT for items the
    # chunk resolves as WAIT -- measured 2026-10-16: all 26 uploadable thms of
    # drain63's last rounds were `target name already declared by published def
    # bundle ChapterPvmCyclicUnitary`, so every round re-listed them, the chunk
    # deferred them in 0 s, and the drain never saw real progress.
    published = up.published_defs()

    totals = collections.Counter()
    for kind in kinds:
        ok, reasons = [], collections.defaultdict(list)
        for key, rec in sorted(items.items()):
            if rec.get("status") != "pending":
                continue
            k, _, name = key.partition(":")
            if k != kind:
                continue
            path = up.item_source(key)
            if not os.path.exists(path):
                reasons["no local source file"].append(name)
                continue
            # Mirror the chunk's fill(): the catalogue-level blocked_by checks
            # (unpublished def import, target already published, target shadowed
            # by a published def bundle, open-owner) run before the guard.
            dep = up.blocked_by(key, published)
            if dep:
                reasons[f"defer: {dep}"].append(name)
                continue
            # items= lets the guard mirror do_wave_sol's own-theorem gate
            # (see submission_guard's docstring) -- without it the sol line
            # reports SUBMIT for items the chunk resolves as WAIT.
            verdict, reason = up.submission_guard(kind, name, path,
                                                  items=st["items"])
            if verdict:
                reasons[f"{verdict}: {reason}"].append(name)
            else:
                ok.append(name)
        with open(f"/tmp/uploadable_{kind}.txt", "w") as fh:
            fh.write("\n".join(ok) + ("\n" if ok else ""))
        print(f"{kind:4s} pending={len(ok) + sum(len(v) for v in reasons.values())} "
              f"uploadable={len(ok)}  -> /tmp/uploadable_{kind}.txt")
        totals[kind] = len(ok)
        grouped = collections.Counter()
        example = {}
        for r, names in reasons.items():
            head = r.split(":")[0] + ": " + r.split(": ", 1)[1][:60] if ": " in r else r
            grouped[head] += len(names)
            example.setdefault(head, names[0])
        for head, n in grouped.most_common(25):
            line = f"    {n:5d}  {head}"
            if args.reason:
                line += f"   e.g. {example[head]}"
            print(line)
    print("\nuploadable totals: " + ", ".join(f"{k}={v}" for k, v in totals.items()))
    return 0


if __name__ == "__main__":
    sys.exit(main())
