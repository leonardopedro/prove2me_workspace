#!/usr/bin/env python3
"""Sweep the def bundles for the two traps that strand a §2.13 Promoted bundle.

TRAP 1 — the served copy is a SKELETON.  An early generator published some
chapters as `import Mathlib` + a header, with no declarations at all
(`Def_ChapterModeQuadraticEsa` is 370 bytes, 0 decls, while the local file has
31).  `submit-definition` cannot update an existing name, so every consumer
statement that `open`s the chapter namespace fails on the platform with
`unknown namespace` while the local mirror — which stages the workspace
text — calls it fine.  The remedy is a Promoted bundle under a new name that
carries the same declarations in the original namespace.

TRAP 2 — the Promoted bundle imports an UNPROVED theorem stub.  The harness
that adds missing imports also adds `import Theorems.Thm_*` for theorem nodes
the bundle never uses.  `submit-definition` refuses to import a non-Proved
theorem, so the bundle sits in WAIT forever:
`def:ChapterModeQuadraticEsaPromoted` waited on
`CarlemanTwoStep.ladder2_eq_zero` (Open) and
`def:ChapterGradedBandSchurEsaPromoted` on
`FockWeightedSchur.dGamma_essentiallySelfAdjointOn_core_w` (Open) — both
imports unused.  An unused import is always removable; a used one means the
bundle's proofs must be reworked (or the theorem node proved first).

This script only REPORTS.  Every verdict comes from a real source: the served
text is the platform's publish-job body, the theorem statuses are the
platform's, the declaration counts are the files'.  Nothing is submitted and
nothing in `state/` is written except this report.

Usage:
  python3 debug/sweep_skeleton_defs.py                # full sweep (API)
  python3 debug/sweep_skeleton_defs.py --no-api       # cache-only (fast)
  python3 debug/sweep_skeleton_defs.py --json path    # report location
"""
import argparse
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PUB = os.path.join(WS, "state", "published_bundles")
DEFS = os.path.join(WS, "Definitions")
sys.path.insert(0, os.path.join(WS, "pipeline"))

DECL = re.compile(
    r"(?m)^[ \t]*(?:@\[[^\]]*\]\s*)?(?:private\s+|protected\s+|noncomputable\s+)*"
    r"(?:def|theorem|lemma|abbrev|instance|structure|inductive|class)\s+"
    r"([A-Za-z_][A-Za-z0-9_.']*)")
IMPORT_THM = re.compile(r"(?m)^import Theorems\.Thm_(\S+)")


def decl_names(text):
    return set(DECL.findall(text or ""))


def full_name(slug):
    """Module slug -> platform theorem name, through the wave spec.

    Splitting the slug on `_` is wrong twice over: `BookProof_HermiteRelative
    _polySym_momPoly` is `BookProof.HermiteRelative.polySym_momPoly`, and the
    bare name is everything after the LAST dot, not after the last underscore
    (`strongResAt_of_ne_zero` would collapse to `zero`, which matches any body
    and makes every unused import look used).
    """
    import upload_pipeline as up
    rec = up.WAVE_THMS.get(slug) or up.WAVE_THMS.get(slug.replace("_prime", "'")) or {}
    name = rec.get("name")
    if not name:
        name = slug.replace("_prime", "'").replace("BookProof_", "BookProof.", 1)
    return name


def bare_name(name):
    return name.rsplit(".", 1)[-1]


def read(path):
    try:
        return open(path, encoding="utf-8", errors="ignore").read()
    except OSError:
        return ""


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--no-api", action="store_true",
                    help="skip platform reads; decide from the local cache only")
    ap.add_argument("--json", default=os.path.join(WS, "state", "skeleton_defs.json"))
    a = ap.parse_args()

    st = json.load(open(os.path.join(WS, "state", "pipeline.json")))["items"]
    gate = json.load(open(os.path.join(WS, "state", "def_gate.json")))

    # Only the theorem stubs a def bundle actually imports are queried: walking
    # every published theorem costs ~10k GETs and never finishes.  Verdicts are
    # memoized on disk so a rerun is free.
    imported_slugs = set()
    for f in sorted(os.listdir(DEFS)):
        if f.endswith(".lean") and f.startswith("Def_"):
            imported_slugs |= set(IMPORT_THM.findall(read(os.path.join(DEFS, f))))
    jobs = {}
    thm_status = {}
    cache_path = os.path.join(WS, "state", "thm_proved_cache.json")
    try:
        cache = json.load(open(cache_path))
    except (OSError, ValueError):
        cache = {}
    if not a.no_api:
        import upload_pipeline as up
        jobs = up.platform_jobs()
        for slug in sorted(imported_slugs):
            name = full_name(slug)
            if name in cache:
                thm_status[name] = cache[name]
                continue
            rec = st.get("thm:" + slug[1:] if slug.startswith("_") else "thm:" + slug) or {}
            tid = rec.get("theorem_id")
            if not tid:
                thm_status[name] = None
                continue
            s = (up.api("GET", f"theorems/{tid}") or {}).get("status")
            thm_status[name] = s
            if s:                      # never memoize a failed read
                cache[name] = s
        tmp = cache_path + ".tmp"
        json.dump(cache, open(tmp, "w"), indent=1, sort_keys=True)
        os.replace(tmp, cache_path)

    def job_status(chapter):
        j = jobs.get(chapter) or {}
        return j.get("status")

    # ---- trap 1: served copy is a skeleton -------------------------------
    skeletons = []
    for f in sorted(os.listdir(PUB)):
        if not f.endswith(".lean") or not f.startswith("Def_"):
            continue
        chapter = f[len("Def_"):-len(".lean")]
        served = read(os.path.join(PUB, f))
        served_names = decl_names(served)
        local_path = os.path.join(DEFS, f)
        local_names = decl_names(read(local_path)) if os.path.exists(local_path) else set()
        if served_names or not local_names:
            continue                     # a real bundle, or nothing to lose
        promoted = chapter + "Promoted"
        skeletons.append({
            "chapter": chapter,
            "served_bytes": len(served),
            "local_decls": len(local_names),
            "missing_examples": sorted(local_names)[:6],
            "promoted_file": os.path.exists(os.path.join(DEFS, f"Def_{promoted}.lean")),
            "promoted_platform": job_status(promoted),
            "promoted_pipeline": (st.get("def:" + promoted) or {}).get("status"),
            "promoted_gate": (gate.get(promoted) or {}).get("status"),
            "parent_gate": (gate.get(chapter) or {}).get("status"),
        })

    # ---- trap 2: def bundle imports an unproved theorem stub ------------
    blocked = []
    for f in sorted(os.listdir(DEFS)):
        if not f.endswith(".lean") or not f.startswith("Def_"):
            continue
        chapter = f[len("Def_"):-len(".lean")]
        # Only an UNPUBLISHED bundle can still be stranded by this trap; a
        # published one is history, and flagging it buries the live cases.
        if (st.get("def:" + chapter) or {}).get("status") == "done":
            continue
        text = read(os.path.join(DEFS, f))
        imports = IMPORT_THM.findall(text)
        if not imports:
            continue
        body = IMPORT_THM.sub("", text)
        for slug in imports:
            name = full_name(slug)
            status = thm_status.get(name)
            if status == "Proved":
                continue
            bare = bare_name(name)
            used = re.search(r"(?<![A-Za-z0-9_.'])" + re.escape(bare) + r"(?![A-Za-z0-9_'])", body)
            blocked.append({
                "chapter": chapter,
                "imported": slug,
                "theorem_status": status,
                "used_in_body": bool(used),
                "pipeline": (st.get("def:" + chapter) or {}).get("status"),
                "platform": job_status(chapter),
            })

    out = {"skeletons": skeletons, "unproved_imports": blocked}
    tmp = a.json + ".tmp"
    json.dump(out, open(tmp, "w"), indent=1, sort_keys=True)
    os.replace(tmp, a.json)

    print(f"skeleton served copies (0 decls, local decls present): {len(skeletons)}")
    for s in skeletons:
        print(f"  {s['chapter']:40s} local={s['local_decls']:3d} "
              f"promoted(platform)={s['promoted_platform']} "
              f"pipeline={s['promoted_pipeline']} gate={str(s['promoted_gate'])[:40]}")
    todo = [s for s in skeletons if s["promoted_platform"] != "PUBLISHED"]
    print(f"  -> needing a Promoted bundle published: {len(todo)}")
    for s in todo:
        print(f"     {s['chapter']}: file={s['promoted_file']} gate={s['promoted_gate']}")

    print(f"\ndef bundles importing a non-Proved theorem stub: {len(blocked)}")
    for b in blocked:
        print(f"  {b['chapter']:40s} {b['imported'][:58]:58s} "
              f"status={b['theorem_status']} used={b['used_in_body']} "
              f"pipeline={b['pipeline']} platform={b['platform']}")
    free = [b for b in blocked if not b["used_in_body"] and b["platform"] != "PUBLISHED"]
    print(f"  -> unpublishable with an UNUSED import (removable): {len(free)}")
    for b in free:
        print(f"     {b['chapter']}")
    print(f"\nreport: {a.json}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
