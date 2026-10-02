"""Compile generated solution stubs against the published mirror before submitting.

SKILL.md, step 3: "compile it locally first (`lake env lean solution.lean`),
and fix any errors -- only submit to the platform after local compilation
succeeds."

I was skipping that for solutions and letting the server find the breakage.
Every failure in the last batch was locally detectable -- unknown namespace from
an unimported def bundle, `Ambiguous term sqSumPoly` (two defs declare the same
name), `Unknown identifier dsOp_essentiallySelfAdjointOn`, and a `rewrite`
tactic that does not fire. Five server verdicts spent to learn five things a
local `lean` run reports in seconds.

Usage:
  python3 debug/check_sol_local.py --from-file list.txt
  python3 debug/check_sol_local.py Sol_<slug> [...]
"""
import os
import subprocess
import sys
import tempfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROJ = os.environ.get("TIMEPIECE_PROJ", os.path.join(ROOT, "..", "timepiece331"))
MIRROR = os.environ.get("DEF_MIRROR", "/tmp/published_mirror")


def _lake_env(cmd):
    return subprocess.run(["lake", "env", "bash", "-c", cmd], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()


def main(argv):
    args = [a for a in argv if not a.startswith("-")]
    if "--from-file" in argv:
        args = [l.strip() for l in open(args[0]) if l.strip()]
    if not args:
        raise SystemExit(__doc__)
    base = _lake_env('printf %s "$LEAN_PATH"')
    lean = _lake_env("command -v lean")
    env = dict(os.environ, LEAN_PATH=f"{MIRROR}:{base}")
    ok, bad = [], []
    with tempfile.TemporaryDirectory() as d:
        for i, a in enumerate(args):
            name = a[4:] if a.startswith("Sol_") else a
            path = f"{ROOT}/Solutions/Sol_{name}.lean"
            if not os.path.exists(path):
                bad.append((name, "missing stub"))
                continue
            out = os.path.join(d, f"S{i}.lean")
            # Same directory as the real file, so any relative path in the stub
            # resolves the way it will when the platform compiles it.
            shutil_copy(path, out)
            r = subprocess.run([lean, out], env=env, capture_output=True, text=True)
            if r.returncode == 0:
                ok.append(name)
            else:
                err = next((l for l in r.stdout.splitlines() if "error" in l), "")
                bad.append((name, err.strip()[:150]))
    for n, e in bad:
        print(f"  FAIL  {n[:56]}\n        {e}")
    print(f"local compile: {len(ok)}/{len(args)} OK against {MIRROR}")
    out = os.environ.get("SOL_OK_FILE")
    if out:
        open(out, "w").write("\n".join(ok) + ("\n" if ok else ""))
    return 0 if ok and not bad else 1


def shutil_copy(src, dst):
    with open(src, "rb") as f:
        data = f.read()
    with open(dst, "wb") as f:
        f.write(data)


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
