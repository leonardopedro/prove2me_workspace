#!/usr/bin/env python3
"""Drop unpublished `import Definitions.Def_X` lines from solution files.

2675 pending sols import >=1 def bundle the platform does not hold; the
offline oracle answers `object file ... not found` and a submit would burn an
attempt.  Sometimes the import is droppable anyway -- a regenerated sol
imports a bundle whose declarations the PREVIOUSLY published bundle still
provides (chapter splits / drift), or the import is simply extra.

Blind drop + verify loop:
  1. `--apply [--limit N]`  removes the lines, backing every file up to
     /tmp/sols_drop_backup/ and recording the drops in drops.json;
  2. run `check_pending_offline --kind sol` over the touched slugs;
  3. slugs now `ok` keep the edit; slugs FAILing with an unknown identifier
     get the import of THAT bundle re-added -- `--restore slug1,slug2` or
     `--restore-failed` (reads the recheck verdicts itself).

Usage:
  python3 debug/drop_unpub_sol_imports.py --apply [--limit 40]
  python3 debug/drop_unpub_sol_imports.py --restore-failed
  python3 debug/drop_unpub_sol_imports.py --restore sol_a,sol_b
"""
import argparse
import json
import os
import re
import shutil
import sys

WS = os.environ.get("PROVE2ME_WS") or os.getcwd()
SOLS = os.path.join(WS, "Solutions")
MANIFEST = os.path.join(WS, "state", "published_bundles", "manifest.json")
BACKUP = "/tmp/sols_drop_backup"
DROPS = os.path.join(BACKUP, "drops.json")
OFF = os.path.join(WS, "state", "offline_pending_check.json")
IMP = re.compile(r"^import\s+Definitions\.Def_(\S+)\s*$")


def load_drops():
    try:
        return json.load(open(DROPS))
    except (OSError, ValueError):
        return {}


def save_drops(d):
    os.makedirs(BACKUP, exist_ok=True)
    with open(DROPS, "w") as fh:
        json.dump(d, fh, indent=1, sort_keys=True)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true")
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--restore", default="", help="comma list of slugs")
    ap.add_argument("--restore-failed", action="store_true",
                    help="re-add dropped imports for slugs still FAILing")
    a = ap.parse_args()

    man = set(json.load(open(MANIFEST)))
    drops = load_drops()

    if a.restore or a.restore_failed:
        slugs = [s for s in a.restore.split(",") if s] if a.restore else []
        if a.restore_failed:
            off = json.load(open(OFF))
            for slug in drops:
                v = off.get("sol", {}).get("items", {}).get(slug)
                if isinstance(v, str) and v.startswith("FAIL"):
                    slugs.append(slug)
        seen = set()
        for slug in slugs:
            if slug in seen or slug not in drops:
                continue
            seen.add(slug)
            rec = drops[slug]
            path = os.path.join(SOLS, f"Sol_{slug}.lean")
            lines = open(path, encoding="utf-8").read().split("\n")
            for i, text in sorted(rec["dropped"], key=lambda p: -p[0]):
                lines.insert(i, text)
            open(path, "w", encoding="utf-8").write("\n".join(lines))
            del drops[slug]
            print(f"restored {len(rec['dropped'])} import(s): {slug}")
        save_drops(drops)
        print(f"{len(seen)} file(s) restored")
        return 0

    if not a.apply:
        ap.error("--apply / --restore / --restore-failed required")

    st = json.load(open(os.path.join(WS, "state", "pipeline.json")))["items"]
    touched = []
    for key, rec in sorted(st.items()):
        if not key.startswith("sol:") or not isinstance(rec, dict):
            continue
        if rec.get("status") != "pending":
            continue
        slug = key[4:]
        path = os.path.join(SOLS, f"Sol_{slug}.lean")
        if not os.path.exists(path):
            continue
        text = open(path, encoding="utf-8").read()
        lines = text.split("\n")
        idx = [i for i, l in enumerate(lines)
               if (m := IMP.match(l)) and m.group(1) not in man]
        if not idx:
            continue
        dropped = [(i, lines[i]) for i in idx]
        os.makedirs(BACKUP, exist_ok=True)
        bpath = os.path.join(BACKUP, f"Sol_{slug}.lean")
        if not os.path.exists(bpath):
            shutil.copyfile(path, bpath)
        keep = [l for i, l in enumerate(lines)
                if not any(i == j for j in idx)]
        open(path, "w", encoding="utf-8").write("\n".join(keep))
        drops[slug] = {"dropped": dropped}
        touched.append(slug)
        if a.limit and len(touched) >= a.limit:
            break
    save_drops(drops)
    print(f"{len(touched)} sol(s) dropped unpublished imports "
          f"(backup: {BACKUP})")
    with open("/tmp/drop_touched.txt", "w") as fh:
        fh.write("\n".join(touched))
    return 0


if __name__ == "__main__":
    sys.exit(main())
