#!/usr/bin/env python3
"""Qualify ambiguous identifiers at the exact position Lean reports.

For each sol: compile it against the published mirror, collect every
`L:<line>:<col>: error: Ambiguous term <name>` position, and rewrite that
occurrence to `<replacement>`.  Repeat until no ambiguity error is left (a fix
often exposes the next one), then report whatever errors remain.

The position is resolved defensively (Lean's column may be reported 0- or
1-based); a replacement is applied only when the text at the candidate offset
is exactly the ambiguous name, so a wrong offset is a no-op, never a rewrite
of an unrelated token.

Usage:
  python3 debug/fix_ambig.py <slug> <term>=<replacement> [...]
  python3 debug/fix_ambig.py --plan /tmp/fix_ambig_plan.tsv   # slug\tterm\trepl
"""
import os
import re
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import check_sol_local as c  # noqa: E402

RE_ERR = re.compile(r"S\.lean:(\d+):(\d+): error: Ambiguous term\s+(\S+)")


def lean_env():
    base = c._lake_env('printf %s "$LEAN_PATH"')
    lean = c._lake_env("command -v lean")
    return lean, dict(os.environ, LEAN_PATH=f"{c.MIRROR}:{base}")


def compile_one(lean, env, path):
    with tempfile.TemporaryDirectory() as d:
        out = os.path.join(d, "S.lean")
        c.shutil_copy(path, out)
        r = subprocess.run([lean, out], env=env, capture_output=True, text=True)
        return r.returncode == 0, r.stdout


def apply_at(lines, lineno, col, term, repl):
    """Rewrite `term` at the reported position; returns True if applied."""
    i = lineno - 1
    if i < 0 or i >= len(lines):
        return False
    line = lines[i]
    for start in (col - 1, col, col - 2):        # 1-based, 0-based, off-by-one
        if start >= 0 and line[start:start + len(term)] == term:
            before = line[start - 1] if start else ""
            if before in ".`":                   # already qualified / quoted
                return False
            lines[i] = line[:start] + repl + line[start + len(term):]
            return True
    return False


def fix(slug, repls, lean, env, max_iter=8, verbose=True):
    path = os.path.join(WS, "Solutions", f"Sol_{slug}.lean")
    if not os.path.exists(path):
        print(f"{slug}: MISSING FILE")
        return False, "missing file"
    src = open(path, encoding="utf-8").read()
    orig = src
    last_err = ""
    for _ in range(max_iter):
        ok, out = compile_one(lean, env, path)
        if ok:
            if src != orig:
                open(path, "w", encoding="utf-8").write(src)
            return True, ""
        errs = RE_ERR.findall(out)
        if not errs:
            first = next((l for l in out.splitlines() if "error" in l), "?")
            open(path, "w", encoding="utf-8").write(src)
            return False, first.strip()[:170]
        lines = src.splitlines(keepends=True)
        applied = 0
        # same line => later columns first, so an earlier replacement does not
        # shift the column of a not-yet-applied error on that line
        errs.sort(key=lambda e: (int(e[0]), -int(e[1])))
        for ln, col, term in errs:
            repl = repls.get(term)
            if not repl:
                last_err = f"no replacement for ambiguous `{term}`"
                continue
            if apply_at(lines, int(ln), int(col), term, repl):
                applied += 1
        if not applied:
            open(path, "w", encoding="utf-8").write(src)
            return False, last_err or f"could not place {errs[0][2]}"
        src = "".join(lines)
    open(path, "w", encoding="utf-8").write(src)
    return False, "still ambiguous after iterations"


def main():
    argv = sys.argv[1:]
    if argv and argv[0] == "--plan":
        plan = [l.rstrip("\n").split("\t") for l in open(argv[1]) if l.strip()]
    else:
        slug = argv[0]
        plan = [[slug] + [a.split("=", 1) for a in argv[1:]][i]
                for i in range(len(argv) - 1)]
        plan = [[slug, argv[i + 1].split("=", 1)[0],
                 argv[i + 1].split("=", 1)[1]] for i in range(len(argv) - 1)]
    # group replacements by slug
    by = {}
    for row in plan:
        if len(row) == 3:
            slug, term, repl = row
        elif len(row) == 2:            # slug<TAB>term=repl
            slug, pair = row
            term, repl = pair.split("=", 1)
        else:
            continue
        by.setdefault(slug, {})[term] = repl
    lean, env = lean_env()
    good, bad = [], []
    for slug, repls in by.items():
        ok, err = fix(slug, repls, lean, env)
        (good if ok else bad).append(slug)
        print(f"  {'OK  ' if ok else 'FAIL'} {slug[:64]}"
              + ("" if ok else f"\n        {err}"), flush=True)
    print(f"\nlocal compile: {len(good)}/{len(by)} OK against {c.MIRROR}")
    if bad:
        print("failed: " + ", ".join(bad))
    return 0 if not bad else 1


if __name__ == "__main__":
    sys.exit(main())
