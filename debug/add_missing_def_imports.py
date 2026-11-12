"""Add the `Definitions.Def_X` import + namespace `open` a thm stub is missing.

Reached from the same place as add_missing_theorem_imports.py: the compiler's
first `Unknown identifier \\`name\\`` for a stub whose statement references a
helper that lives in a published def bundle the stub does not import.  `lc1` is
declared in `Def_ChapterModeQuadraticEsa`, but a Carleman stub imports only the
Carleman bundle, so the name never resolves.

Narrow by construction (§5d): compile FIRST, take the identifiers the compiler
itself reported, and only add an import for an identifier that Definitions/
actually *declares* (a declaration line, not a doc comment that merely mentions
it).  An identifier with no declaration anywhere in Definitions/ is reported
UNFIXABLE -- it lives in a BookProof/ chapter source, which the platform never
uploads -- and is left untouched for the caller to park.

Imports go after the LAST import (Lean rejects an import below an `open`);
`open` lines go after the last import-or-open.

Usage:
  python3 debug/add_missing_def_imports.py <slug> [<slug> ...]
  python3 debug/add_missing_def_imports.py --from-file list.txt
  python3 debug/add_missing_def_imports.py --dry-run --from-file list.txt
"""
import concurrent.futures
import os
import re
import shutil
import subprocess
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROJ = os.environ.get("TIMEPIECE_PROJ", os.path.join(WS, "..", "timepiece331"))
MIRROR = os.environ.get("CANDIDATE_MIRROR", os.path.join(WS, "state", "mirror"))
PATH_BIN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin"

# Directory the requested module names live in: `Theorems` for a statement
# stub, `Solutions` for a sol (`--solutions`).  Sols hit the same missing-import
# class after a twin is cloned from a stub whose imports only ever served the
# statement.
SRCDIR = "Theorems"

KIND = ("def", "theorem", "lemma", "structure", "class", "abbrev", "instance")
# The binder skip must REQUIRE its `[`: an optional `\[?` backtracks into the
# identifier and captures a single trailing letter (`structure System` -> `e`),
# which silently emptied the index (130 entries instead of ~9800).
DECL = re.compile(r"^\s*(?:@\[[^\]]*\]\s*)?"
                  r"(?:protected\s+|private\s+|nonrec\s+|noncomputable\s+)*"
                  r"(?:" + "|".join(KIND) + r")\s+(?:\[[^\]]*\]\s*)?"
                  r"([A-Za-z0-9_'.]+)")
NSLINE = re.compile(r"^\s*namespace\s+([A-Za-z0-9_.']+)")
IDENT = re.compile(r"Unknown identifier [`'‘]?([A-Za-z_][\w.']*)")


def lake(cmd):
    return subprocess.run(["lake", "env", "bash", "-c", cmd], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()


def build_index():
    """short identifier -> [(def module, namespace)] for declarations only."""
    idx = {}
    d = os.path.join(WS, "Definitions")
    for fn in sorted(os.listdir(d)):
        if not fn.endswith(".lean"):
            continue
        mod = "Definitions." + fn[:-5]
        ns_stack = []
        try:
            with open(os.path.join(WS, "Definitions", fn), encoding="utf-8", errors="replace") as fh:
                for line in fh:
                    if line.lstrip().startswith(("--", "*")):
                        continue          # comment / doc line, not a declaration
                    m = NSLINE.match(line)
                    if m:
                        ns_stack.append(m.group(1))
                        continue
                    # `end Foo` pops only its own segment; a bare `end` pops one
                    m = re.match(r"^\s*end(?:\s+([A-Za-z0-9_.']+))?\s*$", line)
                    if m:
                        if ns_stack:
                            ns_stack.pop()
                        continue
                    m = DECL.match(line)
                    if not m:
                        continue
                    ns = ".".join(ns_stack)
                    full = m.group(1)
                    # `theorem BookProof.X.foo` carries its namespace inline
                    if "." in full:
                        head = full.rsplit(".", 1)[0]
                        base = full.rsplit(".", 1)[1]
                        ns_eff = head if head.startswith("BookProof") else (ns or head)
                    else:
                        base, ns_eff = full, ns
                    idx.setdefault(base, []).append((mod, ns_eff))
        except OSError:
            pass
    return idx


def compile_idents(fn):
    """([unknown identifiers], first error line or None).

    `(None, err)` = failed for a reason other than an unknown identifier
    ("already declared", a missing import, a bad field).  Returning `[], []`
    for that case made main() read it as CLEAN -- the exact misclassification
    that hid 14 real failures behind a green report.
    """
    src = os.path.join(WS, SRCDIR, fn)
    if not os.path.exists(src):
        return None, "NOSRC " + fn
    os.makedirs(f"{MIRROR}/Theorems", exist_ok=True)
    shutil.copyfile(src, f"{MIRROR}/Theorems/{fn}")
    base = lake('printf %s "$LEAN_PATH"')
    lean = lake("command -v lean")
    env = dict(os.environ, PATH=PATH_BIN + ":" + os.environ["PATH"])
    try:
        r = subprocess.run([lean, "-DautoImplicit=false", f"Theorems/{fn}"],
                           cwd=MIRROR, env=dict(env, LEAN_PATH=f"{MIRROR}:{base}"),
                           capture_output=True, text=True, timeout=1800)
    except subprocess.TimeoutExpired:
        return None, "TIMEOUT " + fn
    out = r.stdout + r.stderr
    if r.returncode == 0:
        return [], None
    idents = sorted(set(IDENT.findall(out)))
    err = next((l.strip() for l in out.splitlines() if "error" in l), "compile failed")
    if not idents:
        return None, err[:200]
    return idents, None


def apply(fn, imports, opens):
    path = os.path.join(WS, SRCDIR, fn)
    lines = open(path, encoding="utf-8").read().split("\n")
    add_imp = [f"import {m}" for m in imports
               if f"import {m}" not in lines]
    opened = set()
    for l in lines:
        s = l.strip()
        if s.startswith("open ") and not s.startswith("open scoped"):
            opened.update(s[5:].split())
    add_open = [f"open {n}" for n in opens if n and n not in opened]
    if add_imp:
        at = max(i for i, l in enumerate(lines) if l.startswith("import "))
        lines[at + 1:at + 1] = add_imp
    if add_open:
        idx = [i for i, l in enumerate(lines)
               if l.startswith("import ") or l.strip().startswith("open ")]
        at = max(idx) if idx else -1
        lines[at + 1:at + 1] = add_open
    if add_imp or add_open:
        open(path, "w", encoding="utf-8").write("\n".join(lines))
    return add_imp, add_open


def main(argv):
    global SRCDIR
    dry = "--dry-run" in argv
    if "--solutions" in argv:
        SRCDIR = "Solutions"
    args = [a for a in argv if not a.startswith("-")]
    if "--from-file" in argv:
        i = argv.index("--from-file")
        args = [l.strip() for l in open(argv[i + 1]) if l.strip()]
    files = args if SRCDIR == "Solutions" else [
        a if a.startswith("Thm_") else "Thm_" + a for a in args]
    idx = build_index()

    with concurrent.futures.ThreadPoolExecutor(max_workers=6) as ex:
        results = list(ex.map(compile_idents, files))

    unfixable, fixed, clean = [], [], []
    for fn, (idents, notes) in zip(files, results):
        if idents is None:
            print(f"FAILED {fn[:60]}\n      {notes}")
            unfixable.append((fn, notes))
            continue
        if not idents:
            clean.append(fn)
            print(f"CLEAN {fn}")
            continue
        imps, opens, missing = [], [], []
        for i in idents:
            short = i.split(".")[-1]
            hits = idx.get(short)
            if not hits:
                missing.append(i)
                continue
            mod, ns = hits[0]
            if mod not in imps:
                imps.append(mod)
            if ns and ns not in opens:
                opens.append(ns)
        if missing:
            unfixable.append((fn, "no Def declares: " + ", ".join(missing)))
            print(f"UNFIXABLE {fn[:60]}  ({', '.join(missing)})")
            continue
        if dry:
            print(f"DRY   {fn[:56]} +imp={imps} +open={opens}")
            fixed.append(fn)
            continue
        ai, ao = apply(fn, imps, opens)
        fixed.append(fn)
        print(f"FIXED {fn[:56]}  imp={ai} open={ao}")

    print(f"\n{len(fixed)} fixed, {len(clean)} already clean, "
          f"{len(unfixable)} unfixable (chapter-local names)")
    for fn, why in unfixable:
        print(f"  UNFIXABLE {fn[:64]}\n      {why}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    main(sys.argv[1:])
