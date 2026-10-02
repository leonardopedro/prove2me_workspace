"""Elaborate generated theorem stubs the way the platform does.

The platform compiles formal statements with `autoImplicit := false`. Lean's
default is `true`, so a stub with an unbound name typechecks locally and then
fails on the platform with `Unknown identifier`. Checking a stub without that
option set produces a false OK, which is worse than no check: it sent me
looking for signature skew between the platform's published bundles and
timepiece when the published bundles were byte-identical to the source all
along. The stub was simply stale.

Usage:
  python3 debug/check_stmt_faithful.py Thm_<slug>[ Thm_<slug> ...]
  python3 debug/check_stmt_faithful.py --from-file list.txt
"""
import os
import re
import subprocess
import sys
import tempfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROJ = os.environ.get("TIMEPIECE_PROJ", os.path.join(ROOT, "..", "timepiece331"))
MIRROR = os.environ.get("DEF_MIRROR", "/tmp/published_mirror")


def _lake_env(cmd):
    return subprocess.run(["lake", "env", "bash", "-c", cmd], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()


def _stage(text):
    """Cut the stub down to its single theorem, with the platform's options."""
    m = re.search(r"(?m)^[ \t]*theorem\s+\S", text)
    if not m:
        raise SystemExit("no theorem declaration in stub")
    head = text[:m.start()].rstrip()
    # Match the platform: no autoImplicit, so nothing gets bound implicitly.
    head = re.sub(r"(?m)^\s*set_option\s+autoImplicit\s+true\s*$", "", head)
    if "autoImplicit" not in head:
        # `import` must stay first, so the option goes just after the last one.
        lines = head.split("\n")
        last = max((i for i, l in enumerate(lines)
                    if l.startswith(("import ", "open "))), default=0)
        lines.insert(last + 1, "set_option autoImplicit false")
        head = "\n".join(lines)
    return f"{head}\n\n{text[m.start():].strip()}\n"


def main(argv):
    args = [a for a in argv if not a.startswith("-")]
    if "--from-file" in argv:
        args = [l.strip() for l in open(args[0]) if l.strip()]
    if not args:
        raise SystemExit(__doc__)
    base = _lake_env('printf %s "$LEAN_PATH"')
    lean = _lake_env("command -v lean")
    env = dict(os.environ, LEAN_PATH=f"{MIRROR}:{base}")
    fails = 0
    with tempfile.TemporaryDirectory() as d:
        for i, a in enumerate(args):
            path = a if a.endswith(".lean") else f"{ROOT}/Theorems/Thm_{a}.lean"
            if not os.path.exists(path):
                print(f"  MISSING {a}")
                fails += 1
                continue
            out = os.path.join(d, f"T{i}.lean")
            with open(out, "w") as fh:
                fh.write(_stage(open(path).read()))
            r = subprocess.run([lean, out], env=env, capture_output=True, text=True)
            if r.returncode == 0:
                print(f"  OK    {a}")
            else:
                fails += 1
                err = next((l for l in r.stdout.splitlines() if "error" in l), "")
                print(f"  FAIL  {a}\n        {err.strip()[:150]}")
    print(f"faithful check: {len(args) - fails}/{len(args)} OK "
          f"(autoImplicit false, mirror {MIRROR})")
    return 1 if fails else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
