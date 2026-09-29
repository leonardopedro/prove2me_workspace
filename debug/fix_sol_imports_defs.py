#!/usr/bin/env python3
"""Definitions-first repair for solution imports.

Why this exists: `debug/sol_deps.py` resolves a missing reference to whichever
module declares it with the **longest dotted prefix**.  The generated Theorems
stubs declare the fully dotted name (`theorem BookProof.X.foo`), while the
Definitions bundles declare it bare inside a `namespace X` block, so the stub
always wins the prefix comparison and the tooling would import
`Theorems.Thm_<...>` — a node that may not even exist yet — instead of the
Definitions bundle that *contains the proof*.  That difference is the whole
difference between
  * `import Definitions.Def_<chapter>` -> the helper arrives with its proof, and
    the submitted solution verifies as ACCEPTED, and
  * `import Theorems.Thm_<slug>` -> the helper is a `sorry` placeholder, and the
    server answers SKETCH_ACCEPTED, i.e. a *reduction*: the target stays Open
    until the child is proved.

This resolves every missing name against the published Definitions bundles
first, and only falls back to a Theorems node that is already `Proved`.

Usage:
  python3 debug/fix_sol_imports_defs.py --chapter GaussCoreQuadBounds --dry-run
  python3 debug/fix_sol_imports_defs.py --chapter GaussCoreQuadBounds SqSumFarisLavine
  python3 debug/fix_sol_imports_defs.py --all
  python3 debug/fix_sol_imports_defs.py Solutions/Sol_BookProof_X_y.lean

`--allow-open` additionally accepts a published-but-still-`Open` child node.  The
import is then legitimate, but the server answers SKETCH_ACCEPTED, i.e. the target
becomes a *reduction* and stays Open until that child is proved — so it is off by
default and only worth using deliberately.
"""
import glob
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(WS, "pipeline"))
sys.path.insert(0, HERE)

import sol_deps as SD          # noqa: E402
import upload_pipeline as U    # noqa: E402

DECL = re.compile(
    r"(?m)^\s*(?:noncomputable\s+|private\s+|protected\s+|@\[[^\]]*\]\s*)*"
    r"(?:def|abbrev|theorem|lemma|structure|inductive|class|instance)\s+"
    r"([A-Za-z_][A-Za-z0-9_'.]*)")
NS = re.compile(r"\s*namespace\s+([\w.]+)")
END = re.compile(r"\s*end\s+([\w.]+)\s*$")
IMPORT = re.compile(r"(?m)^import\s+\S+")


def def_index():
    """short name -> (Definitions module, namespace) for every def bundle."""
    idx = {}
    d = os.path.join(WS, "Definitions")
    for fn in sorted(os.listdir(d)):
        if not fn.endswith(".lean"):
            continue
        mod = "Definitions." + fn[:-len(".lean")]
        txt = SD.strip_comments(open(os.path.join(d, fn), encoding="utf-8",
                                    errors="replace").read())
        ns = None
        for line in txt.split("\n"):
            m = NS.match(line)
            if m:
                ns = m.group(1)
                continue
            m = END.match(line)
            if m and ns and (m.group(1) == ns or ns.endswith("." + m.group(1))):
                ns = None
                continue
            for raw in DECL.findall(line):
                short = raw.split(".")[-1]
                pre = raw.rsplit(".", 1)[0] if "." in raw else (ns or "")
                if short not in idx:
                    idx[short] = (mod, pre)
    return idx


def published_defs(state):
    return {k[4:] for k, v in state["items"].items()
            if k.startswith("def:") and v.get("status") == "done"}


def proved_theorems(state):
    """slug -> theorem_id for theorems the platform reports as Proved, read from
    state (sync/verdicts write `reused_status`)."""
    out = {}
    for k, v in state["items"].items():
        if k.startswith("thm:") and v.get("theorem_id") and (
                v.get("reused_status") == "Proved"):
            out[k[4:]] = v["theorem_id"]
    return out


def index_theorems():
    """short name -> (Theorems module, slug) for every generated stub."""
    out = {}
    d = os.path.join(WS, "Theorems")
    for fn in sorted(os.listdir(d)):
        if not fn.startswith("Thm_") or not fn.endswith(".lean"):
            continue
        slug = fn[len("Thm_"):-len(".lean")]
        txt = SD.strip_comments(open(os.path.join(d, fn), encoding="utf-8",
                                     errors="replace").read())
        for raw in DECL.findall(txt):
            out.setdefault(raw.split(".")[-1], (f"Theorems.{fn[:-len('.lean')]}", slug))
    return out


def apply(path, mods, dry=False):
    text = open(path, encoding="utf-8").read()
    have = set(SD.IMPORT.findall(text))
    new = [m for m in sorted(mods) if m not in have]
    if not new:
        return []
    lines = text.split("\n")
    last = max(i for i, ln in enumerate(lines) if ln.startswith("import "))
    lines[last + 1:last + 1] = [f"import {m}" for m in new]
    if not dry:
        open(path, "w", encoding="utf-8").write("\n".join(lines))
    return new


def main():
    argv = sys.argv[1:]
    dry = "--dry-run" in argv
    allow_open = "--allow-open" in argv
    argv = [a for a in argv if a not in ("--dry-run", "--allow-open")]
    if "--all" in argv:
        files = sorted(glob.glob(os.path.join(WS, "Solutions", "Sol_BookProof_*.lean")))
    elif "--chapter" in argv:
        i = argv.index("--chapter")
        files = []
        for ch in argv[i + 1:]:
            files += sorted(glob.glob(os.path.join(WS, "Solutions", f"Sol_{ch}*.lean")))
            files += sorted(glob.glob(os.path.join(WS, "Solutions", f"Sol_BookProof_{ch}_*.lean")))
        files = sorted(set(files))
    else:
        files = [a if os.path.isabs(a) else os.path.join(WS, a) for a in argv]
    if not files:
        print(__doc__)
        return 2

    st = U.load_state()
    pub = published_defs(st)
    DI = def_index()
    TI = index_theorems()
    decls, imports_of = SD.index()

    _status = {}

    def node_status(slug):
        """Live platform status of a stub's node (Proved / Open / None)."""
        if slug in _status:
            return _status[slug]
        tid = (st["items"].get("thm:" + slug) or {}).get("theorem_id")
        s = U.theorem_status(tid) if tid else None
        _status[slug] = s
        return s

    patched = blocked = 0
    by_block = {}
    for path in files:
        missing = SD.analyse(path, decls, imports_of)
        if not missing:
            continue
        names = sorted({n for ns in missing.values() for n in ns})
        ready, wait = set(), []
        for n in names:
            mod, ns = DI.get(n, (None, None))
            if mod and mod.replace("Definitions.Def_", "") in pub:
                ready.add(mod)
                continue
            tmod, slug = TI.get(n, (None, None))
            if tmod:
                s = node_status(slug)
                if s == "Proved" or (allow_open and s == "Open"):
                    ready.add(tmod)
                    continue
                wait.append((n, mod, tmod, s or "absent"))
                continue
            wait.append((n, mod, tmod, "no node"))
        added = apply(path, ready, dry=dry)
        tag = os.path.basename(path)
        if added:
            patched += 1
            print(f"{tag}\n    + " + "\n    + ".join(f"import {m}" for m in added))
        for n, dmod, tmod, status in wait:
            blocked += 1
            if dmod and dmod.replace("Definitions.Def_", "") not in pub:
                kind = f"def bundle {dmod} not published"
            elif tmod:
                kind = f"node {tmod} is {status} (need Proved)"
            else:
                kind = "no declaring module"
            by_block[kind] = by_block.get(kind, 0) + 1
            print(f"{tag}\n    BLOCKED {n}: {kind}")
    print(f"\n{len(files)} file(s): {patched} patched, {blocked} blocked reference(s)"
          + (" [dry run]" if dry else ""))
    for k, v in sorted(by_block.items(), key=lambda kv: -kv[1])[:8]:
        print(f"  {v:4d}x {k}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
