#!/usr/bin/env python3
"""Drop `open BookProof.X` lines whose namespace the platform never publishes.

The generator emits `open BookProof.<Chapter>` for every chapter the source file
touches, including chapters whose def bundle publishes NOTHING.  A published
bundle such as `Def_ChapterKatoRellichDeficiency` is 9 lines of docstring with no
`namespace` command at all, so on the server `open BookProof.KatoRellich` is a
hard error -- `unknown namespace 'BookProof.KatoRellich'` -- while locally the
same file declares an (empty) namespace and elaborates fine.  Two sols in the
ledger-failed set died this way and no amount of proof editing could fix them.

The namespace is safe to drop when the bundle declares no name inside it, which
is exactly the case here: a sol cannot be using a declaration the bundle does not
contain.  `--verify` asserts that for each dropped namespace before writing.

Writes nothing when the edit would be a no-op, and prints a census so the size of
the class is visible (the §2.41-9 lesson: rewriting identical bytes re-arms a
cached rejection).

Usage:
  python3 debug/fix_hollow_opens.py [--apply] [--verify]
  python3 debug/fix_hollow_opens.py --sols Sol_x.lean Sol_y.lean --apply
"""
import argparse
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PUB = f"{WS}/state/published_bundles"

RE_OPEN = re.compile(r"(?m)^(open\s+)([^\n]*?)(\s*)$")
RE_NS = re.compile(r"(?m)^namespace\s+BookProof\.(\w+)\s*$")
RE_DECL_IN_NS = re.compile(
    r"namespace\s+BookProof\.(\w+)\s*\n(.*?)^end\s+BookProof\.\1",
    re.S | re.M)

_LEDGER = None


def err_of(sol_filename):
    """The ledger's recorded platform error for `Sol_<slug>.lean`.

    Cached because the default scope walks the whole ledger-failed set and
    load_state() re-reads the JSON on every call.
    """
    global _LEDGER
    if _LEDGER is None:
        try:
            _LEDGER = json.load(open(f"{WS}/state/pipeline.json"))["items"]
        except (OSError, ValueError):
            _LEDGER = {}
    slug = sol_filename[len("Sol_"):-len(".lean")] if \
        sol_filename.startswith("Sol_") else sol_filename
    return str((_LEDGER.get(f"sol:{slug}") or {}).get("error") or "")


def published_namespaces():
    """Chapters whose PUBLISHED bundle declares `namespace BookProof.X`.

    A namespace missing from `state/published_bundles` is NOT evidence that the
    platform does not serve it -- the cache holds 547 of 687 bundles, so a naive
    "not in the cache => unpublished" test flagged 2,834 sols for editing.  That
    is the same truthiness trap `upload_pipeline.published_defs()` guards against
    by raising instead of returning an empty set.  Callers must pass the live
    catalogue; this only answers "does the cached copy declare it".
    """
    out = set()
    if not os.path.isdir(PUB):
        return out
    for fn in os.listdir(PUB):
        if not fn.endswith(".lean"):
            continue
        try:
            txt = open(os.path.join(PUB, fn), encoding="utf-8").read()
        except OSError:
            continue
        out |= set(RE_NS.findall(txt))
    return out


def local_namespaces_with_decls():
    """{chapter: set(decl names)} for the LOCAL bundles, over their namespace body."""
    out = {}
    d = f"{WS}/Definitions"
    for fn in os.listdir(d):
        if not fn.endswith(".lean"):
            continue
        try:
            txt = open(os.path.join(d, fn), encoding="utf-8").read()
        except OSError:
            continue
        for ns, body in RE_DECL_IN_NS.findall(txt):
            names = set(re.findall(
                r"(?:^|\n)\s*(?:@\[[^\]]*\]\s*)?"
                r"(?:protected\s+|private\s+|noncomputable\s+)*"
                r"(?:def|abbrev|structure|class|theorem|lemma)\s+([A-Za-z_][\w'!]*)",
                body))
            out.setdefault(ns, set()).update(names)
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--sols", nargs="*", default=None)
    ap.add_argument("--apply", action="store_true")
    ap.add_argument("--verify", action="store_true",
                    help="refuse a drop unless the local bundle declares nothing in it")
    a = ap.parse_args()

    pub_ns = published_namespaces()
    loc_ns = local_namespaces_with_decls()
    print(f"namespaces the platform publishes: {len(pub_ns)}; "
          f"local namespaces holding declarations: {len(loc_ns)}")

    sols = a.sols or sorted(
        f for k, v in json.load(open(f"{WS}/state/pipeline.json"))["items"].items()
        if k.startswith("sol:") and v.get("status") == "failed"
        for f in [f"Sol_{k[4:]}.lean"]
        if os.path.exists(f"{WS}/Solutions/{f}"))
    print(f"scope: {len(sols)} ledger-failed sol(s) "
          f"(pass --sols to widen; the default is deliberately narrow)")
    changed, checked, unsafe = [], 0, []
    for fn in sols:
        path = f"{WS}/Solutions/{fn}"
        if not os.path.exists(path):
            continue
        text = open(path, encoding="utf-8").read()
        new_lines, hit = [], False
        for line in text.splitlines(keepends=True):
            m = RE_OPEN.match(line.rstrip("\n"))
            if not m:
                new_lines.append(line)
                continue
            toks = m.group(2).split()
            keep = []
            for t in toks:
                if not t.startswith("BookProof."):
                    keep.append(t)
                    continue
                ns = t[len("BookProof."):]
                if ns in pub_ns:
                    keep.append(t)
                    continue
                # Not in the cached published copy.  Two conditions must BOTH
                # hold before touching a file: the local bundle declares nothing
                # in the namespace (so nothing can depend on it), and -- unless
                # --sols was given explicitly -- the platform's own recorded
                # error named this namespace as unknown.  Evidence, not absence.
                declared = loc_ns.get(ns, set())
                if declared:
                    if a.verify:
                        unsafe.append((fn, ns, len(declared)))
                    keep.append(t)
                    continue
                if not a.sols and f"unknown namespace `BookProof.{ns}`" not in err_of(fn):
                    keep.append(t)
                    continue
                hit = True
            if not keep:
                continue
            new_lines.append(f"{m.group(1)}{' '.join(keep)}\n")
        checked += 1
        if not hit:
            continue
        new = "".join(new_lines)
        if new == text:
            continue
        changed.append(fn)
        if a.apply:
            open(path, "w", encoding="utf-8").write(new)

    print(f"scanned {checked} sol(s); {len(changed)} would change")
    for fn in changed[:25]:
        print(f"  {'wrote' if a.apply else 'would edit'}  {fn}")
    if len(changed) > 25:
        print(f"  ... and {len(changed) - 25} more")
    if unsafe:
        print(f"\nREFUSED {len(unsafe)} namespace(s) the local bundle does declare "
              f"(dropping would break the proof):")
        for fn, ns, n in unsafe[:10]:
            print(f"  {fn}  BookProof.{ns}  ({n} local declaration(s))")
    return 0


if __name__ == "__main__":
    sys.exit(main())
