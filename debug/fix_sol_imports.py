#!/usr/bin/env python3
"""Add the cross-chapter `Theorems.Thm_*` imports a solution is missing.

`debug/sol_deps.py` finds the references a file makes but cannot resolve; this
applies the fix.  An import is only usable when the imported node is `Proved` on
the platform ("imported platform theorems must be Proved at submission time"),
so each candidate is resolved against the platform first and anything still
`Open`/absent is reported as blocked rather than written.

Imports are inserted directly after the last existing `import` line — the
position the generator itself uses — and the edit is idempotent.

Usage:
  python3 debug/fix_sol_imports.py --chapter ChapterSirkEndToEnd
  python3 debug/fix_sol_imports.py Solutions/Sol_....lean
  python3 debug/fix_sol_imports.py --all --dry-run
"""
import glob
import os
import re
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "pipeline"))

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import upload_pipeline as U          # noqa: E402
import sol_deps as SD                # noqa: E402

WS = SD.WS
DECL_T = re.compile(r"(?m)^theorem\s+([A-Za-z_][A-Za-z0-9_'.]*)")
LAST_IMPORT = re.compile(r"(?m)^import\s+\S+[ \t]*$")
_cache = {}


def declared_name(mod):
    path = os.path.join(WS, mod.replace(".", os.sep) + ".lean")
    if not os.path.exists(path):
        return None
    txt = SD.strip_comments(open(path, encoding="utf-8").read())
    m = DECL_T.search(txt)
    return m.group(1) if m else None


def platform_status(mod):
    """`Proved` / `Open` / None for the node a module declares."""
    if mod in _cache:
        return _cache[mod]
    name = declared_name(mod)
    slug = mod[len("Theorems.Thm_"):]
    st = U.load_state()
    tid = (st["items"].get("thm:" + slug) or {}).get("theorem_id")
    status = U.theorem_status(tid) if tid else None
    if status is None and name:
        r = U.api("GET", "theorems", params={"q": name.split(".")[-1], "limit": "100"})
        for t in (r or {}).get("theorems", []):
            if t.get("theorem_name") == name:
                status = t.get("status")
                break
    _cache[mod] = status
    return status


def apply(path, mods, dry_run=False):
    text = open(path, encoding="utf-8").read()
    have = set(SD.IMPORT.findall(text))
    new = [m for m in sorted(mods) if m not in have]
    if not new:
        return []
    lines = text.split("\n")
    last = max(i for i, ln in enumerate(lines) if ln.startswith("import "))
    lines[last + 1:last + 1] = [f"import {m}" for m in new]
    if not dry_run:
        open(path, "w", encoding="utf-8").write("\n".join(lines))
    return new


def main():
    argv = sys.argv[1:]
    dry = "--dry-run" in argv
    positional = [a for a in argv if not a.startswith("--")]
    if "--all" in argv:
        files = sorted(glob.glob(os.path.join(WS, "Solutions", "*.lean")))
    elif "--chapter" in argv:
        files = []
        for ch in positional:
            files += sorted(glob.glob(os.path.join(WS, "Solutions", f"Sol_BookProof_{ch}_*.lean")))
    else:
        files = []
        for a in positional:
            files += sorted(glob.glob(a if os.path.isabs(a) else os.path.join(WS, a)))

    decls, imports_of = SD.index()
    done = blocked = 0
    for path in files:
        missing = SD.analyse(path, decls, imports_of)
        if not missing:
            continue
        ready, wait = {}, {}
        for mod, names in missing.items():
            (ready if platform_status(mod) == "Proved" else wait)[mod] = names
        added = apply(path, ready, dry_run=dry)
        tag = os.path.basename(path)
        if added:
            done += 1
            print(f"{tag}\n    + " + "\n    + ".join(f"import {m}" for m in added))
        for mod, names in sorted(wait.items()):
            blocked += 1
            print(f"{tag}\n    BLOCKED {mod}  ({', '.join(sorted(names))}) -> "
                  f"status={platform_status(mod) or 'absent'}")
    print(f"\n{len(files)} file(s): {done} patched, {blocked} blocked reference(s)"
          + (" [dry run]" if dry else ""))
    return 0


if __name__ == "__main__":
    sys.exit(main())
