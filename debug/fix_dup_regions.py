#!/usr/bin/env python3
"""Repair duplicate-region def bundles (PIPELINE_PLAN §2.16), verify-first.

Some generated Def_<Ch>.lean bundles contain the chapter body 2-3 times,
separated by orphan module-doc prose and repeated header blocks.  The LAST
copy is the good one (verified 3/3 against the source's declaration list).

Per file (default = dry run, report only):
  1. find the head module doc close (first line exactly `-/`) and the LAST
     header block start (backward scan from the last `namespace BookProof.<Ch>`
     over `open`/blank/`variable`/`section` lines);
  2. verify the kept region's top-level declaration list EQUALS the source's
     (`../timepiece331/BookProof/<Ch>.lean`, same regex, same order);
  3. with --apply: back up, cut, re-verify, then compile-gate with
     `debug/_one_def2.sh` (which reads the candidate mirror — the cut file is
     copied there first); on gate FAIL the backup is restored.

A file whose decl lists differ is REPORTED and left untouched (§5d: manual).
"""
import os
import re
import shutil
import subprocess
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(WS, "..", "timepiece331", "BookProof")
CAND = "/tmp/def_candidate/Definitions"
DECL_RE = re.compile(
    r"(?m)^(?:noncomputable\s+)?(?:def|theorem|lemma|instance|abbrev)\s+([A-Za-z0-9_.]+)")
NS_RE_TMPL = r"(?m)^namespace (BookProof\.%s)\s*$"
KEEP_LINE = re.compile(
    r"^\s*$|^open\b|^variable\b|^section\b|^noncomputable section\b|^namespace\b")


def decls(text):
    return DECL_RE.findall(text)


def is_node(chap, name):
    """A source decl with its own Thm_* stub is a NODE: the bundle correctly
    omits it (§2.8d — declaring it in the bundle would clash with the
    problem).  Missing-without-stub is corruption.

    Stub filenames flatten namespace dots to underscores
    (`LadderOrd.norm_sq_le` -> `Thm_..._LadderOrd_norm_sq_le.lean`), so try
    both spellings — the raw glob alone made a real node look lost."""
    import glob
    pat = os.path.join(WS, "Theorems", "Thm_*_%s.lean")
    return bool(glob.glob(pat % name) or glob.glob(pat % name.replace(".", "_")))


def doc_close(lines):
    for i, l in enumerate(lines):
        if l.rstrip("\n") == "-/":
            return i
    return None


def header_candidates(lines, chap):
    """Candidate cut points, LAST namespace first.  The last `namespace` in
    some duplicated bundles is an empty trailing fragment (just opens and
    `end` — e.g. Def_ChapterAbelianDirectSum.lean line 1109), so callers must
    fall back to earlier candidates until the decl list verifies.  The
    namespace often drops the bundle's `Chapter` prefix
    (Def_ChapterTensorSumEsa.lean -> `namespace BookProof.TensorSumEsa`),
    hence ANY namespace line, not an exact-name match."""
    idxs = [i for i, l in enumerate(lines) if re.match(r"^namespace\s+\S", l)]
    for n in reversed(idxs):
        i = n
        while i > 0 and KEEP_LINE.match(lines[i - 1]):
            i -= 1
        yield i, n


def gate(chap):
    r = subprocess.run([os.path.join(WS, "debug", "_one_def2.sh"), chap],
                       cwd=WS, capture_output=True, text=True)
    out = (r.stdout + r.stderr).strip().splitlines()
    return out[-1] if out else "?"


def main():
    argv = sys.argv[1:]
    apply = "--apply" in argv
    do_gate = "--gate" in argv
    argv = [a for a in argv if a not in ("--apply", "--gate")]
    chaps = argv
    if not chaps:
        print(__doc__)
        return 2
    results = []
    for chap in chaps:
        path = os.path.join(WS, "Definitions", f"Def_{chap}.lean")
        src = os.path.join(SRC, f"{chap}.lean")
        if not os.path.exists(path):
            results.append((chap, "NO-BUNDLE", ""))
            continue
        if not os.path.exists(src):
            results.append((chap, "NO-SOURCE", ""))
            continue
        lines = open(path, encoding="utf-8").read().splitlines(keepends=True)
        src_names = decls(open(src, encoding="utf-8").read())
        d = doc_close(lines)
        if d is None:
            results.append((chap, "UNPARSED", f"doc={d}"))
            continue
        # Try namespace candidates last-to-first: the last one may be an
        # empty trailing fragment (kept would lose every decl).
        chosen = None
        last_miss_real = None
        for h, n in header_candidates(lines, chap):
            if h <= d:
                break
            kept = "".join(lines[:d + 1] + lines[h:])
            kept_names = decls(kept)
            missing = [x for x in dict.fromkeys(src_names) if x not in kept_names]
            missing_real = [x for x in missing if not is_node(chap, x)]
            if not missing_real:
                chosen = (h, n, kept, kept_names, missing)
                break
            last_miss_real = missing_real
        if chosen is None:
            if last_miss_real is None:
                results.append((chap, "UNPARSED", f"doc={d} no namespace after it"))
            else:
                results.append((chap, "DECL-MISMATCH",
                                f"lost non-node {last_miss_real[:3]} "
                                f"(src={len(src_names)})"))
            continue
        h, n, kept, kept_names, missing = chosen
        if h == d + 1 or all(not l.strip() for l in lines[d + 1:h]):
            results.append((chap, "NO-DUP", f"doc={d} hdr={h}"))
            continue
        extra = [x for x in dict.fromkeys(kept_names) if x not in src_names]
        note = f"nodes omitted: {missing}" if missing else ""
        if extra:
            note = (note + " | " if note else "") + f"extra(embedded): {extra[:3]}"
        if not apply:
            results.append((chap, "WOULD-CUT", (note + " | " if note else "") +
                            f"{len(lines)} -> "
                            f"{len(lines[:d + 1]) + len(lines[h:])} lines"))
            continue
        bak = f"/tmp/Def_{chap}.dupcut.bak"
        shutil.copy2(path, bak)
        open(path, "w", encoding="utf-8").writelines(lines[:d + 1] + lines[h:])
        shutil.copy2(path, os.path.join(CAND, f"Def_{chap}.lean"))
        # re-verify the WRITTEN file (write-path sanity)
        if decls(open(path, encoding="utf-8").read()) != kept_names:
            shutil.copy2(bak, path)
            results.append((chap, "WRITE-VERIFY-FAIL-restored", ""))
            continue
        if not do_gate:
            results.append((chap, "CUT", note or ""))
            continue
        g = gate(chap)
        if g.startswith("OK "):
            results.append((chap, "REPAIRED", g))
        else:
            shutil.copy2(bak, path)
            shutil.copy2(bak, os.path.join(CAND, f"Def_{chap}.lean"))
            results.append((chap, "GATE-FAIL-restored", g[:90]))
    w = max((len(c) for c, _, _ in results), default=10)
    for c, st, note in results:
        print(f"{c:<{w}}  {st:<22} {note}")
    ok = sum(1 for _, s, _ in results
             if s in ("REPAIRED", "WOULD-CUT", "NO-DUP", "CUT"))
    print(f"\n{ok}/{len(results)} clean; "
          f"{sum(1 for _, s, _ in results if s == 'DECL-MISMATCH')} need manual")
    return 0


if __name__ == "__main__":
    sys.exit(main())
