#!/usr/bin/env python3
"""Add the thm-stub import a root-failure bundle is missing.

Root failures report `Unknown identifier/constant FQ`.  When a thm stub
declares exactly FQ, the bundle simply never imported it (`opens_ns` is
usually already true, so the bare name resolves the moment the import is
there).  Adding the import:

* mirror: the stub stages and compiles in the next topo build, the bundle
  unblocks;
* platform: `do_wave_def`'s thm_deps gate defers the def (FREE) until the
  stub is PUBLISHED, and passes the moment it is -- strictly better than a
  content FAIL.

Skipped: stubs that can never publish (their own def import already
declares FQ -- the dup class from fix_stub_import_dups), and bundles that
already import the stub.

Usage:
  python3 debug/add_missing_stub_imports.py [--apply] [--verify]
"""
import argparse
import os
import re
import subprocess
import sys
import collections

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.environ.get("PROVE2ME_WS") or os.path.dirname(HERE)
sys.path.insert(0, HERE)
from fix_stub_import_dups import decl_sets  # noqa: E402
from restore_opens import scan  # noqa: E402

MIRROR = os.environ.get("CANDIDATE_MIRROR", "/tmp/def_candidate")
PATH_BIN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin"
ERR = re.compile(r"Unknown (?:identifier|constant) `([^`]+)`")
THM_NAME = re.compile(r"^theorem\s+([A-Za-z_][\w.'!?]*)", re.M)


def stub_index():
    """full theorem name -> stub module name."""
    idx = {}
    for f in os.listdir(f"{WS}/Theorems"):
        if not (f.startswith("Thm_") and f.endswith(".lean")):
            continue
        txt = open(f"{WS}/Theorems/{f}", encoding="utf-8",
                   errors="ignore").read()
        m = THM_NAME.search(txt)
        if m:
            idx[m.group(1)] = f[:-5]
    return idx


def idx_full(stub, idx):
    """full theorem name of a stub module."""
    return next((full for full, s in idx.items() if s == stub), "")


def unpublishable(stub, fq, dsets):
    """True when the stub imports a def bundle that already declares FQ --
    such a stub can never publish, so importing it only defers forever."""
    txt = open(f"{WS}/Theorems/{stub}.lean", encoding="utf-8",
               errors="ignore").read()
    ns, _, base = fq.rpartition(".")
    key = (ns, base)
    for im in re.findall(r"^import\s+Definitions\.Def_(\S+)", txt, re.M):
        if key in dsets.get(im, ()):
            return True
    return False


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true")
    ap.add_argument("--verify", action="store_true")
    a = ap.parse_args()

    # collect (bundle, fq) from root error logs
    uses = collections.OrderedDict()
    for lf in sorted(os.listdir("/tmp/root_errors")):
        if not (lf.startswith("Def_") and lf.endswith(".log")):
            continue
        bundle = lf[4:-4]
        if bundle.endswith(".recheck") or bundle.endswith(".add"):
            continue
        for ln in open(f"/tmp/root_errors/{lf}", errors="ignore"):
            m = ERR.search(ln)
            if m:
                uses[(bundle, m.group(1))] = True

    idx = stub_index()
    dsets = decl_sets()
    OPEN = re.compile(r"^open\s+([^\n(]+)", re.M)

    def bundle_opens(txt):
        toks = set()
        for line in OPEN.findall(txt):
            toks.update(line.split())
        return toks

    edits = collections.defaultdict(list)   # bundle -> [stub]
    for bundle, fq in uses:
        path = f"{WS}/Definitions/Def_{bundle}.lean"
        txt = open(path, encoding="utf-8").read()
        opens = bundle_opens(txt)
        if "." in fq:
            cands = [idx[fq]] if fq in idx else []
        else:
            # bare identifier: every stub whose full name ends in `.fq`;
            # prefer the namespace the bundle already opens (bare usage
            # resolves exactly there)
            suff = [s for full, s in idx.items() if full.endswith("." + fq)]
            opened = [s for s in suff
                      if idx_full(s, idx).rpartition(".")[0] in opens]
            cands = opened if len(opened) == 1 else (
                suff if len(suff) == 1 else [])
            if len(suff) > 1 and not cands:
                print(f"AMBIG   {bundle} :: {fq} -> {sorted(suff)}")
                continue
        if not cands:
            print(f"NO-STUB {bundle} :: {fq}")
            continue
        stub = cands[0]
        if f"import Theorems.{stub}" in txt:
            print(f"HAS     {bundle} :: {fq}")
            continue
        if unpublishable(stub, fq if "." in fq else
                         idx_full(stub, idx), dsets):
            print(f"SKIP-DUP {bundle} :: {fq} via {stub} (never publishable)")
            continue
        edits[bundle].append((stub, fq))
        print(f"ADD     {bundle} :: {fq}  <- Theorems.{stub}")

    print(f"\n{sum(len(v) for v in edits.values())} import(s) over "
          f"{len(edits)} bundle(s)")
    if not a.apply or not edits:
        return 0

    for bundle, items in sorted(edits.items()):
        path = f"{WS}/Definitions/Def_{bundle}.lean"
        lines = open(path, encoding="utf-8").read().split("\n")
        existing = [i for i, l in enumerate(lines) if l.startswith("import ")]
        if not existing:
            print(f"NO IMPORT BLOCK in Def_{bundle}.lean -- skipped")
            continue
        ins = [f"import Theorems.{s}" for s, _ in items]
        at = max(existing) + 1
        lines[at:at] = ins
        open(path, "w", encoding="utf-8").write("\n".join(lines))
        print(f"edited Def_{bundle}.lean (+{len(ins)})")

    with open("/tmp/stub_import_added.txt", "w") as fh:
        fh.write("\n".join(sorted(edits)) + "\n")

    if a.verify:
        base = subprocess.run(["lake", "env", "bash", "-c",
                               'printf %s "$LEAN_PATH"'],
                              cwd=f"{WS}/../timepiece331",
                              capture_output=True, text=True).stdout.strip()
        lean = subprocess.run(["lake", "env", "bash", "-c", "command -v lean"],
                              cwd=f"{WS}/../timepiece331",
                              capture_output=True, text=True).stdout.strip()
        env = dict(os.environ, PATH=PATH_BIN + ":" + os.environ["PATH"])
        # stage the new stubs + edited bundles into the mirror
        for bundle, items in sorted(edits.items()):
            for stub, _ in items:
                open(f"{MIRROR}/Theorems/{stub}.lean", "w").write(
                    open(f"{WS}/Theorems/{stub}.lean").read())
            open(f"{MIRROR}/Definitions/Def_{bundle}.lean", "w").write(
                open(f"{WS}/Definitions/Def_{bundle}.lean").read())
        # compile new stubs first (their deps are already built), then bundles
        ok = fail = 0
        for bundle, items in sorted(edits.items()):
            for stub, _ in items:
                r = subprocess.run(
                    [lean, "-DautoImplicit=false", "-o",
                     f"Theorems/{stub}.olean", f"Theorems/{stub}.lean"],
                    cwd=MIRROR, env=dict(env, LEAN_PATH=f"{MIRROR}:{base}"),
                    capture_output=True, text=True, timeout=1800)
                if r.returncode == 0:
                    ok += 1
                else:
                    fail += 1
                    out = r.stdout + r.stderr
                    first = next((l for l in out.splitlines()
                                  if "error" in l), "")
                    print(f"STUB-FAIL {stub}: {first[:180]}")
                    open(f"/tmp/root_errors/{stub}.log", "w").write(out)
        for bundle in sorted(edits):
            r = subprocess.run(
                [lean, "-DautoImplicit=false", "-o",
                 f"Definitions/Def_{bundle}.olean",
                 f"Definitions/Def_{bundle}.lean"],
                cwd=MIRROR, env=dict(env, LEAN_PATH=f"{MIRROR}:{base}"),
                capture_output=True, text=True, timeout=1800)
            if r.returncode == 0:
                ok += 1
                print(f"OK   Def_{bundle}")
            else:
                fail += 1
                out = r.stdout + r.stderr
                first = next((l for l in out.splitlines() if "error" in l), "")
                print(f"FAIL Def_{bundle}: {first[:200]}")
                open(f"/tmp/root_errors/Def_{bundle}.add.log", "w").write(out)
        print(f"verify: {ok} OK, {fail} FAIL")
    return 0


if __name__ == "__main__":
    sys.exit(main())
