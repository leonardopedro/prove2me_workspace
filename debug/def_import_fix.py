"""Close the gap between the workspace def text and the platform's, one error at a time.

Published def bundles are pruned: the lemmas a chapter declares beside its
definitions are dropped and republished as `Thm_*` nodes.  A def bundle that
proved something with them therefore fails on the platform with `Unknown
identifier` / `Invalid field` while the workspace copy compiles.

This drives `debug/pubstage_check.py` (the platform-truth world) and, for each
unresolved name the compiler reports, adds the theorem-node import that provides
it.  Names with no node are reported as UNRESOLVED and left alone -- the fix
there is a proof change, not an import.

Usage: python3 debug/def_import_fix.py Def_ChapterFoo [--rounds 12] [--write]
"""
import argparse
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import pubstage_check as PS  # noqa: E402

WS = PS.WS
IMPORT_THM = re.compile(r"^import\s+Theorems\.(Thm_\w+)", re.M)


def node_index():
    """declared name (last component) -> [Thm modules]."""
    out = {}
    for f in os.listdir(os.path.join(WS, "Theorems")):
        if not (f.startswith("Thm_") and f.endswith(".lean")):
            continue
        m = re.search(r"(?m)^theorem\s+([A-Za-z_][\w.'!?]*)",
                      open(os.path.join(WS, "Theorems", f), errors="ignore").read())
        if m:
            out.setdefault(m.group(1).split(".")[-1], []).append(f[:-5])
    return out


def opened_ns(path):
    """Namespaces a bundle `open`s (`open BookProof.Foo Bar` -> {Foo, Bar})."""
    out = set()
    for line in open(path, encoding="utf-8"):
        if not line.startswith("open"):
            continue
        for tok in line.split():
            if tok.startswith("BookProof."):
                out.add(tok.split(".", 1)[1].split(".")[0])
    return out


def add_imports(path, mods):
    txt = open(path, encoding="utf-8").read()
    have = set(IMPORT_THM.findall(txt))
    adds = [f"import Theorems.{m}" for m in mods if m not in have]
    if not adds:
        return False
    lines = txt.split("\n")
    at = max(i for i, l in enumerate(lines) if l.startswith("import "))
    lines[at + 1:at + 1] = adds
    open(path, "w", encoding="utf-8").write("\n".join(lines))
    return True


def main(argv):
    ap = argparse.ArgumentParser()
    ap.add_argument("chapters", nargs="+")
    ap.add_argument("--rounds", type=int, default=12)
    ap.add_argument("--write", action="store_true")
    a = ap.parse_args(argv)

    PS.ensure_stage()
    env, base, lean = PS.lean_cmd()
    lean_path = f"{PS.STAGE}:{PS.MIRROR}:{base}"
    idx = node_index()
    for ch in a.chapters:
        name = ch if ch.startswith("Def_") else f"Def_{ch}"
        path = os.path.join(WS, "Definitions", f"{name}.lean")
        for rnd in range(a.rounds):
            rc, err, bad = PS.check_one(name, lean, lean_path, quiet=True)
            if rc == 0:
                print(f"== {ch}: OK after {rnd} import round(s)")
                break
            if bad:
                print(f"== {ch}: BLOCKED by unbuildable stub {bad[0]}")
                break
            # The compiler words the same gap a few ways; a dotted name is one the
            # proof reaches through a structure (`CoreRep.op_apply`).
            names = []
            for pat in (r"Unknown identifier [`']([A-Za-z_][\w.'!?]*)",
                        r"Unknown constant [`']([A-Za-z_][\w.'!?]*)",
                        r"Invalid field [`](\w+)"):
                names += re.findall(pat, err)
            mods, missing = [], []
            opens = opened_ns(path)
            for n in names:
                n = n.strip("`'")
                c = idx.get(n.split(".")[-1]) or []
                if len(c) > 1:
                    # Same short name in several chapters: the one whose namespace
                    # this bundle `open`s is the one the proof means.
                    preferred = [m for m in c
                                 if any(m.startswith(f"Thm_BookProof_{o}_") for o in opens)]
                    c = preferred if len(preferred) == 1 else c
                if len(c) == 1:
                    mods.append(c[0])
                else:
                    missing.append((n, len(c)))
            mods = list(dict.fromkeys(mods))
            print(f"  {ch} r{rnd}: {err.split(': error')[0][-90:].strip()} -> +{mods} "
                  + (f"UNRESOLVED {missing}" if missing else ""))
            if not mods:
                print(f"== {ch}: no theorem node for {[m[0] for m in missing]} -- "
                      f"needs a proof change, not an import")
                break
            if a.write:
                add_imports(path, mods)
            else:
                break


if __name__ == "__main__":
    main(sys.argv[1:])
