#!/usr/bin/env python3
"""Recompute the sol upload lists from files + state (run between chunks).

PIPELINE_PLAN §2.22/§2.26/§2.29: build upload lists with the ledger and the
oracle, never from a stale text file, and never a hand-rolled thm-done check
alone -- every `import Theorems.Thm_X` in the sol must also be done.

Writes:
    /tmp/ready_sol.txt     pending sols, oracle-ok, own thm done, siblings done
    /tmp/thm_unblock.txt   pending thms, oracle-ok, that either block a ready
                           sol or are the own-thm of an oracle-ok pending sol
Prints counts.  A name is valid iff its file exists (§2.6b): sols without a
Solutions/Sol_<slug>.lean are dropped here, not downstream.
"""
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def main():
    verds = json.load(open(f"{WS}/state/offline_pending_check.json"))
    sol_v = verds["sol"]["items"]
    thm_v = verds["thm"]["items"]
    st = json.load(open(f"{WS}/state/pipeline.json"))
    pend = st["items"]

    thm_done = lambda s: pend.get("thm:" + s, {}).get("status") == "done"

    # publish-sol sweep (PIPELINE_PLAN §2.31-5/§2.31-6.5): theorems published by
    # earlier problem-waves can have a local sol file that never entered the plan
    # ledger (the 20-open-leaf class).  Register any such sol whose own thm is
    # done and whose offline verdict is already ok -- this runs between chunks
    # (the sequencer is sequential: recompute, then a chunk that loads state at
    # its own start), so the ledger write here has a single writer.
    added = 0
    if True:
        for fn in os.listdir(f"{WS}/Solutions"):
            if not (fn.startswith("Sol_") and fn.endswith(".lean")):
                continue
            s = fn[4:-5]
            if f"sol:{s}" in pend:
                continue
            if not thm_done(s) or sol_v.get(s) != "ok":
                continue
            pend[f"sol:{s}"] = {"attempts": 0, "status": "pending"}
            added += 1
        if added:
            tmp = f"{WS}/state/pipeline.json.tmp"
            with open(tmp, "w") as fh:
                json.dump(st, fh)
            os.replace(tmp, f"{WS}/state/pipeline.json")

    psols = {k[4:] for k, v in pend.items()
             if k.startswith("sol:") and v.get("status") == "pending"}

    ready, need_thm = [], []
    for s in sorted(psols):
        if not os.path.exists(f"{WS}/Solutions/Sol_{s}.lean"):
            continue
        if sol_v.get(s) != "ok":
            continue
        if thm_done(s):
            ready.append(s)
        else:
            need_thm.append(s)

    # sibling gate (the t60 lesson): every imported Thm module must be done
    blockers = {}
    ready2 = []
    for s in ready:
        txt = open(f"{WS}/Solutions/Sol_{s}.lean", encoding="utf-8").read()
        bad = [imp[4:] for imp in re.findall(r"^import Theorems\.(Thm_\S+)", txt, re.M)
               if not thm_done(imp[4:])]
        if bad:
            for b in bad:
                blockers.setdefault(b, []).append(s)
        else:
            ready2.append(s)

    thm_targets = set(blockers)
    for s in need_thm:
        if thm_v.get(s) == "ok":
            thm_targets.add(s)

    # The DEF lever (PIPELINE_PLAN §2.24/§2.33).  A gate-OK pending def bundle
    # can be submitted, but the platform refuses it with `theorem dependency not
    # proved yet: BookProof.<Chapter>.<decl>` for every `import Theorems.Thm_X`
    # it carries whose node is Open.  Those theorems are the hard prerequisite,
    # so pull them into the same thm queue -- otherwise the def chunk only ever
    # produces WAITs and the queue stays dry (the §2.24 alternating drain).
    ready_def, def_thm_deps = [], set()
    try:
        gate = json.load(open(f"{WS}/state/def_gate.json"))
    except (OSError, ValueError):
        gate = {}
    for k, v in pend.items():
        if not k.startswith("def:") or v.get("status") != "pending":
            continue
        chapter = k[4:]
        path = f"{WS}/Definitions/Def_{chapter}.lean"
        ent = gate.get(chapter)
        if not (isinstance(ent, dict) and ent.get("status") == "OK"
                and os.path.exists(path)):
            continue
        ready_def.append(chapter)
        try:
            txt = open(path, encoding="utf-8").read()
        except OSError:
            continue
        for mod in re.findall(r"(?m)^\s*import Theorems\.Thm_(\S+)", txt):
            if pend.get("thm:" + mod, {}).get("status") == "pending" \
                    and os.path.exists(f"{WS}/Theorems/Thm_{mod}.lean"):
                def_thm_deps.add(mod)
    thm_targets |= def_thm_deps

    thm_targets = {t for t in thm_targets
                   if pend.get("thm:" + t, {}).get("status") == "pending"
                   and os.path.exists(f"{WS}/Theorems/Thm_{t}.lean")}

    with open("/tmp/ready_def.txt", "w") as fh:
        fh.write("\n".join(sorted(ready_def)) + ("\n" if ready_def else ""))

    with open("/tmp/ready_sol.txt", "w") as fh:
        fh.write("\n".join(ready2) + ("\n" if ready2 else ""))
    with open("/tmp/thm_unblock.txt", "w") as fh:
        fh.write("\n".join(sorted(thm_targets)) + ("\n" if thm_targets else ""))
    print(f"ready_sol={len(ready2)} (sibling-blocked {len(ready)}) "
          f"thm_unblock={len(thm_targets)} ready_def={len(ready_def)}"
          + (f" (def-blocking thms {len(def_thm_deps)})" if def_thm_deps else "")
          + (f" (registered {added} leaf sol(s))" if added else ""))
    return 0


if __name__ == "__main__":
    sys.exit(main())
