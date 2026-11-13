#!/usr/bin/env python3
"""Delete declarations from a def bundle that an imported bundle already provides.

Compiles the bundle, reads Lean's `… has already been declared` errors, and
removes exactly the declaration span Lean points at, then repeats.

Span rule: a declaration starts at its own header line, extended backwards over
immediately-adjacent attribute lines and a doc comment that ends on the line just
above (nothing between, no blank line); it ends just before the next top-level
declaration/section/namespace boundary, with trailing blank lines trimmed.  The
error line points into the header, so no name guessing is involved.

After each round the file is recompiled: if the edit introduced a *syntax* error
that was not present before, the round is rolled back and the run aborts, so a
bad span can never leave the bundle damaged.

Usage: dedup_decl.py <bundle-slug>
"""
import os, re, subprocess, sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MIRROR = os.environ.get("CANDIDATE_MIRROR", os.path.join(WS, "state", "mirror"))
BASE = os.environ["LEAN_BASE"]
PATH_BIN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin"

DECL_START = re.compile(
    r"^(?:@\[[^\n]*\]\s*)?(?:noncomputable\s+|private\s+|protected\s+|partial\s+)*"
    r"(?:theorem|lemma|def|abbrev|structure|instance|class)\b")
BOUNDARY = re.compile(r"^(?:section\b|end\b|namespace\b|open\b|variable\b|set_option\b|"
                      r"attribute\b|noncomputable\s+section\b|#)")


def run(slug):
    src = f"{WS}/Definitions/Def_{slug}.lean"
    dst = f"{MIRROR}/Definitions/Def_{slug}.lean"
    open(dst, "w", encoding="utf-8").write(open(src, encoding="utf-8").read())
    r = subprocess.run(["lean", "-DautoImplicit=false", "-o", f"Definitions/Def_{slug}.olean",
                        f"Definitions/Def_{slug}.lean"], cwd=MIRROR, capture_output=True, text=True,
                       env=dict(os.environ, PATH=PATH_BIN + ":" + os.environ["PATH"],
                                LEAN_PATH=f"{MIRROR}:{BASE}"))
    return r.returncode, r.stdout + r.stderr


def decl_start_for(lines, lineno):
    """Index of the decl header at or above `lineno` (1-based error line)."""
    i = min(lineno - 1, len(lines) - 1)
    while i >= 0 and not DECL_START.match(lines[i]):
        i -= 1
    return i


def span(lines, start):
    s = start
    while True:
        j = s - 1
        while j >= 0 and not lines[j].strip():
            j -= 1
        if j < 0:
            break
        if lines[j].startswith("@["):
            s = j
            continue
        if lines[j].rstrip().endswith("-/"):
            k = j
            while k >= 0 and not lines[k].startswith("/--"):
                k -= 1
            if k < 0:
                break
            s = k
            continue
        break
    e = start + 1
    while e < len(lines):
        ln = lines[e]
        if DECL_START.match(ln) or BOUNDARY.match(ln) or ln.startswith("/--") or ln.startswith("@["):
            break
        e += 1
    return s, e


def main():
    slug = sys.argv[1]
    p = f"{WS}/Definitions/Def_{slug}.lean"
    limit = int(os.environ.get("DEDUP_ROUNDS", "60"))
    for rnd in range(limit):
        before = open(p, encoding="utf-8").read()
        rc, out = run(slug)
        if rc == 0:
            print(f"{slug}: clean after {rnd} round(s)")
            return 0
        syntax_before = sum("unexpected token" in l or "expected 'lemma'" in l for l in out.splitlines())
        dups = []
        for ln in out.splitlines():
            m = re.search(r"Def_" + re.escape(slug) + r"\.lean:(\d+):\d+: error: `([\w.']+)` has already", ln)
            if m:
                dups.append((int(m.group(1)), m.group(2)))
        if not dups:
            print(f"{slug}: no duplicate errors left. Remaining errors:")
            print("\n".join(l for l in out.splitlines() if "error" in l)[:1500])
            return 1
        lines = before.splitlines(True)
        spans, spans_triples, names = set(), [], []
        for lineno, full in dups[:3]:
            st = decl_start_for(lines, lineno)
            if st < 0:
                continue
            sp = span(lines, st)
            spans.add(sp)
            spans_triples.append((sp[0], sp[1], full.split(".")[-1]))
            names.append(full.split(".")[-1])
        if not spans:
            print(f"{slug}: cannot locate {dups[:3]}")
            return 1
        for s, e in sorted(spans, reverse=True):
            del lines[s:e]
        after = "".join(lines)
        open(p, "w", encoding="utf-8").write(after)
        rc2, out2 = run(slug)
        syntax_after = sum("unexpected token" in l or "expected 'lemma'" in l for l in out2.splitlines())
        if syntax_after <= syntax_before:
            print(f"removed {len(names)}: {', '.join(names)}", flush=True)
            continue
        # batch damaged the file: fall back to one declaration at a time and
        # keep only the deletions that leave the syntax as it was
        open(p, "w", encoding="utf-8").write(before)
        run(slug)
        kept = []
        for s, e, nm in sorted(spans_triples, reverse=True):
            cur = open(p, encoding="utf-8").read().splitlines(True)
            cand = cur[:s] + cur[e:]
            open(p, "w", encoding="utf-8").write("".join(cand))
            r3, out3 = run(slug)
            bad = sum("unexpected token" in l or "expected 'lemma'" in l for l in out3.splitlines())
            if bad > syntax_before:
                open(p, "w", encoding="utf-8").write("".join(cur))
                run(slug)
                print(f"  skip {nm}: deletion breaks syntax", flush=True)
            else:
                kept.append(nm)
        if not kept:
            print(f"{slug}: nothing removable in this batch; aborting", flush=True)
            return 1
        print(f"removed individually: {', '.join(kept)}", flush=True)
    print(f"{slug}: gave up")
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
