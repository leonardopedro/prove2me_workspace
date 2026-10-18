#!/usr/bin/env python3
"""Retire the OLD half of every `<slug>_inc` replacement pair in the ledger.

For each wave thm slug `_inc` whose replacement was accepted (both ledger
items `done`) the ORIGINAL slug can never become submittable again:

  thm:<old>  the target name is already declared by a *published* Def bundle
             (`has already been declared` in state/thm_gate.json) — the
             statement will never publish under its own name;
  sol:<old>  the published target type is the dropped-include statement
             (§2.64), so no proof can ever match it — the server answers
             `Your proof does not match the target type`, burning one of the
             five attempts per visit.

Leaving them `pending` makes every drain re-evaluate them forever (`defer`,
zero information).  `parked` is terminal in upload_pipeline: dispatch skips
parked items entirely (run_chunk / do_wave check status first), so a parked
item is never submitted, never counted against the plan, and never burns an
attempt.

Old items that are already `done` or `parked` are left untouched.  Nothing
here writes to the platform: this is ledger-only retirement.

Single-writer: refuses to write while an upload_pipeline process is alive.

Usage:
  python3 debug/retire_shadowed_inc.py            # dry run
  python3 debug/retire_shadowed_inc.py --apply    # write state/pipeline.json
"""
import argparse
import json
import os
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402

LED = os.path.join(WS, "state", "pipeline.json")


def pipeline_alive():
    """True only for a real `python .../upload_pipeline.py` process.

    `pgrep -f upload_pipeline.py` also matches the wrapping `bash -c` of a
    command line that merely MENTIONS the script (false positive measured
    2026-10-18: a composite shell command refused to write), so the process
    executable must be python.
    """
    out = subprocess.run(["pgrep", "-a", "-f", "upload_pipeline.py"],
                         capture_output=True, text=True).stdout
    for line in out.splitlines():
        _, _, cmd = line.partition(" ")
        exe = cmd.strip().split(" ", 1)[0]
        if os.path.basename(exe).startswith("python"):
            return True
    return False


def replacements(wave):
    """old_slug -> list of accepted replacement slugs (`_inc` suffix)."""
    out = {}
    for new in wave["thms"]:
        if not new.endswith("_inc"):
            continue
        old = new[: -len("_inc")]
        rec = up.load_state().get("items", {})
        out.setdefault(old, []).append(new)
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true")
    ap.add_argument("--backup", default=None)
    a = ap.parse_args()

    st = json.load(open(LED))
    items = st["items"]
    wave = json.load(open(os.path.join(WS, "pipeline", "wave_upload.json")))

    retired, skipped = [], []
    for new in sorted(s for s in wave["thms"] if s.endswith("_inc")):
        old = new[: -len("_inc")]
        if not (items.get("thm:" + new, {}).get("status") == "done"
                and items.get("sol:" + new, {}).get("status") == "done"):
            skipped.append((old, "replacement not fully accepted"))
            continue
        for kind in ("thm", "sol"):
            item = f"{kind}:{old}"
            rec = items.get(item)
            if rec is None:
                continue
            if rec.get("status") != "pending":
                if rec.get("status") != "parked":
                    skipped.append((item, f"status={rec.get('status')}"))
                continue
            if kind == "thm":
                reason = ("superseded: target name already declared by the "
                          "published def bundle; statement lives in the bundle "
                          f"and in {new}.")
            else:
                reason = ("superseded: accepted as Sol_%s; the old published "
                          "target type can never match a proof (dropped-"
                          "include class)." % new)
            items[item] = {"status": "parked",
                           "attempts": rec.get("attempts") or 0,
                           "error": reason[:300]}
            retired.append(item)

    print(f"retire: {len(retired)} item(s), skip {len(skipped)}")
    for it in retired:
        print("  park ", it)
    for it, why in skipped:
        print("  keep ", it, "|", why)

    if not a.apply:
        print("dry run — nothing written (use --apply)")
        return 0
    if not retired:
        print("nothing to write")
        return 0
    if pipeline_alive():
        print("refusing: an upload_pipeline process is alive (single-writer)")
        return 1
    backup = a.backup or LED + ".bak_retire_inc"
    shutil.copy(LED, backup)
    tmp = LED + ".tmp"
    json.dump(st, open(tmp, "w"), separators=(",", ":"))
    os.replace(tmp, LED)
    print(f"wrote {LED} (backup {backup})")
    return 0


if __name__ == "__main__":
    sys.exit(main())