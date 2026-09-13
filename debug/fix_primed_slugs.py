#!/usr/bin/env python3
"""Reconcile primed wave slugs with the declarations actually on disk.

`submit-problem` rejects any `theorem_name` containing a prime (§6.1), so a primed
slug can never publish. `debug/fix_primed_names.py` renamed the *declaration* to the
`_prime` convention for some of them but left the slug, the file name and the
*citations* inconsistent, which is worse than either naming: the thm splitter looks
the declaration up by slug and cannot find it, and every sibling proof that cites
`coreOp_apply'` fails with `Unknown identifier`.

Two distinct outcomes, decided per slug against the tree:

* **rename** — the stub is on disk and already declares the `_prime` form, so the
  slug, both file names and every citation move to `_prime` together.
* **drop**   — the slug names a node that can never exist: its stub is absent from
  this checkout, or its declaration identifies a *different* name (the unprimed
  sibling already published), so the entry is permanent plan noise.

Usage:
  python3 debug/fix_primed_slugs.py --dry-run
  python3 debug/fix_primed_slugs.py
"""
import argparse
import json
import os
import re
import sys

WS = os.environ.get("PROVE2ME_WS") or os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SPEC = os.path.join(WS, "pipeline", "wave_upload.json")
THMS = os.path.join(WS, "Theorems")
SOLS = os.path.join(WS, "Solutions")
DECL_RE = re.compile(r'^(?:theorem|lemma)\s+([A-Za-z_][\w.\'.!?]*)')


def declared(path):
    for line in open(path, encoding="utf-8"):
        m = DECL_RE.match(line)
        if m:
            return m.group(1)
    return None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    a = ap.parse_args()

    spec = json.load(open(SPEC))
    # slug -> (new slug, old cited name, new cited name)
    renames, drops = {}, []

    for slug in list(spec.get("thms", {})):
        if not slug.endswith("'"):
            continue
        stub = os.path.join(THMS, f"Thm_{slug}.lean")
        new = slug[:-1] + "_prime"
        decl = declared(stub) if os.path.exists(stub) else None
        leaf = decl.rsplit(".", 1)[-1] if decl else None
        # A slug is the dotted declaration with dots turned into underscores, so it
        # cannot be compared to the declaration leaf directly: the slug with the
        # prime stripped must *end* with the declaration leaf minus `_prime`.
        if leaf and leaf.endswith("_prime") and slug[:-1].endswith(leaf[: -len("_prime")]):
            # The declaration already carries `_prime`; the cited name is the prime
            # put back on (`coreOp_apply_prime` -> `coreOp_apply'`).
            renames[slug] = (new, leaf[: -len("_prime")] + "'", leaf)
        else:
            why = ("stub absent from this checkout" if not os.path.exists(stub)
                   else f"stub declares `{decl}` — a different name")
            drops.append((slug, why))

    for slug, (new, old_name, new_name) in sorted(renames.items()):
        print(f"RENAME {slug} -> {new}   (citations `{old_name}` -> `{new_name}`)")
    for slug, why in sorted(drops):
        print(f"DROP   {slug}  ({why})")
    if not renames and not drops:
        print("nothing to do")
        return 0
    if a.dry_run:
        print("\n[dry run]")
        return 0

    # Files first: the pipeline derives `Thm_<slug>.lean` / `Sol_<slug>.lean`.
    moves = []
    for slug, (new, _, _) in renames.items():
        for home, pre in ((THMS, "Thm_"), (SOLS, "Sol_")):
            old = os.path.join(home, pre + slug + ".lean")
            dst = os.path.join(home, pre + new + ".lean")
            if os.path.exists(old):
                moves.append((old, dst))

    # Citations, before the moves rename the declaration's own file.
    cited = 0
    for home in (THMS, SOLS):
        for fn in sorted(os.listdir(home)):
            if not fn.endswith(".lean"):
                continue
            p = os.path.join(home, fn)
            txt = open(p, encoding="utf-8").read()
            new_txt = txt
            for _, old_name, new_name in renames.values():
                new_txt = re.sub(r"\b" + re.escape(old_name), new_name, new_txt)
            if new_txt != txt:
                open(p, "w", encoding="utf-8").write(new_txt)
                cited += 1

    for old, dst in moves:
        os.rename(old, dst)
    for slug, (new, _, _) in renames.items():
        spec["thms"][new] = spec["thms"].pop(slug)
        spec["sol_order"] = [new if s == slug else s for s in spec["sol_order"]]
    for slug, _ in drops:
        spec["thms"].pop(slug, None)
        spec["sol_order"] = [s for s in spec["sol_order"] if s != slug]
    json.dump(spec, open(SPEC, "w"), indent=1)

    print(f"\nrenamed {len(renames)}, dropped {len(drops)}, moved {len(moves)} file(s), "
          f"rewrote citations in {cited} file(s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
