"""Add the `Theorems.*` import a stub needs for a name no def bundle declares.

§1s precedent, reached from §5d: a statement may reference a helper that is a
THEOREM, not part of any published def bundle. `Def_ChapterHermiteQuadraticEsa`
does not carry `continuous_confW` -- that name is published as its own problem,
`Thm_BookProof_HermiteQuadraticEsa_continuous_confW` -- so a stub importing only
def bundles fails with `Function expected at continuous_confW ... but this term
has type ?m.1`.

Fix per file, not by corpus-wide name matching (§5d): take the compiler's first
`Function expected at <name>` / `Unknown identifier <name>`, look the name up in
the platform index, and if it is a published theorem, add that one import.

Imports must go above every `open` (Lean: "invalid 'import' command, it must be
used at the beginning of the file"), so the insertion point is after the LAST
import, not after the last import-or-open.
"""
import json
import os
import re
import subprocess
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MIRROR = os.environ.get("DEF_MIRROR", "/tmp/published_mirror")


def names_to_theorems():
    """short name -> Thm_ module, for locally available theorem stubs."""
    out = {}
    d = f"{WS}/Theorems"
    for f in os.listdir(d):
        if not (f.startswith("Thm_") and f.endswith(".lean")):
            continue
        mod = f[:-5]
        m = re.search(r"(?m)^(?:theorem|lemma)\s+([A-Za-z_][\w.]*)",
                      open(f"{d}/{f}", errors="ignore").read())
        if m:
            out.setdefault(m.group(1).split(".")[-1], mod)
    return out


def add_imports(path, mods):
    lines = open(path, encoding="utf-8").read().split("\n")
    adds = [f"import Theorems.{m}" for m in mods
            if f"import Theorems.{m}" not in lines]
    if not adds:
        return False
    idx = [i for i, l in enumerate(lines) if l.startswith("import ")]
    at = max(idx) if idx else -1
    lines[at + 1:at + 1] = adds
    open(path, "w", encoding="utf-8").write("\n".join(lines))
    return True


def main(argv):
    lookup = names_to_theorems()
    changed = []
    for slug in argv:
        f = f"{WS}/Theorems/Thm_{slug}.lean"
        if not os.path.exists(f):
            print(f"  MISSING {slug}")
            continue
        out = compile_with_mirror(f)
        # The compiler words this several ways; `Function expected at X` puts X
        # on the NEXT line, so the name cannot be matched on the same line.
        names = []
        for m in re.finditer(r"Function expected at\s*\n\s*([A-Za-z_][\w.']*)", out):
            names.append(m.group(1))
        names += re.findall(r"Unknown identifier [`\u2018']?([A-Za-z_][\w.']*)", out)
        mods = []
        for n in names:
            mod = lookup.get(n.split(".")[-1])
            if mod and mod not in mods and re.search(
                    rf"(?<![\w.]){re.escape(n.split('.')[-1])}\b",
                    open(f, encoding="utf-8").read()):
                mods.append(mod)
        if mods and add_imports(f, mods):
            changed.append((slug, mods))
            print(f"  FIXED {slug[:52]} + {mods}")
        elif not mods:
            print(f"  no missing theorem import for {slug[:56]}")
    print(f"{len(changed)} file(s) changed")


def compile_with_mirror(path):
    proj = os.environ.get("TIMEPIECE_PROJ", os.path.join(WS, "..", "timepiece331"))
    env = dict(os.environ,
               PATH="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin:"
                    + os.environ["PATH"])
    base = subprocess.run(["lake", "env", "bash", "-c", 'printf %s "$LEAN_PATH"'],
                          cwd=proj, capture_output=True, text=True).stdout.strip()
    lean = subprocess.run(["lake", "env", "bash", "-c", "command -v lean"],
                          cwd=proj, capture_output=True, text=True).stdout.strip()
    r = subprocess.run([lean, path], env=dict(env, LEAN_PATH=f"{MIRROR}:{base}"),
                       capture_output=True, text=True)
    return r.stdout + r.stderr


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
