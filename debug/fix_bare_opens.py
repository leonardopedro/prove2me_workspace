#!/usr/bin/env python3
"""Qualify bare `open` namespaces in generated theorem stubs and solutions.

Generator bug (Wave stubs): some stubs emit `open LpNat FarisLavine ...` where the
source chapter wrote those `open`s *inside* an enclosing namespace, so the bare name
does not resolve at file root and the server rejects the statement with
`unknown namespace X`.

The same defect exists in generated *solutions* (`open LpNat FarisLavine ...` lifted
out of its enclosing namespace), which surfaces as
`verdict CE: unknown namespace FarisLavine`, so `--sols` runs the identical pass over
`Solutions/`.

The two passes resolve differently, on purpose:

* **stubs (default)** — resolve each bare token against the namespaces declared by the
  stub's transitive `Definitions.Def_*` import closure, and rewrite only tokens that are
  neither root-declared nor ambiguous. This is the pass verified against 101 stubs.
* **`--sols`** — honour the published-graph rule from PIPELINE_PLAN.md §1e: a namespace
  must be declared by a module the file imports *directly*, so resolution is restricted
  to the namespaces those direct imports themselves declare, and when the declaring
  bundle is not imported directly its `import Definitions.Def_<bundle>` line is added.
  Without the import the qualification alone would still be an unknown namespace.

Usage:
  python3 debug/fix_bare_opens.py --dry-run [--only SUBSTR]
  python3 debug/fix_bare_opens.py [--only SUBSTR]
  python3 debug/fix_bare_opens.py --sols --dry-run
  python3 debug/fix_bare_opens.py --sols
"""
import argparse
import os
import re
import sys

WS = os.environ.get("PROVE2ME_WS") or os.getcwd()
DEFS = os.path.join(WS, "Definitions")
THMS = os.path.join(WS, "Theorems")
SOLS = os.path.join(WS, "Solutions")

# The token separator must be spaces/tabs ONLY: with `\s+` the repetition happily
# crossed newlines and swallowed the following commands (`import …`, `noncomputable
# section`) onto the open line, destroying the file. Keep it line-local.
OPEN_RE = re.compile(r'^open (scoped[ \t]+)?([A-Za-z_][\w.]*(?:[ \t]+[A-Za-z_][\w.]*)*)[ \t]*$', re.M)
IMPORT_RE = re.compile(r'^import\s+Definitions\.(?P<mod>\S+)\s*$', re.M)
ANY_IMPORT_RE = re.compile(r'^import\s+(?P<kind>Definitions|Theorems)\.(?P<mod>\S+)\s*$', re.M)
NS_RE = re.compile(r'^namespace\s+([A-Za-z_][\w.]*)\s*$')

_MODULE_NS = {}


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


def module_ns(kind, mod):
    """Namespaces declared by one module, cached. ({kind}/{mod} -> set[str])"""
    key = (kind, mod)
    if key not in _MODULE_NS:
        home = DEFS if kind == "Definitions" else THMS
        _MODULE_NS[key] = declared_namespaces(os.path.join(home, f"{mod}.lean"))
    return _MODULE_NS[key]


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


def is_composite(ns, all_ns):
    """True when `ns` is a namespace declared *inside* another declared one.

    `Def_ChapterNavierStokesLagrangianCanonical` has `namespace BookProof.NavierStokesFlow`
    nested inside `namespace LagrangianCanonical`, so it genuinely declares
    `...LagrangianCanonical.BookProof.NavierStokesFlow.CanonicalVector` — a name that would
    otherwise win "most specific" resolution for the bare token `CanonicalVector` against the
    real `BookProof.NavierStokesFlow.CanonicalVector`. Reject any candidate that splits at a
    dot boundary into two namespaces that are each declared.
    """
    parts = ns.split(".")
    for i in range(1, len(parts)):
        if ".".join(parts[:i]) in all_ns and ".".join(parts[i:]) in all_ns:
            return True
    return False


def candidates(all_ns, token):
    """Declared namespaces ending in `.<token>`, composite ones removed."""
    return [ns for ns in sorted({n for n in all_ns if n.endswith("." + token)}, key=len)
            if not is_composite(ns, all_ns)]


def resolve(all_ns, token):
    """Return the qualified namespace for a bare token, or None."""
    if token in all_ns:
        return None  # already root-declared
    cands = candidates(all_ns, token)
    return cands[-1] if cands else None


def add_import(txt, kind, mod):
    """Insert `import <kind>.<mod>` after the last existing import line."""
    if re.search(r'^import\s+' + re.escape(f"{kind}.{mod}") + r'\s*$', txt, re.M):
        return txt
    lines = txt.split("\n")
    last = max((i for i, l in enumerate(lines) if l.startswith("import ")), default=None)
    if last is None:
        return txt
    lines.insert(last + 1, f"import {kind}.{mod}")
    return "\n".join(lines)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--only", action="append", default=[])
    ap.add_argument("--sols", action="store_true",
                    help="run over Solutions/ instead of Theorems/")
    a = ap.parse_args()

    home = SOLS if a.sols else THMS
    # Global namespace -> declaring module map (used to add a missing direct import).
    ns_owner = {}
    for kind, root in (("Definitions", DEFS), ("Theorems", THMS)):
        for fn in sorted(os.listdir(root)):
            if not fn.endswith(".lean"):
                continue
            mod = fn[:-len(".lean")]
            for ns in sorted(module_ns(kind, mod), key=len):
                ns_owner.setdefault(ns, (kind, mod))

    files = sorted(f for f in os.listdir(home) if f.endswith(".lean"))
    patched = 0
    for fn in files:
        if a.only and not any(s in fn for s in a.only):
            continue
        path = os.path.join(home, fn)
        txt = open(path).read()
        imports = ANY_IMPORT_RE.findall(txt)
        if not imports:
            continue
        added = []

        if a.sols:
            # Strict: only what the directly imported modules declare themselves.
            all_ns = set()
            for kind, mod in imports:
                all_ns |= module_ns(kind, mod)
        else:
            all_ns = transitive_ns(IMPORT_RE.findall(txt))

        changes = {}

        def repl(m):
            scoped, names = m.group(1), m.group(2).split()
            new, local = [], {}
            for t in names:
                if "." in t:
                    new.append(t)
                    continue
                q = resolve(all_ns, t)
                if q is None and t not in all_ns and a.sols:
                    # Not declared by a direct import: qualify via the owner and
                    # make the declaring module a direct import (§1e rule).
                    owner = ns_owner.get(t)
                    if owner is None or is_composite(t, ns_owner):
                        cands = candidates(ns_owner, t)
                        if not cands:
                            new.append(t)
                            continue
                        q, owner = cands[-1], ns_owner[cands[-1]]
                    else:
                        q = t
                    new.append(q)
                    local[t] = q
                    if owner[1] not in [m2 for _, m2 in imports]:
                        added.append(owner)
                    continue
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
        # All import edits happen after the open rewrite, on the final text.
        for kind, mod in added:
            new_txt = add_import(new_txt, kind, mod)
        if new_txt != txt:
            if changes:
                print(f"{fn}: " + ", ".join(f"{k}->{v}" for k, v in changes.items()))
            else:
                print(f"{fn}: (formatting only)")
            if added:
                print(f"    +import " + ", ".join(f"{k}.{m}" for k, m in added))
            patched += 1
            if not a.dry_run:
                open(path, "w").write(new_txt)

    print(f"\n{'would patch' if a.dry_run else 'patched'} {patched} file(s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
