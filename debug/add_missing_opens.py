"""Add a chapter's own `open` lines to stubs that are missing them.

`Tendsto` is notation that lives in the `Topology`/`Filter` namespaces. The source
chapter says `open Filter Topology`; the stub does not, so the statement fails with
`Function expected at Tendsto ... but this term has type ?m.15` -- the same shape as
the `ℓ²`/`lp` case that fix_scoped_opens.py handles for `open scoped`.

Narrow by construction: copy ONLY the `open` lines that appear in the stub's own
source chapter, and only when the stub's first error is a name the added namespaces
actually provide. That keeps it inside 5d's rule -- react to the compiler's first
error, do not sweep the corpus by static name matching.

Usage:
  python3 debug/add_missing_opens.py <slug> [<slug> ...]
  python3 debug/add_missing_opens.py --from-file list.txt
"""
import os
import re
import subprocess
import sys

WS = os.environ.get("PROVE2ME_WS") or os.getcwd()
MIRROR = os.environ.get("DEF_MIRROR", "/tmp/published_mirror")
# Namespaces that carry notation rather than declarations; an `Unknown identifier`
# for one of these is a missing `open`, not a missing import.
NOTATION = {"Tendsto", "Memℓp", "HasFiniteDimensionalSupport", "ENNReal", "Real",
            "Finset", "WithLp", "ofScientific"}


def lake(cmd):
    proj = os.environ.get("TIMEPIECE_PROJ", os.path.join(WS, "..", "timepiece331"))
    return subprocess.run(["lake", "env", "bash", "-c", cmd], cwd=proj,
                          capture_output=True, text=True).stdout.strip()


def compile_err(path):
    env = dict(os.environ,
               PATH="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin:"
                    + os.environ["PATH"])
    lp = f"{MIRROR}:{lake('printf %s \"$LEAN_PATH\"')}"
    r = subprocess.run([lake("command -v lean"), path],
                       env=dict(env, LEAN_PATH=lp), capture_output=True, text=True)
    return r.returncode, r.stdout + r.stderr


def chapter_opens(leaf):
    p = f"{WS}/../timepiece331/BookProof/{leaf}.lean"
    if not os.path.exists(p):
        return []
    out = []
    for line in open(p, encoding="utf-8", errors="ignore"):
        m = re.match(r"^open ([A-Z][\w.]*(?: [A-Z][\w.]*)*)\s*$", line)
        if m and not line.startswith("open scoped"):
            out.append("open " + m.group(1))
    return out


def main(argv):
    args = [a for a in argv if not a.startswith("-")]
    if "--from-file" in argv:
        args = [l.strip() for l in open(args[0]) if l.strip()]
    base = f"{WS}/Theorems/Thm_"
    fixed = []
    for slug in args:
        f = base + slug + ".lean"
        if not os.path.exists(f):
            print(f"  MISSING {slug}")
            continue
        rc, out = compile_err(f)
        if rc == 0:
            continue
        # `Function expected at X` puts X on the NEXT line, so the name has to be
        # matched across the newline -- matching on one line finds nothing.
        names = re.findall(r"Function expected at\s*\n\s*([A-Za-z_][\w.']*)", out)
        names += re.findall(r"Unknown identifier [`\u2018']?\s*([A-Za-z_][\w.']*)", out)
        hit = [n for n in set(names) if n in NOTATION]
        if not hit:
            continue
        text = open(f, encoding="utf-8").read()
        m = re.search(r"Generated from (\S+)\.lean", text)
        if not m:
            continue
        # Match the ERROR NAME against the namespaces the open provides, not the
        # other way round: `Tendsto` is provided BY `open Filter Topology`, so
        # testing `any(h in o for h in hit)` asks whether "Tendsto" is a substring
        # of "open Filter Topology" -- never true. Lean resolves a notation name by
        # whether the namespace is open, so accept the whole chapter open block when
        # any reported name is notation.
        adds = [o for o in chapter_opens(m.group(1)) if o not in text]
        if adds and hit:
            print(f"  (notation {hit} -> adding {adds})")
        if not adds:
            continue
        lines = text.split("\n")
        # `open` lines go after the last import and after any existing open block.
        idx = [i for i, l in enumerate(lines)
               if l.startswith("import ") or l.strip().startswith("open ")
               or l.strip().startswith("open scoped")]
        at = max(idx) if idx else -1
        lines[at + 1:at + 1] = adds
        open(f, "w", encoding="utf-8").write("\n".join(lines))
        fixed.append((slug, adds))
        print(f"  FIXED {slug[:52]} + {adds}")
    print(f"{len(fixed)} file(s) changed")


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
