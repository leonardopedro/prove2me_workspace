"""Heal a def bundle whose candidate gate fails on `Unknown identifier`.

The platform's def-bundle generation sometimes drops (a) a sibling theorem
the proof text still references, or (b) the `import Theorems.Thm_...` line
for a leaf the platform has already published as a thm module.  Both surface
as `def gate: candidate build: FAIL ... Unknown identifier `X`` and block
the def item forever (2026-10-17: Def_ChapterQgBrstCompleted, one of the 14
publication roots -- its failure gates every downstream def and its sols).

Per error this loop tries the safe repair:

1. find some `Theorems/Thm_*.lean` declaring `BookProof.<ns>.X`;
2. if the platform says that thm is published (it is reachable in the def's
   environment), add `import Theorems.Thm_<slug>` -- def -> thm import is
   legal (PIPELINE 1s) and the name resolves.

Anything else stops with a report; grafting a declaration inline is a
hand repair (needs namespace judgement), never guessed here.

Usage: python3 debug/heal_def_missing_imports.py ChapterQgBrstCompleted
"""
import os
import re
import subprocess
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402

STMT = re.compile(r"(?m)^(?:@\[[^\]]*\]\s*)?(?:theorem|lemma)\s+(BookProof\.\S*?)\.([A-Za-z_0-9']+)\s*(?:\(|:|{)")


def published_thm_slugs():
    pub = up.published_theorems()
    out = set()
    for p in pub:
        out.add(p)
        # accept slug / dotted / module forms
        out.add(p.replace(".", "_"))
        out.add(p.replace("BookProof.", "BookProof_").replace(".", "_"))
    return out


def main():
    if len(sys.argv) < 2:
        raise SystemExit(__doc__)
    target = sys.argv[1]
    path = f"{WS}/Definitions/Def_{target}.lean"
    pub = published_thm_slugs()
    for it in range(12):
        r = subprocess.run([sys.executable, f"{WS}/debug/regate_bundles.py", target],
                           capture_output=True, text=True, cwd=WS)
        out = r.stdout + r.stderr
        if re.search(rf"{re.escape(target)}\s+OK\b", out) or "1 OK" in out:
            print(f"GATE OK after {it} repair(s)")
            return 0
        m = re.search(r"Unknown identifier `([^`]+)`", out)
        if not m:
            print(f"stop (iter {it}): no unknown-identifier error")
            print(out[-900:])
            return 1
        name = m.group(1)
        print(f"[iter {it}] unknown identifier: {name}", flush=True)
        hit = None
        for f in sorted(os.listdir(f"{WS}/Theorems")):
            if not f.endswith(".lean"):
                continue
            txt = open(f"{WS}/Theorems/{f}", encoding="utf-8", errors="ignore").read()
            mm = STMT.search(txt)
            if not mm:
                continue
            ns, leaf = mm.group(1), mm.group(2)
            if leaf != name:
                continue
            slug = f[len("Thm_"):-len(".lean")]
            if slug in pub or f"Thm_{slug}" in pub or f"{ns}.{leaf}".replace(".", "_") in pub:
                hit = slug
                break
            hit = hit or slug
        if hit is None:
            print("  no Thm stub declares it -- hand repair needed")
            return 1
        # is THIS stub published?
        if not (hit in pub or f"Thm_{hit}" in pub):
            print(f"  stub Thm_{hit} exists but is NOT published -- hand repair needed")
            return 1
        imp = f"import Theorems.Thm_{hit}\n"
        t = open(path, encoding="utf-8").read()
        if imp in t:
            print(f"  import Thm_{hit} already present but name still unknown -- hand repair")
            return 1
        lines = t.splitlines(keepends=True)
        last = max(i for i, l in enumerate(lines) if l.startswith("import "))
        lines.insert(last + 1, imp)
        open(path, "w", encoding="utf-8").write("".join(lines))
        print(f"  + import Theorems.Thm_{hit}", flush=True)
    print("gave up after 12 iterations")
    return 1


if __name__ == "__main__":
    sys.exit(main())