#!/usr/bin/env python3
"""Give a Definitions/Theorems module an olean in `state/mirror` by rebuilding the
chain it actually needs — from the **workspace** text, never from a stub.

Why this exists
---------------
The platform mirror holds each published bundle's *served* text.  For a large
class of modules that text is a truncated stub (`Def_ChapterFockWeightedSchurEsa`
is 9 lines there and 867 in the workspace), so a module that cites it fails with
`Unknown identifier X` even though the workspace draft declares `X`.  The old
workaround was a prebuilt `.olean` from some earlier text, which is exactly how
a stale olean "proves" a file nobody can rebuild.

This tool walks the real dependency graph instead: compile the workspace text,
and when Lean reports `Unknown identifier X`, find the workspace module that
actually declares `X`, build *that* first, and retry.  Two safety rules:

* a `Theorems/Thm_*.lean` wrapper that ends the statement in `by sorry` is not a
  provider.  Using one would produce an olean that compiles and proves nothing,
  so the walk refuses it and reports the gap instead;
* only `Unknown identifier` / `Unknown constant` is resolved automatically.
  `unsolved goals`, `type mismatch`, `simp` failures are real breakage in the
  workspace text and stop the walk with the module named.

Usage
-----
    python3 debug/build_mirror_chain.py Def_ChapterSmComparison
    python3 debug/build_mirror_chain.py Def_ChapterSmComparison --depth 1

`--depth` bounds how many provider levels are pulled in (default: unbounded).
Exit 0 only when the requested module has an olean in the mirror.
"""
import argparse
import os
import re
import shutil
import subprocess
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MIR = f"{WS}/state/mirror"
LEAN_ROOT = os.environ.get("PROVE2ME_LEAN_ROOT",
                           os.path.join(os.path.dirname(WS), "timepiece331"))

DECL = re.compile(r"^\s*(?:@\[[^\]]*\]\s*)*(?:protected\s+|private\s+|nonrec\s+)*"
                  r"(?:def|abbrev|theorem|lemma|instance|structure|class|inductive|opaque)"
                  r"\s+([^\s({:「]+)", re.M)
IDENT = re.compile(r"Unknown (?:identifier|constant) [`\"]([^`\"]+)[`\"]")
NOOLEAN = re.compile(r"object file '[^']*' of module (\S+) does not exist")


def lean_path():
    """The Mathlib search path, from the sibling toolchain project."""
    out = subprocess.run(["lake", "env", "bash", "-c", "printf %s \"$LEAN_PATH\""],
                         cwd=LEAN_ROOT, capture_output=True, text=True, check=True)
    return out.stdout


def rel_module(mod):
    return mod.replace(".", "/")


def ws_file(mod):
    return f"{WS}/{rel_module(mod)}.lean"


def declare_index():
    """leaf -> [module, ...] over every workspace module that names it as a decl."""
    idx = {}
    for root in ("Definitions", "Theorems", "BookProof"):
        d = f"{WS}/{root}"
        if not os.path.isdir(d):
            continue
        for fn in sorted(os.listdir(d)):
            if not fn.endswith(".lean"):
                continue
            mod = f"{root}.{fn[:-5]}"
            try:
                txt = open(f"{WS}/{rel_module(mod)}.lean", encoding="utf-8").read()
            except OSError:
                continue
            for name in DECL.findall(txt):
                leaf = name.rsplit(".", 1)[-1]
                idx.setdefault(leaf, []).append(mod)
    return idx


def is_sorry_shim(mod):
    """A generated wrapper whose only proof is `by sorry`."""
    p = ws_file(mod)
    try:
        txt = open(p, encoding="utf-8").read()
    except OSError:
        return False
    return "by sorry" in txt or ":= sorry" in txt


def compile_module(mod, path, log):
    src = ws_file(mod)
    if not os.path.exists(src):
        return [f"missing workspace text: {src}"], False
    dst = f"{MIR}/{rel_module(mod)}.lean"
    os.makedirs(os.path.dirname(dst), exist_ok=True)
    shutil.copyfile(src, dst)
    olean = f"{MIR}/{rel_module(mod)}.olean"
    if os.path.exists(olean):
        os.remove(olean)
    env = dict(os.environ, LEAN_PATH=f"{MIR}:{path}", PATH=os.environ["PATH"])
    r = subprocess.run(["lean", "-DautoImplicit=false", "-o", olean,
                        os.path.relpath(dst, MIR)],
                       cwd=MIR, env=env, capture_output=True, text=True, timeout=1800)
    errs = [ln for ln in (r.stderr + "\n" + r.stdout).splitlines() if "error" in ln]
    return errs, os.path.exists(olean)


def build(mod, path, index, done, depth, max_depth, log, stack):
    if mod in done:
        return done[mod]
    if mod in stack:
        log(f"  cycle at {mod}")
        return False
    if max_depth is not None and depth > max_depth:
        log(f"  depth limit at {mod}")
        return False
    src = ws_file(mod)
    errs, ok = compile_module(mod, path, log)
    if ok:
        log(f"  OK   {mod}")
        done[mod] = True
        return True
    # An import whose olean is absent is not a proof problem: build the module.
    need = []
    for e in errs:
        for m in NOOLEAN.findall(e):
            if m.endswith(".olean"):
                m = m[: -len(".olean")]
            if m not in need and os.path.exists(ws_file(m)):
                need.append(m)
    if need and not any(IDENT.search(e) for e in errs):
        log(f"  deps {mod}: {', '.join(need)}")
        okall = True
        for m in need:
            if not build(m, path, index, done, depth + 1, max_depth, log, stack):
                okall = False
        if okall:
            errs, ok = compile_module(mod, path, log)
            log(f"  {'OK  ' if ok else 'FAIL'} {mod} (after imports)")
            if not ok:
                for e in errs[:4]:
                    log(f"       {e}")
            done[mod] = ok
            return ok
        done[mod] = False
        return False

    missing = []
    for e in errs:
        for name in IDENT.findall(e):
            if name not in missing:
                missing.append(name)
    if not missing:
        log(f"  FAIL {mod} (not a provider gap)")
        for e in errs[:4]:
            log(f"       {e}")
        done[mod] = False
        return False
    log(f"  gap  {mod}: {len(missing)} unknown name(s)")
    stack.append(mod)
    okall = True
    for name in missing:
        cands = [m for m in index.get(name, []) if os.path.exists(ws_file(m))]
        if not cands:
            log(f"       {name}: DECLARED NOWHERE in the workspace")
            okall = False
            continue
        real = [m for m in cands if not is_sorry_shim(m)]
        pick = (real or cands)[0]
        if not real:
            log(f"       {name}: sorry-only shim {pick} -- refusing")
            okall = False
            continue
        log(f"       {name} <- {pick}")
        if not build(pick, path, index, done, depth + 1, max_depth, log, stack):
            okall = False
    stack.pop()
    if not okall:
        done[mod] = False
        return False
    errs, ok = compile_module(mod, path, log)
    if ok:
        log(f"  OK   {mod} (after providers)")
    else:
        log(f"  FAIL {mod} after providers")
        for e in errs[:4]:
            log(f"       {e}")
    done[mod] = ok
    return ok


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("module", help="e.g. Def_ChapterSmComparison or Definitions.Def_ChapterSmComparison")
    ap.add_argument("--depth", type=int, default=None)
    args = ap.parse_args()
    mod = args.module.replace(".", "/").split("/")[-1]
    if mod.startswith("Def_") or mod.startswith("Thm_"):
        prefix = "Definitions" if mod.startswith("Def_") else "Theorems"
        mod = f"{prefix}.{mod}"

    def log(msg):
        print(msg, flush=True)

    path = lean_path()
    index = declare_index()
    ok = build(mod, path, index, {}, 0, args.depth, log, [])
    log(f"{mod}: {'has an olean in the mirror' if ok else 'NO olean'}")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
