#!/usr/bin/env python3
"""Gate one def bundle, repairing each `BLOCKED by Thm_*` the way it is really caused.

`regate_bundles` marks a bundle BLOCKED when one of the `Theorems.*` stubs it
imports cannot build in our mirror.  Measured 2026-11-04 over the Sm chain,
**every** such stub failed with

    `BookProof.<Ns>.<name>` has already been declared

and the declaring module was the mirror's copy of a `Def_` bundle holding the
workspace DRAFT, while the platform serves the pruned text that declares only
definitions (the lemmas are republished as the `Thm_` node the bundle imports).
The mirror olean was therefore built from text the platform does not have —
the class PIPELINE_PLAN §Session 32 describes ("a mirror `.olean` older than its
staged `.lean` makes the gate lie"), except here the text is newer, not older.

Two repairs, both mechanical, neither touching the bundle's proof:

1. **mirror holds a draft** (served text does not declare the name): reset the
   mirror copy to `state/published_bundles/<mod>.lean` and rebuild its olean.
   The stub then builds and the bundle gates on real evidence.
2. **served text declares the name too** (a true duplicate): the import is
   redundant — the served bundle already provides it — so drop that one import
   line from the consumer.  Nothing else in the bundle changes.

Backups land in `state/scratch/mirror_served_bak/` (never `/tmp`).

Usage: python3 debug/unblock_def_bundle.py ChapterSmFarisLavine [--rounds 6] [--dry-run]
"""
import argparse
import json
import os
import re
import shutil
import subprocess
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MIRROR = os.environ.get("CANDIDATE_MIRROR", os.path.join(WS, "state/mirror"))
PUB = os.path.join(WS, "state/published_bundles")
PROJ = os.environ.get("TIMEPIECE_PROJ",
                      os.path.join(WS, "..", "timepiece331"))
BAK = os.path.join(WS, "state", "scratch", "mirror_served_bak")
DECL = re.compile(r"^\s*(?:@\[[^\]]*\]\s*)*(?:protected\s+|private\s+|nonrec\s+)*"
                  r"(?:def|abbrev|theorem|lemma|instance|structure|class|inductive|opaque)\s+"
                  r"([^\s({:]+)", re.M)


def lake(cmd):
    return subprocess.run(["lake", "env", "bash", "-c", cmd], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()


def compiler():
    base = lake('printf %s "$LEAN_PATH"')
    lean = lake("command -v lean")
    return lean, f"{MIRROR}:{base}"


def lean_compile(lean, lean_path, rel, out=None):
    """(rc, first error line) for one module inside the mirror."""
    args = [lean] + (["-o", out] if out else []) + [rel]
    r = subprocess.run(args, cwd=MIRROR, capture_output=True, text=True,
                       env=dict(os.environ, LEAN_PATH=lean_path))
    out_txt = (r.stdout or "") + (r.stderr or "")
    err = next((l for l in out_txt.splitlines() if "error" in l), "")
    return r.returncode, err.strip()


def declaring_module(name):
    """Mirror `Definitions.*` module whose text declares `name` (leaf), if any."""
    leaf = name.split(".")[-1]
    hits = []
    d = os.path.join(MIRROR, "Definitions")
    for fn in sorted(os.listdir(d)):
        if not (fn.startswith("Def_") and fn.endswith(".lean")):
            continue
        txt = open(os.path.join(d, fn), encoding="utf-8", errors="ignore").read()
        for m in DECL.finditer(txt):
            if m.group(1).split(".")[-1] == leaf:
                hits.append(fn[:-5])
                break
    return hits


def reset_from_served(mod, lean, lean_path, dry=False):
    """Stage the SERVED text into the mirror and rebuild its olean.

    Returns (status, detail).  The mirror's `.lean` is unlinked first because
    `state/pubstage` is a hardlink farm off it — writing in place would rewrite
    the staged copy too.
    """
    src = os.path.join(PUB, f"{mod}.lean")
    if not os.path.exists(src):
        return "NOSERVED", "no state/published_bundles copy"
    dst = os.path.join(MIRROR, "Definitions", f"{mod}.lean")
    ol = dst[:-5] + ".olean"
    served = open(src, encoding="utf-8").read()
    if not dry:
        os.makedirs(BAK, exist_ok=True)
        for p in (dst, ol):
            if os.path.exists(p):
                shutil.copy2(p, os.path.join(BAK, os.path.basename(p)))
        if os.path.exists(dst):
            os.remove(dst)
        open(dst, "w", encoding="utf-8").write(served)
        if os.path.exists(ol):
            os.remove(ol)
        rc, err = lean_compile(lean, lean_path, os.path.join("Definitions", f"{mod}.lean"), ol)
        if rc != 0:
            for p in (dst, ol):
                b = os.path.join(BAK, os.path.basename(p))
                if os.path.exists(b):
                    if os.path.exists(p):
                        os.remove(p)
                    shutil.copy2(b, p)
            return "SERVED-COMPILE-FAIL", err[:160]
    return "RESET", "mirror now holds the served text"


def drop_imports(path, mods):
    lines = open(path, encoding="utf-8").read().split("\n")
    out = [l for l in lines
           if not any(l.strip() == f"import Theorems.{m}" for m in mods)]
    if len(out) == len(lines):
        return []
    open(path, "w", encoding="utf-8").write("\n".join(out))
    return mods


def regate(target, jobs):
    """Run regate_bundles on one target and return its fresh def_gate status."""
    tf = os.path.join(WS, "state", "scratch", "unblock_one.txt")
    with open(tf, "w") as fh:
        fh.write(target + "\n")
    r = subprocess.run([sys.executable, os.path.join(WS, "debug", "regate_bundles.py"),
                        "--targets-file", tf, "--jobs", str(jobs)],
                       capture_output=True, text=True,
                       cwd=WS, env=dict(os.environ, CANDIDATE_MIRROR=MIRROR,
                                        TIMEPIECE_PROJ=PROJ))
    out = (r.stdout or "") + (r.stderr or "")
    try:
        gate = json.load(open(os.path.join(WS, "state", "def_gate.json")))
        ent = gate.get(target[4:] if target.startswith("Def_") else target)
        if isinstance(ent, dict) and ent.get("status"):
            return str(ent["status"])
    except (OSError, ValueError):
        pass
    return out.strip().splitlines()[-1:][0] if out.strip() else "(no verdict)"


def main(argv):
    ap = argparse.ArgumentParser()
    ap.add_argument("chapters", nargs="+")
    ap.add_argument("--rounds", type=int, default=6)
    ap.add_argument("--jobs", type=int, default=2)
    ap.add_argument("--dry-run", action="store_true")
    a = ap.parse_args(argv)
    lean, lean_path = compiler()
    for ch in a.chapters:
        name = ch[4:] if ch.startswith("Def_") else ch
        path = os.path.join(WS, "Definitions", f"Def_{name}.lean")
        for rnd in range(a.rounds):
            line = regate(f"Def_{name}", a.jobs)
            print(f"  {name} r{rnd}: {line}")
            if line.startswith("OK"):
                break
            m = re.search(r"BLOCKED by Thm_(Thm_\S+)", line)
            if not m:
                print(f"== {name}: not a stub-build block -- needs a proof change")
                break
            stub = m.group(1)
            rc, err = lean_compile(lean, lean_path,
                                   os.path.join("Theorems", f"{stub}.lean"),
                                   os.path.join("Theorems", f"{stub}.olean"))
            if rc == 0:
                print(f"    built stub {stub}")
                continue
            dup = re.search(r"`([\w.]+)` has already been declared", err)
            if not dup:
                print(f"== {name}: stub {stub} fails for another reason: {err[:140]}")
                break
            full = dup.group(1)
            provs = declaring_module(full)
            if not provs:
                print(f"== {name}: {full} declared but no mirror bundle found")
                break
            mods = [p for p in provs
                    if re.search(rf"(?m)^\s*(?:theorem|lemma|def)\s+{re.escape(full.split('.')[-1])}\b",
                                 open(os.path.join(PUB, f"{p}.lean"), encoding="utf-8",
                                      errors="ignore").read())]
            if mods:
                if a.dry_run:
                    print(f"    would drop redundant import {stub} (served {mods[0]} declares {full})")
                    break
                dropped = drop_imports(path, [stub])
                print(f"    dropped redundant import Theorems.{stub} "
                      f"(served {mods[0]} declares it) {dropped}")
                continue
            for p in provs:
                st, det = reset_from_served(p, lean, lean_path, a.dry_run)
                print(f"    {p}: {st} ({det})")
                if st.startswith("SERVED-COMPILE-FAIL"):
                    break
            if a.dry_run:
                break


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
