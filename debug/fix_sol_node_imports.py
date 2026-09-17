#!/usr/bin/env python3
"""Repair solution files that cite a lemma which is a NODE of another chapter.

`scripts/wave_generate.py: build_sol` now imports cross-chapter nodes for newly
generated solutions (see `cross_chapter_imports`), but solutions generated
BEFORE that fix cite such lemmas bare and the server answers
`verdict CE: ... Unknown identifier X`.  This is the sol-side repair pass that
mirrors the generator's rule:

For every identifier named in an item's recorded CE error (or cited in the
solution and declared by exactly one `Theorems/Thm_*.lean` stub), add

    import Theorems.Thm_<slug>

after the last import line.  A name declared by TWO stubs is resolved by exact
full-name match with the citing declaration's namespace guess and otherwise
left alone (reported ambiguous); a name no stub declares is reported BLOCKED.

The import is only useful once the node is PUBLISHED (a solution importing an
unpublished theorem fails with "unknown import"), so the tool checks the
platform catalogue first and skips, not burns, an attempt.  Use --force to add
the import anyway (it becomes live the moment the node publishes).

Usage:
    python3 debug/fix_sol_node_imports.py --dry-run
    python3 debug/fix_sol_node_imports.py [--only SUBSTR] [--force]
"""
import argparse
import glob
import json
import os
import re
import sys

WS = os.environ.get("PROVE2ME_WS") or os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SOLS = os.path.join(WS, "Solutions")
STATE = os.path.join(WS, "state", "pipeline.json")


def thm_index():
    """short name -> [(full name, slug)] over the workspace's Theorems stubs."""
    idx = {}
    for p in glob.glob(os.path.join(WS, "Theorems", "Thm_*.lean")):
        try:
            with open(p, encoding="utf-8") as f:
                txt = f.read()
        except OSError:
            continue
        m = re.search(r"(?m)^theorem\s+([A-Za-z_][\w'.]*)", txt)
        if not m:
            continue
        slug = os.path.basename(p)[len("Thm_"):-len(".lean")]
        idx.setdefault(m.group(1).split(".")[-1], []).append((m.group(1), slug))
    return idx


def published_theorems():
    """Full names of platform PUBLISHED problems (empty set on API failure)."""
    try:
        sys.path.insert(0, os.path.join(os.path.dirname(WS), "pipeline"))
        import upload_pipeline as u  # noqa
        jobs = u.platform_jobs()
        return {k for k, v in jobs.items()
                if v.get("kind") == "problem" and v.get("status") == "PUBLISHED"}
    except Exception:
        return set()


def last_import_line(txt):
    last = -1
    for i, line in enumerate(txt.split("\n")):
        if line.startswith("import "):
            last = i
    return last


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--only", action="append", default=[])
    ap.add_argument("--force", action="store_true",
                    help="add the import even when the node is not published yet")
    args = ap.parse_args()

    idx = thm_index()
    try:
        st = json.load(open(STATE, encoding="utf-8"))["items"]
    except Exception:
        st = {}
    pub = published_theorems()

    patched = blocked = skipped = 0
    for path in sorted(glob.glob(os.path.join(SOLS, "Sol_BookProof_*.lean"))):
        slug = os.path.basename(path)[len("Sol_"):-len(".lean")]
        if args.only and not any(s in slug for s in args.only):
            continue
        rec = st.get(f"sol:{slug}", {})
        err = rec.get("error") or ""
        if "Unknown identifier" not in err:
            continue
        with open(path, encoding="utf-8") as f:
            txt = f.read()
        missing = re.findall(r"unknown (?:identifier|constant) `([A-Za-z_][\w'.!?]*)`", err)
        missing += re.findall(r"Unknown identifier `([A-Za-z_][\w'.!?]*)`", err)
        missing = sorted(set(missing))
        if not missing:
            continue
        adds = []
        unresolved = []
        for name in missing:
            short = name.split(".")[-1]
            cands = idx.get(short) or []
            exact = [s for full, s in cands if full == name or name.endswith("." + full)]
            pick = None
            if len(exact) == 1:
                pick = exact[0]
            elif not exact and len(cands) == 1:
                pick = cands[0][1]
            if pick is None:
                unresolved.append(name)
                continue
            imp = f"import Theorems.Thm_{pick}"
            if imp in txt:
                continue
            full = dict((s, f) for f, s in cands).get(pick)
            if full and pub and full not in pub and not args.force:
                print(f"  {slug}: {pick} is not PUBLISHED yet — skipping (use --force)")
                skipped += 1
                continue
            adds.append(imp)
        if not adds:
            if unresolved:
                print(f"{slug}: BLOCKED {unresolved}")
                blocked += 1
            continue
        if args.dry_run:
            print(f"{slug}: +{adds}")
            continue
        lines = txt.split("\n")
        for imp in sorted(adds, reverse=True):
            lines.insert(last_import_line(txt) + 1, imp)
            txt = "\n".join(lines)
        with open(path, "w", encoding="utf-8") as f:
            f.write(txt)
        print(f"patched {slug}: +{len(adds)} import(s)")
        patched += 1
    print(f"\n{patched} patched, {blocked} blocked, {skipped} skipped-unpublished"
          + (" (dry run)" if args.dry_run else ""))


if __name__ == "__main__":
    main()
