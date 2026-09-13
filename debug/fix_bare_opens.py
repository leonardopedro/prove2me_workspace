#!/usr/bin/env python3
"""Qualify bare `open` namespaces in generated theorem stubs.

Generator bug (Wave stubs): some stubs emit `open LpNat FarisLavine ...` where the
source chapter wrote those `open`s *inside* an enclosing namespace, so the bare name
does not resolve at file root and the server rejects the statement with
`unknown namespace X`.

This tool resolves each bare token against the namespaces actually declared by the
stub's imported `Definitions.Def_*` bundles (composing nested `namespace` blocks),
and rewrites only tokens that (a) are not declared at root by those bundles and
(b) have a unique/most-specific declared namespace ending in `.<token>`.

Usage:
  python3 debug/fix_bare_opens.py --dry-run [--only SUBSTR]
  python3 debug/fix_bare_opens.py [--only SUBSTR]
"""
import argparse
import os
import re
import sys

WS = os.environ.get("PROVE2ME_WS") or os.getcwd()
DEFS = os.path.join(WS, "Definitions")
THMS = os.path.join(WS, "Theorems")

OPEN_RE = re.compile(r'^open (scoped\s+)?([A-Za-z_][\w.]*(?:\s+[A-Za-z_][\w.]*)*)[ \t]*$', re.M)
IMPORT_RE = re.compile(r'^import\s+Definitions\.(?P<mod>\S+)\s*$', re.M)
NS_RE = re.compile(r'^namespace\s+([A-Za-z_][\w.]*)\s*$')


def declared_namespaces(path, seen=None):
    """Fully-qualified namespaces declared in one Lean file (nesting composed)."""
    seen = seen if seen is not None else set()
    if path in seen or not os.path.exists(path):
        return set()
    seen.add(path)
    stack, out = [], set()
    for line in open(path):
        m = NS_RE.match(line)
        if m:
            parent = ".".join(stack)
            for seg in m.group(1).split("."):
                parent = f"{parent}.{seg}" if parent else seg
                out.add(parent)
            stack.append(m.group(1))
            continue
        if re.match(r'^end(\s|$)', line) and stack:
            stack.pop()
    return out


_GRAPH = {}


def transitive_ns(mods, seen=None):
    """All namespaces declared by these def modules and their Definition imports."""
    seen = seen if seen is not None else set()
    all_ns = set()
    for mod in mods:
        if mod in seen:
            continue
        seen.add(mod)
        path = os.path.join(DEFS, f"{mod}.lean")
        if not os.path.exists(path):
            continue
        all_ns |= declared_namespaces(path)
        subs = IMPORT_RE.findall(open(path).read())
        all_ns |= transitive_ns(subs, seen)
    return all_ns


def resolve(all_ns, token):
    """Return the qualified namespace for a bare token, or None."""
    if token in all_ns:
        return None  # already root-declared
    cands = sorted({ns for ns in all_ns if ns.endswith("." + token)}, key=len)
    return cands[-1] if cands else None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--only", action="append", default=[])
    a = ap.parse_args()

    files = sorted(f for f in os.listdir(THMS) if f.endswith(".lean"))
    patched = 0
    for fn in files:
        if a.only and not any(s in fn for s in a.only):
            continue
        path = os.path.join(THMS, fn)
        txt = open(path).read()
        mods = IMPORT_RE.findall(txt)
        if not mods:
            continue
        all_ns = transitive_ns(mods)
        changes = {}

        def repl(m):
            scoped, names = m.group(1), m.group(2).split()
            new, local = [], {}
            for t in names:
                q = None if "." in t else resolve(all_ns, t)
                new.append(q or t)
                if q:
                    local[t] = q
            if not local:
                return m.group(0)
            changes.update(local)
            return "open " + (scoped or "") + " ".join(new)

        new_txt = OPEN_RE.sub(repl, txt)
        # Normalize: every `open` command gets its own line (an earlier revision of
        # this tool merged adjacent open lines when rewriting).
        norm = []
        for line in new_txt.split("\n"):
            if line.startswith("open ") and " open " in line:
                norm.extend("open " + p for p in line[len("open "):].split(" open "))
            else:
                norm.append(line)
        new_txt = "\n".join(norm)
        if new_txt != txt:
            if changes:
                print(f"{fn}: " + ", ".join(f"{k}->{v}" for k, v in changes.items()))
            else:
                print(f"{fn}: (formatting only)")
            patched += 1
            if not a.dry_run:
                open(path, "w").write(new_txt)

    print(f"\n{'would patch' if a.dry_run else 'patched'} {patched} file(s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
