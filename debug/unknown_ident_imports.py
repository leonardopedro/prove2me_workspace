"""For each unknown identifier in a thm stub, find the module that declares it.

Runs the same compile the gate runs (candidate mirror, -DautoImplicit=false),
collects every `Unknown identifier \\`X\\`` and `failed to synthesize` head, then
greps the workspace Definitions/ + Theorems/ for `def|theorem|lemma|structure|
class|abbrev X` to report the declaring module and namespace.  The suggested
`import` / `open` pair is what debug/add_missing_opens.py style repairs need.

Usage:
  python3 debug/unknown_ident_imports.py Thm_BookProof_Foo_bar.lean [more.lean ...]
"""
import os
import re
import subprocess
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROJ = os.environ.get("TIMEPIECE_PROJ", os.path.join(WS, "..", "timepiece331"))
MIRROR = os.environ.get("CANDIDATE_MIRROR", os.path.join(WS, "state", "mirror"))
PATH_BIN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin"

DECL = re.compile(
    r"^\s*(?:@\[[^\]]*\]\s*)?(?:protected\s+|private\s+|nonrec\s+)*"
    r"(?:def|theorem|lemma|structure|class|abbrev|instance)\s+"
    r"(?:\[?[^\]]*\]?\s*)?([A-Za-z0-9_'.]+)")
NS = re.compile(r"^\s*namespace\s+([A-Za-z0-9_.']+)")


def lake(cmd):
    return subprocess.run(["lake", "env", "bash", "-c", cmd], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()


def index():
    """(identifier basename -> [(module, full name, namespace)]) over the workspace."""
    idx = {}
    for sub in ("Definitions", "Theorems"):
        d = os.path.join(WS, sub)
        if not os.path.isdir(d):
            continue
        for fn in os.listdir(d):
            if not fn.endswith(".lean"):
                continue
            path = os.path.join(d, fn)
            mod = f"{sub}.{fn[:-5]}"
            ns = ""
            try:
                with open(path, encoding="utf-8", errors="replace") as fh:
                    for line in fh:
                        m = NS.match(line)
                        if m:
                            ns = m.group(1)
                            continue
                        m = DECL.match(line)
                        if not m:
                            continue
                        full = m.group(1)
                        base = full.split(".")[-1]
                        idx.setdefault(base, []).append((mod, full, ns))
            except OSError:
                pass
    return idx


def one(fn, lean, base, env, idx):
    import shutil
    src = os.path.join(WS, "Theorems", fn)
    if not os.path.exists(src):
        return [f"NOSRC {fn}"]
    os.makedirs(f"{MIRROR}/Theorems", exist_ok=True)
    shutil.copyfile(src, f"{MIRROR}/Theorems/{fn}")
    try:
        r = subprocess.run([lean, "-DautoImplicit=false", f"Theorems/{fn}"],
                           cwd=MIRROR, env=dict(env, LEAN_PATH=f"{MIRROR}:{base}"),
                           capture_output=True, text=True, timeout=1800)
    except subprocess.TimeoutExpired:
        return [f"FAIL  {fn}   TIMEOUT"]
    out = r.stdout + r.stderr
    if r.returncode == 0:
        return [f"OK    {fn}"]
    idents = sorted(set(re.findall(r"Unknown identifier `([^`]+)`", out)))
    others = [l for l in out.splitlines() if "error" in l
              and "Unknown identifier" not in l][:3]
    lines = [f"FAIL  {fn}   ({len(idents)} unknown idents)"]
    for i in idents:
        short = i.split(".")[-1]
        hits = idx.get(short, [])[:3]
        if not hits:
            lines.append(f"    {i:46} -- NO DECL FOUND in Definitions//Theorems")
            continue
        for mod, full, ns in hits:
            lines.append(f"    {i:46} -> import {mod}"
                         + (f" | open {ns}" if ns and not full.startswith(ns) else ""))
    for l in others:
        lines.append(f"    OTHER {l.strip()[:150]}")
    return lines


def main(files, jobs=8):
    base = lake('printf %s "$LEAN_PATH"')
    lean = lake("command -v lean")
    env = dict(os.environ, PATH=PATH_BIN + ":" + os.environ["PATH"])
    idx = index()
    import concurrent.futures
    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as ex:
        futs = {ex.submit(one, fn, lean, base, env, idx): fn for fn in files}
        for fut in concurrent.futures.as_completed(futs):
            for line in fut.result():
                print(line, flush=True)


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("--jobs=")]
    jobs = next((int(a.split("=")[1]) for a in sys.argv[1:]
                 if a.startswith("--jobs=")), 8)
    if not args:
        sys.exit(__doc__)
    files = []
    for a in args:
        if a.endswith(".txt") and os.path.exists(a):
            files += [l.strip() for l in open(a) if l.strip()]
        else:
            files.append(a if a.startswith("Thm_") else "Thm_" + a)
    main(files, jobs)
