#!/usr/bin/env python3
"""Static duplicate-stub scanner.

A `Theorems/Thm_*.lean` stub is *locally unbuildable* when the name it
declares is already declared by a module it transitively imports (usually the
Def bundle that absorbed the theorem).  Every module importing such a stub
fails with

    environment already contains '<name>' from Definitions.Def_<...>,

so the damage radiates: sols that list the stub as an import can never build
offline, and (rarely) Defs that list it break too.

This finds those stubs WITHOUT compiling anything: it parses declaration
names (with `namespace` tracking) and the import graph of Definitions/ and
Theorems/, then reports stubs whose declared names are provided by a
transitively imported module.

Output: state/dup_thm_scan.json  {stub_module: {name: provided_by_module}}
Prints a summary and the affected Def/sol importers.

Usage:  python3 debug/dup_thm_scan.py
"""
import glob
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DECL_RE = re.compile(
    r'^(?:@\[[^\]]*\]\s*)*(?:protected\s+|noncomputable\s+|private\s+|local\s+)*'
    r'(?:theorem|lemma|def|abbrev|structure|instance)\s+([^\s:({\[]+)')
NS_RE = re.compile(r'^\s*namespace\s+([^\s]+)')
END_RE = re.compile(r'^\s*end\b')
IMPORT_RE = re.compile(r'^\s*import\s+([A-Za-z0-9_.]+)')
# a `variable` / `open` etc. never declares; skip commands that begin with these
SKIP_PREFIX = ('variable', 'open', 'set_option', 'universe', 'axiom', 'example',
               'section', 'end', 'namespace', 'import', 'comment', 'attribute',
               'syntax', 'macro', 'elab', 'notation', '#')


def mod_of(path):
    rel = os.path.relpath(path, WS)
    return rel[:-5].replace(os.sep, '.')


def parse_module(path, want_names=True, want_imports=True):
    names, imports, stack = set(), [], []
    try:
        txt = open(path, encoding='utf-8', errors='ignore').read()
    except OSError:
        return names, imports
    for raw in txt.splitlines():
        line = raw.rstrip()
        if want_imports:
            m = IMPORT_RE.match(line)
            if m:
                imports.append(m.group(1))
        if not want_names:
            continue
        m = NS_RE.match(line)
        if m:
            stack.append(m.group(1))
            continue
        if END_RE.match(line):
            if stack:
                stack.pop()
            continue
        if line.startswith(SKIP_PREFIX):
            continue
        m = DECL_RE.match(line)
        if m:
            n = m.group(1)
            if n.startswith('_') or ':' in n or '(' in n:
                continue
            names.add('.'.join(stack + [n]) if stack else n)
    return names, imports


def main():
    thms = sorted(glob.glob(os.path.join(WS, 'Theorems/Thm_*.lean')))
    defs = sorted(glob.glob(os.path.join(WS, 'Definitions/*.lean')))
    graph, decls = {}, {}
    for p in thms + defs:
        mod = mod_of(p)
        n, im = parse_module(p)
        decls[mod] = n
        graph[mod] = im

    known = set(graph)
    memo = {}

    def closure(mod, seen=None):
        if mod in memo:
            return memo[mod]
        seen = seen or set()
        if mod in seen:
            return set()
        seen.add(mod)
        out = set()
        for imp in graph.get(mod, ()):
            if imp in known:
                out.add(imp)
                out |= closure(imp, seen)
        memo[mod] = out
        return out

    dups = {}
    for mod in graph:
        if not mod.startswith('Theorems.'):
            continue
        mine = decls[mod]
        if not mine:
            continue
        for imp in closure(mod):
            shared = mine & decls.get(imp, set())
            if shared:
                dups.setdefault(mod, {})[sorted(shared)[0]] = imp
                break

    # impact: which Defs / sols import a dup stub
    impact = {'defs': {}, 'sols': {}}
    dupmods = set(dups)
    for kind, pat in (('defs', 'Definitions/*.lean'), ('sols', 'Solutions/*.lean')):
        for p in sorted(glob.glob(os.path.join(WS, pat))):
            _, im = parse_module(p, want_names=False)
            bad = [i for i in im if i in dupmods]
            if bad:
                impact[kind][os.path.relpath(p, WS)] = bad

    out = {'dup_stubs': dups, 'impact': impact}
    dest = os.path.join(WS, 'state/dup_thm_scan.json')
    with open(dest, 'w') as fh:
        json.dump(out, fh, indent=1)
    print(f'dup stubs: {len(dups)}')
    print(f'  Def importers: {len(impact["defs"])}   sol importers: {len(impact["sols"])}')
    for m, info in sorted(dups.items()):
        (name, prov), = info.items()
        print(f'  {m}  declares {name}  (already in {prov})')
    for k, v in list(impact['defs'].items())[:20]:
        print(f'  DEF {k}: {v}')
    print(f'wrote {dest}')
    return 0


if __name__ == '__main__':
    sys.exit(main())
