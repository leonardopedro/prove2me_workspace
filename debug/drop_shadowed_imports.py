#!/usr/bin/env python3
"""Drop shadowed Thm imports from pending sols (the §2.62 repair).

A Thm statement whose target name a PUBLISHED def bundle already declares can
never be published through our thm column (`target name already declared by
published def bundle ...`), so its `Theorems.Thm_X` module never exists on the
platform.  A sol that imports it is gated forever by `unpublished_sibling_
imports` -- measured 2026-10-17: 144 pending sols carry at least one such dead
import (e.g. Sol_..._integral_stateMeasure_ofReal imported
Thm_..._integral_rieszStateMeasure while the published
Def_ChapterAbelianGelfandModel declares `theorem integral_rieszStateMeasure`
at line 111 itself).

The import is redundant, not just dead: the sol already imports the owning
`Definitions.Def_<chapter>` module, which carries the same declaration, so the
name resolves from there.  This tool removes the dead import line when ALL of:

  1. the Thm item is not `done` (a done thm has a published module -- keep it);
  2. `target_declared_in_published_def` names a shadowing published bundle;
  3. the sol itself imports `Definitions.Def_<that bundle>`;
  4. the published bundle text (state/published_bundles/) declares the leaf
     name top-level (theorem/lemma/def/abbrev/instance, attributes allowed).

Anything else is reported and left untouched.  Apply writes a one-time backup
(`<sol>.bak_shadowdrop`) and never touches the proof body.  After --apply, run
`debug/check_sol_local.py --from-file` over the edited slugs: the local gate
against /tmp/published_mirror is the final word before the drain submits.

Usage:
  PROVE2ME_SKIP_LOCAL_COMPILE=1 python3 debug/drop_shadowed_imports.py [--reason]
  PROVE2ME_SKIP_LOCAL_COMPILE=1 python3 debug/drop_shadowed_imports.py --apply
"""
import argparse
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402

IMPORT_RE = re.compile(r"^import Theorems\.(Thm_\S+)\s*$", re.M)
STMT_NAME_RE = re.compile(r"(?m)^(?:@\[[^\]]*\]\s*)?(?:theorem|lemma)\s+([A-Za-z0-9_. '!?-]+?)\s*(?:\(|:|{|\[)")
DECL_RE_TMPL = r"(?m)^(?:@\[[^\]]*\]\s*)?(?:theorem|lemma|def|abbrev|instance)\s+%s(?![A-Za-z0-9_'])"


def leaf_of_stub(slug):
    """Bare leaf name the Thm stub declares (last component of its target)."""
    try:
        txt = open(f"{WS}/Theorems/Thm_{slug}.lean", encoding="utf-8").read()
    except OSError:
        return None
    m = re.search(r"(?m)^theorem\s+([A-Za-z0-9_. '!?-]+?)\s*(?:\(|:|{|\[)", txt)
    if not m:
        return None
    return m.group(1).rsplit(".", 1)[-1]


def bundle_declares(bundle, leaf):
    try:
        txt = open(f"{WS}/state/published_bundles/Def_{bundle}.lean", encoding="utf-8").read()
    except OSError:
        return False
    return bool(re.search(DECL_RE_TMPL % re.escape(leaf), txt))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true")
    ap.add_argument("--reason", action="store_true")
    ap.add_argument("--from-file", default=None,
                    help="sol slugs (one per line) instead of all pending sols")
    args = ap.parse_args()

    st = up.load_state()
    items = st["items"]
    if args.from_file:
        slugs = [l.strip() for l in open(args.from_file) if l.strip()]
    else:
        slugs = sorted(k[4:] for k, rec in items.items()
                       if k.startswith("sol:") and rec.get("status") == "pending")

    plan, skipped = {}, {}
    add_def = {}   # slug -> {bundle} to ADD while dropping (leaf verified above)
    for slug in slugs:
        path = f"{WS}/Solutions/Sol_{slug}.lean"
        if not os.path.exists(path):
            skipped.setdefault("no sol file", []).append(slug)
            continue
        txt = open(path, encoding="utf-8").read()
        dead = []
        for mod in IMPORT_RE.findall(txt):
            xslug = mod[4:]
            trec = items.get(f"thm:{xslug}") or {}
            if trec.get("status") == "done":
                continue                       # module is (or will be) published
            bundle = up.target_declared_in_published_def(f"thm:{xslug}")
            if not bundle:
                skipped.setdefault("import not shadowed (module may still publish)", []).append(f"{slug} <- {xslug}")
                continue
            leaf = leaf_of_stub(xslug)
            if not leaf or not bundle_declares(bundle, leaf):
                skipped.setdefault("leaf not declared in published bundle text", []).append(f"{slug} <- {bundle}.{leaf}")
                continue
            # The leaf is verified in the published bundle text, so the drop is
            # safe either way.  If the sol does NOT import that bundle yet, the
            # name would vanish with the Thm module -- record the Def import to
            # ADD (reverse case: e.g. sols of shadowed NavierStokesEsa/IkebeKato
            # siblings blocked with `sibling theorem not published ...`).
            if f"import Definitions.Def_{bundle}" not in txt:
                add_def.setdefault(slug, set()).add(bundle)
            dead.append(mod)
        if dead:
            plan[slug] = dead

    for reason, ex in sorted(skipped.items()):
        print(f"skip [{reason}]: {len(ex)}  e.g. {ex[:2]}")
    print(f"repairable sols: {len(plan)}")

    if not args.apply:
        for slug, mods in list(plan.items())[:10]:
            print(f"  would drop {len(mods)} import(s) from {slug}")
        return 0

    edited = []
    for slug, mods in plan.items():
        path = f"{WS}/Solutions/Sol_{slug}.lean"
        bak = path + ".bak_shadowdrop"
        if not os.path.exists(bak):
            open(bak, "w", encoding="utf-8").write(open(path, encoding="utf-8").read())
        txt = open(path, encoding="utf-8").read()
        for mod in mods:
            txt = txt.replace(f"import Theorems.{mod}\n", "")
        for bundle in sorted(add_def.get(slug, ())):
            imp = f"import Definitions.Def_{bundle}\n"
            if imp not in txt:
                lines = txt.splitlines(keepends=True)
                last = max(i for i, l in enumerate(lines) if l.startswith("import "))
                lines.insert(last + 1, imp)
                txt = "".join(lines)
        open(path, "w", encoding="utf-8").write(txt)
        edited.append(slug)
    out = "/tmp/shadowdrop_edited.txt"
    open(out, "w").write("\n".join(edited) + "\n")
    print(f"edited {len(edited)} sol(s); slug list -> {out}")
    print(f"next: python3 debug/check_sol_local.py --from-file {out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
