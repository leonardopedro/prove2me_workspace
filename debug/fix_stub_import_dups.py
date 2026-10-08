#!/usr/bin/env python3
"""Drop def-bundle imports of thm stubs whose declaration a def bundle owns.

A thm stub `Thm_BookProof_X_y` that does `import Definitions.Def_D` while
`Def_D` itself declares `BookProof.X.y` can never compile -- the mirror
answers `... has already been declared` (and so would the server, so the
thm node can never publish either).  Every def bundle importing that stub is
then blocked: build133 had 80 failed stubs, 77 of them imported by 1-6 def
bundles each, feeding the 68-row `object file not found` cascade.

Repair, per importing def bundle B:
  * if B already imports Def_D          -> drop `import Theorems.Thm_<X>`;
  * else if Def_D does not transitively import B
                                         -> replace the line with
                                            `import Definitions.Def_D`;
  * else (cycle)                         -> report, leave untouched.

The name still resolves: B's `open`s are untouched, and Def_D declares the
same fully-qualified name the stub did (same source lemma).

Usage:
  python3 debug/fix_stub_import_dups.py --dry-run   (default: dry run)
  python3 debug/fix_stub_import_dups.py --apply
  python3 debug/fix_stub_import_dups.py --apply --verify   (recompile changed)
"""
import argparse
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.environ.get("PROVE2ME_WS") or os.path.dirname(HERE)
sys.path.insert(0, HERE)
from restore_opens import scan  # noqa: E402

DEFS = os.path.join(WS, "Definitions")
THMS = os.path.join(WS, "Theorems")
MIRROR = os.environ.get("CANDIDATE_MIRROR", "/tmp/def_candidate")
PATH_BIN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin"

THM_NAME = re.compile(r"^theorem\s+([A-Za-z_][\w.'!?]*)", re.M)
IMPORT_THM = re.compile(r"^import\s+Theorems\.(Thm_\S+)", re.M)
IMPORT_ANY = re.compile(r"^import\s+(Definitions\.Def_\S+)", re.M)


def def_decls():
    """(namespace, base) -> Def bundle name, from WS text and mirror text."""
    decls = {}
    for bundle, keys in decl_sets().items():
        for key in keys:
            decls.setdefault(key, bundle)
    return decls


def decl_sets():
    """bundle -> set of (namespace, base) it declares (mirror text first,
    falling back to WS -- the mirror reflects what the platform compiles)."""
    out = {}
    for root in (os.path.join(MIRROR, "Definitions"), DEFS):
        if not os.path.isdir(root):
            continue
        for fn in sorted(os.listdir(root)):
            if not (fn.startswith("Def_") and fn.endswith(".lean")):
                continue
            bundle = fn[4:-5]
            if bundle in out:
                continue
            try:
                _, d = scan(open(os.path.join(root, fn),
                                 encoding="utf-8", errors="ignore").read().split("\n"))
            except Exception:
                continue
            out[bundle] = set(d)
    return out


def def_graph():
    """bundle -> set of Def bundles it imports (WS text)."""
    g = {}
    for fn in os.listdir(DEFS):
        if fn.startswith("Def_") and fn.endswith(".lean"):
            txt = open(os.path.join(DEFS, fn), encoding="utf-8",
                       errors="ignore").read()
            g[fn[4:-5]] = {m[len("Definitions.Def_"):]
                           for m in IMPORT_ANY.findall(txt)}
    return g


def reaches(g, src, dst, seen=None):
    """Does src transitively import dst?"""
    seen = seen if seen is not None else set()
    if src == dst:
        return True
    if src in seen:
        return False
    seen.add(src)
    return any(reaches(g, d, dst, seen) for d in g.get(src, ()))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true", help="write the edits")
    ap.add_argument("--verify", action="store_true",
                    help="recompile every changed bundle in the mirror")
    a = ap.parse_args()

    dsets = decl_sets()
    graph = def_graph()

    # failed stubs: mirror knows they do not build
    failed = set()
    tdir = os.path.join(MIRROR, "Theorems")
    if os.path.isdir(tdir):
        for f in os.listdir(tdir):
            if f.endswith(".lean") and not os.path.exists(
                    os.path.join(tdir, f[:-5] + ".olean")):
                failed.add(f[:-5])

    plan = []   # (bundle, stub, action, detail)
    for fn in sorted(os.listdir(DEFS)):
        if not (fn.startswith("Def_") and fn.endswith(".lean")):
            continue
        bundle = fn[4:-5]
        path = os.path.join(DEFS, fn)
        txt = open(path, encoding="utf-8", errors="ignore").read()
        for stub in IMPORT_THM.findall(txt):
            if stub not in failed:
                continue
            stxt = open(os.path.join(THMS, stub + ".lean"), encoding="utf-8",
                        errors="ignore").read()
            m = THM_NAME.search(stxt)
            if not m:
                continue
            ns, _, base = m.group(1).rpartition(".")
            key = (ns, base)
            stub_imports = {im[len("Definitions.Def_"):]
                            for im in IMPORT_ANY.findall(stxt)}
            # bundles the STUB imports that actually declare the name --
            # these are why the stub collides
            stub_prov = {d for d in stub_imports if key in dsets.get(d, ())}
            if not stub_prov:
                # the stub compiles-or-fails for some other reason
                continue
            # bundles B already imports that declare the name: after the
            # stub import is dropped, B keeps resolving it from there
            providers_b = {d for d in graph.get(bundle, ())
                           if key in dsets.get(d, ())}
            if key in dsets.get(bundle, ()) or providers_b:
                where = (bundle if key in dsets.get(bundle, ())
                         else min(providers_b))
                plan.append((bundle, stub, "drop",
                             f"already provided by Def_{where}"))
            else:
                free = [c for c in sorted(stub_prov)
                        if c != bundle and not reaches(graph, c, bundle)]
                if free:
                    plan.append((bundle, stub, "replace",
                                 f"add import Definitions.Def_{free[0]}"))
                else:
                    plan.append((bundle, stub, "skip",
                                 f"cycle via Def_{min(stub_prov)}"))

    drops = repl = skips = 0
    for bundle, stub, action, detail in plan:
        tag = {"drop": "DROP ", "replace": "REPL ", "skip": "SKIP "}[action]
        print(f"{tag}Def_{bundle}: {stub}  ({detail})")
        drops += action == "drop"
        repl += action == "replace"
        skips += action == "skip"
    print(f"\n{drops} drop, {repl} replace, {skips} skip "
          f"({len(plan)} blocked imports over "
          f"{len({p[0] for p in plan})} bundles)")
    if not a.apply or not plan:
        return 0

    # apply per bundle
    changed = []
    by_bundle = {}
    for bundle, stub, action, detail in plan:
        if action != "skip":
            by_bundle.setdefault(bundle, []).append((stub, action, detail))
    for bundle, edits in sorted(by_bundle.items()):
        path = os.path.join(DEFS, f"Def_{bundle}.lean")
        lines = open(path, encoding="utf-8").read().split("\n")
        owner_add = None
        out = []
        for ln in lines:
            m = re.match(r"^import\s+Theorems\.(Thm_\S+)\s*$", ln)
            if m and any(m.group(1) == s for s, act, _ in edits
                         if act in ("drop", "replace")):
                act = next(act for s, act, _ in edits if s == m.group(1))
                if act == "replace":
                    detail = next(d for s, act2, d in edits
                                  if s == m.group(1) and act2 == "replace")
                    owner = detail.replace("add import Definitions.Def_", "")
                    owner_add = owner
                continue  # drop the line (replace adds Def import below)
            out.append(ln)
        if owner_add:
            # insert with the other import Definitions lines
            last = max(i for i, l in enumerate(out)
                       if l.startswith("import Definitions.")) \
                if any(l.startswith("import Definitions.") for l in out) else None
            ins = f"import Definitions.Def_{owner_add}"
            if ins in out:
                pass
            elif last is not None:
                out.insert(last + 1, ins)
            else:
                out.insert(1, ins)
        open(path, "w", encoding="utf-8").write("\n".join(out))
        changed.append(bundle)
        print(f"edited Def_{bundle}.lean ({len(edits)} import(s))")

    with open("/tmp/stub_dup_changed.txt", "w") as fh:
        fh.write("\n".join(changed) + "\n")
    print(f"{len(changed)} bundle(s) written -> /tmp/stub_dup_changed.txt")

    if a.verify:
        base = subprocess.run(["lake", "env", "bash", "-c",
                               'printf %s "$LEAN_PATH"'],
                              cwd=os.path.join(WS, "..", "timepiece331"),
                              capture_output=True, text=True).stdout.strip()
        lean = subprocess.run(["lake", "env", "bash", "-c", "command -v lean"],
                              cwd=os.path.join(WS, "..", "timepiece331"),
                              capture_output=True, text=True).stdout.strip()
        env = dict(os.environ, PATH=PATH_BIN + ":" + os.environ["PATH"])
        # refresh mirror copies of the edited bundles first
        for b in changed:
            src = os.path.join(DEFS, f"Def_{b}.lean")
            open(os.path.join(MIRROR, "Definitions", f"Def_{b}.lean"),
                 "w").write(open(src).read())
        ok = fail = 0
        for b in changed:
            r = subprocess.run(
                [lean, "-DautoImplicit=false", "-o", f"Definitions/Def_{b}.olean",
                 f"Definitions/Def_{b}.lean"],
                cwd=MIRROR, env=dict(env, LEAN_PATH=f"{MIRROR}:{base}"),
                capture_output=True, text=True, timeout=1800)
            if r.returncode == 0:
                ok += 1
                print(f"OK   Def_{b}")
            else:
                fail += 1
                out = r.stdout + r.stderr
                first = next((l for l in out.splitlines() if "error" in l), "")
                print(f"FAIL Def_{b}: {first[:200]}")
                os.makedirs("/tmp/root_errors", exist_ok=True)
                open(f"/tmp/root_errors/Def_{b}.recheck.log", "w").write(out)
        print(f"verify: {ok} OK, {fail} FAIL")
    return 0


if __name__ == "__main__":
    sys.exit(main())
