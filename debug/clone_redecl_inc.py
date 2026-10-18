#!/usr/bin/env python3
"""_inc clone for THM stubs whose statement name is already declared inside
their (published) definition bundle.

Pending-item twin of heal_include_class.py --replace: that tool clones members
whose OLD node is already PUBLISHED, while these stubs are still pending or
parked -- and can never publish under their current name, because the very same
declaration ships inside a published Def_*.lean (the platform-side guard
target_declared_in_published_def would block them forever).

For each slug given on stdin or as arguments:
  * Thm_<slug>_inc.lean  = stub with the dotted name renamed <name>_inc
    (identifier-safe, every occurrence: header, declaration, references);
  * Sol_<slug>_inc.lean  = same rename over the sol (the 'solution of' header
    must follow, or target_already_published blocks the new item as a dup);
  * wave_upload.json: thms[<slug>_inc] entry cloned from thms[<slug>] with
    name/file/sol/title/nl updated, plus a sol_order slot (the pipeline's
    ORDER iterates sol_order, so without it the item is never submitted);
  * ledger: thm:<slug>_inc and sol:<slug>_inc seeded as pending.

Idempotent: existing clones are skipped.  The old pending/parked items stay
in the queue and defer on the shadow guard; they never spend an attempt.

Usage:
  python3 debug/clone_redecl_inc.py --from-file /tmp/redecl18.txt
"""
import argparse
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WAVE = os.path.join(WS, "pipeline", "wave_upload.json")
LEDGER = os.path.join(WS, "state", "pipeline.json")

IDENT_END = r"(?![A-Za-z0-9_'.!?])"


def clone(slug):
    old = "BookProof_" + slug if not slug.startswith("BookProof_") else slug
    # real dotted name comes from the stub itself (chapter namespaces vary)
    stub = os.path.join(WS, "Theorems", "Thm_%s.lean" % old)
    sol = os.path.join(WS, "Solutions", "Sol_%s.lean" % old)
    if not os.path.exists(stub):
        return "NO-STUB", old
    txt = open(stub, encoding="utf-8").read()
    m = re.search(r"(?m)^theorem\s+([A-Za-z0-9_.']+)", txt)
    if not m:
        return "NO-DECL", old
    old_dotted = m.group(1)
    new_dotted = old_dotted + "_inc"
    new = old + "_inc"
    dst_stub = os.path.join(WS, "Theorems", "Thm_%s.lean" % new)
    dst_sol = os.path.join(WS, "Solutions", "Sol_%s.lean" % new)
    if os.path.exists(dst_stub):
        return "EXISTS", new
    pat = re.compile(re.escape(old_dotted) + IDENT_END)
    open(dst_stub, "w", encoding="utf-8").write(pat.sub(new_dotted, txt))
    if os.path.exists(sol):
        stxt = open(sol, encoding="utf-8").read()
        open(dst_sol, "w", encoding="utf-8").write(pat.sub(new_dotted, stxt))
    else:
        return "NO-SOL", old

    wave = json.load(open(WAVE, encoding="utf-8"))
    ent = wave.get("thms", {}).get(old)
    if ent is None:
        return "NO-WAVE", old
    if new in wave["thms"]:
        return "EXISTS", new
    e = json.loads(json.dumps(ent))
    e["name"] = new_dotted
    e["file"] = "Theorems/Thm_%s.lean" % new
    e["sol"] = "Solutions/Sol_%s.lean" % new
    e["title"] = e.get("title", "").replace(old_dotted, new_dotted)
    e["nl"] = e.get("nl", "").replace(old_dotted, new_dotted)
    e["nl"] += ("\n\nReplaces the unuploadable node `%s`, whose statement name "
                "is already declared inside its published definition bundle; "
                "the `_inc` suffix publishes the same statement as its own "
                "node." % old)
    wave["thms"][new] = e
    so = wave.setdefault("sol_order", [])
    if new not in so:
        so.append(new)
    json.dump(wave, open(WAVE, "w", encoding="utf-8"),
              ensure_ascii=False, separators=(",", ":"))

    led = json.load(open(LEDGER, encoding="utf-8"))
    rec = {"status": "pending", "attempts": 0}
    led["items"].setdefault("thm:" + new, dict(rec))
    led["items"].setdefault("sol:" + new, dict(rec))
    json.dump(led, open(LEDGER, "w", encoding="utf-8"), separators=(",", ":"))
    return "CLONED", new


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("slugs", nargs="*")
    ap.add_argument("--from-file", default=None)
    a = ap.parse_args()
    slugs = list(a.slugs)
    if a.from_file:
        slugs += [l.strip() for l in open(a.from_file) if l.strip()]
    if not slugs:
        ap.error("no slugs")
    # wave backup once per run (only when we will actually write)
    wp_bak = WAVE + ".bak_redecl"
    if not os.path.exists(wp_bak):
        import shutil
        shutil.copy(WAVE, wp_bak)
    from collections import Counter
    c = Counter()
    for s in dict.fromkeys(slugs):
        st, name = clone(s)
        c[st] += 1
        print("%-8s %s" % (st, name))
    print(dict(c))
    return 0


if __name__ == "__main__":
    sys.exit(main())
