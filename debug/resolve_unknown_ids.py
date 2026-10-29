#!/usr/bin/env python3
"""Drive a sol to `local compile OK` by resolving `Unknown identifier X` errors.

For each iteration we compile the sol against the published mirror and take the
unknown identifiers Lean reports, then resolve each one:

  1. IMPORT  — `X` is declared in the published text of a Thm node whose ledger
     status is `done` and the sol does not import it yet  -> add the import.
     (A published node is Proved on the platform, so the sol gains a real
     theorem, never a `sorry`.)
  2. INLINE  — no published Thm carries it, but a workspace `Definitions/Def_*`
     declares it (§2.67: the published Def bundle dropped the decl) -> copy the
     declaration into the sol as `private` via inline_missing_id.apply().
  3. STALL   — neither; report and stop working that sol.

Ambiguity errors are NOT handled here (see debug/fix_ambig.py).

Usage: python3 debug/resolve_unknown_ids.py [--file list] [--max 10]
"""
import argparse
import json
import os
import re
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import check_sol_local as c           # noqa: E402
import inline_missing_id as im        # noqa: E402
import resolve_miss_ident as rmi      # noqa: E402

RE_MISS = re.compile(r"Unknown (?:identifier|constant) [`']([^`']+)[`']")
RE_ERR = re.compile(r"S\.lean:\d+:\d+: error")


def published_thm_modules():
    """Thm module -> True if its mirror text declares something, keyed later."""
    out = {}
    root = os.path.join(c.MIRROR, "Theorems")
    for fn in os.listdir(root) if os.path.isdir(root) else []:
        if fn.endswith(".lean"):
            out[fn[:-5]] = os.path.join(root, fn)
    return out


def ledger_status():
    st = json.load(open(os.path.join(WS, "state/pipeline.json")))["items"]
    return st


def resolve(slug, ident, idx, thms, st, verbose=True):
    """-> 'imported' | 'inlined' | 'stall:<reason>' (modifies the file)."""
    path = os.path.join(WS, "Solutions", f"Sol_{slug}.lean")
    src = open(path, encoding="utf-8").read()
    imps = {m.group(1) for m in re.finditer(r"^import\s+(\S+)", src, re.M)}
    bare = ident.split(".")[-1]

    # 1) published Thm node carrying the name, ledger-done, not yet imported
    cands = []
    for key, mpath in thms.items():
        txt = open(mpath, encoding="utf-8", errors="ignore").read()
        if re.search(rf"(?:def|lemma|theorem)\s+[^ \n]*\.{re.escape(bare)}\b"
                     rf"|(?:def|lemma|theorem)\s+{re.escape(bare)}\b", txt):
            cands.append(f"Theorems.{key}")
    for mod in sorted(cands):
        lkey = "thm:" + (mod.split(".", 1)[1][4:])
        if st.get(lkey, {}).get("status") != "done":
            continue
        if mod in imps:
            continue
        lines = src.splitlines(keepends=True)
        last = max(i for i, l in enumerate(lines) if l.startswith("import "))
        lines.insert(last + 1, f"import {mod}\n")
        open(path, "w", encoding="utf-8").write("".join(lines))
        if verbose:
            print(f"    import {mod}", flush=True)
        return "imported"

    # 2) workspace Def/Thm source declaring it (prefer Definitions, real proof)
    cands2 = []
    for k in idx:
        if k == ident or k.endswith("." + ident) or k.split(".")[-1] == bare:
            cands2 += sorted(idx[k])
    cands2.sort(key=lambda km: (km[0] != "def", km[1]))     # Def first
    for kind, mod in cands2:
        dp = os.path.join(WS, mod.replace(".", "/") + ".lean")
        if not os.path.exists(dp):
            continue
        err = im.apply(slug, bare, dp)
        if err is None:
            if verbose:
                print(f"    inline {bare} ({mod})", flush=True)
            return "inlined"
        last_err = err
    return "stall:" + (last_err if cands2 else "no declaring module")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--file")
    ap.add_argument("--max", type=int, default=8)
    a = ap.parse_args()
    slugs = ([l.strip() for l in open(a.file) if l.strip()] if a.file
             else sys.argv[1:])
    idx = rmi.build_index()
    thms = published_thm_modules()
    st = ledger_status()
    lean = c._lake_env("command -v lean")
    env = dict(os.environ, LEAN_PATH=f"{c.MIRROR}:{c._lake_env('printf %s \"$LEAN_PATH\"')}")

    ok, stall = [], []
    for slug in slugs:
        path = os.path.join(WS, "Solutions", f"Sol_{slug}.lean")
        for it in range(a.max):
            with tempfile.TemporaryDirectory() as d:
                out = os.path.join(d, "S.lean")
                c.shutil_copy(path, out)
                r = subprocess.run([lean, out], env=env,
                                   capture_output=True, text=True)
            if r.returncode == 0:
                ok.append(slug)
                print(f"OK   {slug}", flush=True)
                break
            ids = list(dict.fromkeys(RE_MISS.findall(r.stdout)))
            if not ids:
                first = next((l for l in r.stdout.splitlines() if "error" in l), "?")
                stall.append((slug, first.strip()[:150]))
                print(f"FAIL {slug}: {first.strip()[:150]}", flush=True)
                break
            progressed = False
            for ident in ids:
                res = resolve(slug, ident, idx, thms, st)
                if res in ("imported", "inlined"):
                    progressed = True
                else:
                    stall.append((slug, f"{ident}: {res}"))
                    print(f"STALL {slug} {ident}: {res}", flush=True)
            if not progressed:
                break
        else:
            stall.append((slug, "max iterations"))
    print(f"\nlocal compile: {len(ok)}/{len(slugs)} OK against {c.MIRROR}")
    if stall:
        print("remaining:")
        for s, why in stall:
            print(f"  {s}: {why}")
    return 0 if not stall else 1


if __name__ == "__main__":
    sys.exit(main())
