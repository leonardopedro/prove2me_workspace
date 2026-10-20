#!/usr/bin/env python3
"""Resolve a def bundle's current gate error into a missing `Theorems.Thm_*`
stub import (or namespace open) and apply it.

Reads each bundle's FRESH `FAIL ... Unknown identifier \`X\`` verdict from
state/def_gate.json, locates the local `Definitions/Def_*` or `Theorems/Thm_*`
module that DECLARES `X` (suffix/namespace match, mirroring
debug/resolve_miss_ident.py), and adds:

  * `import <that module>`      -- when the definer is a Thm stub, or a Def
    bundle that is NOT already imported
  * `open <declaring namespace>` -- when the caller is neither inside that
    namespace nor already opening it

Cross-bundle theorems live in `Theorems/Thm_*` stubs because the platform
publishes a *defs-only* projection of each bundle, so a bundle alone can never
supply them (see debug/fix_thm_stub_imports.py for the full rationale).

Idents whose error is not `unknownIdentifier` are reported and skipped -- those
need a different fix (noncomputable, instance, dropped structure field).

Usage:
  python3 debug/fix_next_missing.py ChapterFoo [ChapterBar ...] [--limit N]
"""
import collections
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

DECL = re.compile(
    r'^\s*(?:@\[[^\]]*\]\s*)?(?:protected\s+|noncomputable\s+|private\s+)?'
    r'(?:def|theorem|lemma|abbrev|structure|inductive|class|instance)\s+'
    r"([A-Za-z0-9_.\'\u1d4a-\u1d7f\u2070-\u209f]+)",
    re.M)
NS = re.compile(r'^namespace\s+([A-Za-z0-9_.\']+)', re.M)
MISS = re.compile(r"Unknown identifier [`'\"]([^`'\"\s]+)[`'\"]")


def build_index():
    """decl-name -> list of (kind, module, declaring_namespace)."""
    idx = collections.defaultdict(list)
    for kind, sub in (('def', 'Definitions'), ('thm', 'Theorems')):
        d = os.path.join(WS, sub)
        if not os.path.isdir(d):
            continue
        for fn in sorted(os.listdir(d)):
            if not fn.endswith('.lean'):
                continue
            path = os.path.join(d, fn)
            try:
                txt = open(path, encoding='utf-8', errors='ignore').read()
            except OSError:
                continue
            mod = f'{sub}.{fn[:-5]}'
            spans, stack = [], []
            for m in re.finditer(r'^(namespace|end)\b\s*([A-Za-z0-9_.\']+)?', txt, re.M):
                if m.group(1) == 'namespace':
                    stack.append(m.group(2) or '')
                elif stack:
                    stack.pop()
                spans.append((m.start(), '.'.join(x for x in stack if x)))

            def ns_at(pos):
                cur = ''
                for start, name in spans:
                    if start <= pos:
                        cur = name
                    else:
                        break
                return cur
            for m in DECL.finditer(txt):
                bare = m.group(1)
                ns = ns_at(m.start())
                if '.' in bare:
                    cands = {bare}
                else:
                    cands = {bare} | ({f'{ns}.{bare}'} if ns else set())
                for c in cands:
                    idx[c].append((kind, mod, ns))
    return idx


def resolve(idx, ident):
    cands = []
    for k, v in idx.items():
        if k == ident or k.endswith('.' + ident):
            cands.extend(v)
    # de-dup on (kind, mod)
    seen, out = set(), []
    for kind, mod, ns in cands:
        if (kind, mod) not in seen:
            seen.add((kind, mod))
            out.append((kind, mod, ns))
    return out


def mod_to_module(kind, mod):
    """'Theorems.Thm_X' -> 'Theorems.Thm_X'; 'Definitions.Def_X' -> same."""
    return mod


def main():
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    if not args:
        print(__doc__)
        return 2
    idx = build_index()
    gate = json.load(open(os.path.join(WS, 'state', 'def_gate.json')))
    changed, skipped = [], []
    for ch in args:
        ent = gate.get(ch) or {}
        st = str(ent.get('status', ''))
        m = MISS.search(st)
        if not st.startswith('FAIL'):
            print(f'  {ch}: status={st[:60]} -- skip')
            skipped.append(ch)
            continue
        if not m:
            print(f'  {ch}: not an unknown-identifier error -- needs manual fix')
            print(f'        {st[:170]}')
            skipped.append(ch)
            continue
        ident = m.group(1)
        cands = resolve(idx, ident)
        if not cands:
            print(f'  {ch}: `{ident}` declared nowhere locally -- real work')
            skipped.append(ch)
            continue
        if len(cands) > 1:
            # A theorem is usually declared by BOTH its Def bundle and its Thm
            # stub.  Only the stub can supply it: the platform publishes a
            # defs-only projection of each bundle, so the Def bundle's theorems
            # are stripped from what the mirror stages -- which is exactly why
            # the identifier went missing.  Prefer the Thm stub; fall back to
            # the Def bundle only when no stub declares it (a `def`/`structure`,
            # which survives the defs-only projection).
            thms = [c for c in cands if c[0] == 'thm']
            defs = [c for c in cands if c[0] == 'def']
            if len(thms) == 1:
                cands = thms
            elif len(defs) == 1:
                cands = defs
            else:
                print(f'  {ch}: `{ident}` ambiguous -> {[(k, mo) for k, mo, _ in cands]}')
                skipped.append(ch)
                continue
        kind, mod, decl_ns = cands[0]
        path = os.path.join(WS, 'Definitions', f'Def_{ch}.lean')
        txt = open(path, encoding='utf-8').read()
        orig = txt
        imp = f'import {mod}'
        if imp + '\n' not in txt:
            lines = txt.split('\n')
            last_imp = max(i for i, l in enumerate(lines) if l.startswith('import '))
            lines.insert(last_imp + 1, imp)
            txt = '\n'.join(lines)
        # namespace coverage
        fm = re.search(r'^namespace (\S+)', txt, re.M)
        own = fm.group(1) if fm else ''
        covered = (own == decl_ns) or (decl_ns and any(
            re.search(r'\b' + re.escape(decl_ns) + r'\b', o.group(0))
            for o in re.finditer(r'^open[^\n]*$', txt, re.M)))
        if decl_ns and not covered:
            nm = re.search(r'^namespace \S[^\n]*\n', txt, re.M)
            if nm:
                txt = txt[:nm.end()] + f'open {decl_ns}\n' + txt[nm.end():]
            else:
                txt = f'open {decl_ns}\n' + txt
        if txt != orig:
            open(path, 'w', encoding='utf-8').write(txt)
            print(f'  {ch}: added `{ident}` from {mod}'
                  f'{"" if covered or own == decl_ns else f" + open {decl_ns}"}')
            changed.append(ch)
        else:
            print(f'  {ch}: `{ident}` already satisfied (from {mod}) -- skip')
            skipped.append(ch)
    print(f'\n{len(changed)} bundle(s) updated, {len(skipped)} skipped')
    return 0


if __name__ == '__main__':
    sys.exit(main())
