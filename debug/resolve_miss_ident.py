#!/usr/bin/env python3
"""Map each `miss-ident` sol's missing identifier to the module that defines it,
and classify whether adding that import would actually be accepted.

For every pending sol whose cached offline verdict contains
`Unknown identifier 'X'`, we look for a local `Definitions/Def_*` or
`Theorems/Thm_*` module that DECLARES `X` (matched on the last component, and
for qualified names also on the namespace), then consult the pipeline ledger
for that module's publication status.

Classes written to /tmp/mi_<class>.txt:

  import-thm-published   defining Thm node is published  -> ADD the import
  import-thm-missing     defining Thm node not published -> blocked
  import-def-published   defining Def node is published  -> ADD the import
  import-def-missing     defining Def node not published -> blocked
  not-found              no local module declares it     -> real proof work
  ambiguous              several candidate modules

Usage: python3 debug/resolve_miss_ident.py [--show <class>]
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
    r'([A-Za-z0-9_.\'\u1d4a-\u1d7f\u2070-\u209f]+)',
    re.M)
NS = re.compile(r'^namespace\s+([A-Za-z0-9_.\']+)', re.M)
END = re.compile(r'^end\b', re.M)
MISS = re.compile(r'Unknown identifier [`\'"]([^`\'"\s]+)[`\'"]')


def build_index():
    """id -> set of (kind, module)."""
    idx = collections.defaultdict(set)
    for kind, sub in (('def', 'Definitions'), ('thm', 'Theorems')):
        d = os.path.join(WS, sub)
        if not os.path.isdir(d):
            continue
        for fn in os.listdir(d):
            if not fn.endswith('.lean'):
                continue
            path = os.path.join(d, fn)
            try:
                txt = open(path, encoding='utf-8', errors='ignore').read()
            except OSError:
                continue
            mod = f'{sub}.{fn[:-5]}'
            # collect namespace spans so we can qualify declaration names
            spans = []
            stack = []
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
                cands = {bare}
                if '.' not in bare and ns:
                    cands.add(f'{ns}.{bare}')
                for c in cands:
                    idx[c].add((kind, mod))
    return idx


def main():
    idx = build_index()
    off = json.load(open(os.path.join(WS, 'state/offline_pending_check.json')))
    solv = off.get('sol', {}).get('items', {})
    st = json.load(open(os.path.join(WS, 'state/pipeline.json')))['items']

    names = [l.strip() for l in open('/tmp/fixq_miss-ident.txt') if l.strip()]
    buckets = collections.defaultdict(list)
    for sol in names:
        verdict = solv.get(sol, '')
        ids = list(dict.fromkeys(MISS.findall(verdict)))
        if not ids:
            buckets['unparsed'].append((sol, []))
            continue
        resolved, unresolved, multi = [], [], []
        for i in ids:
            # suffix match: `HermiteProductCore.pgMap_apply` must find
            # `BookProof.HermiteProductCore.pgMap_apply`; a bare name must find
            # `BookProof.Foo.name`.  Exact match covers root-namespace decls.
            # Falling back to the bare last component is WRONG: it turns a
            # qualified name into a fuzzy match against unrelated decls.
            cands = set()
            for k in idx:
                if k == i or k.endswith('.' + i):
                    cands |= idx[k]
            if not cands:
                unresolved.append(i)
                continue
            if len(cands) > 1:
                multi.append((i, sorted(cands)))
            for kind, mod in sorted(cands):
                if kind == 'def':
                    key = f'def:{mod.split(".", 1)[1]}'
                else:
                    key = f'thm:{mod.split(".", 1)[1][4:]}'
                published = st.get(key, {}).get('status') == 'done'
                resolved.append((i, mod,
                                 f'import-{kind}-'
                                 f'{"published" if published else "missing"}'))

        # Fixable by import ONLY if every missing id resolves to exactly one
        # module and every such module is already published.  Anything else is
        # blocked on publication, ambiguous, or genuinely has no defining decl.
        if not ids:
            primary = 'unparsed'
        elif unresolved:
            primary = 'not-found'
        elif multi:
            primary = 'ambiguous'
        elif any(c.endswith('missing') for _, _, c in resolved):
            primary = 'blocked-unpublished-module'
        elif resolved:
            primary = 'FIXABLE-import'
        else:
            primary = 'not-found'
        buckets[primary].append((sol, resolved))

    for cls in sorted(buckets, key=lambda c: -len(buckets[c])):
        out = f'/tmp/mi_{cls}.txt'
        with open(out, 'w') as f:
            f.writelines(s + '\n' for s, _ in buckets[cls])
        print(f'{cls:26s} {len(buckets[cls]):4d}   -> {out}')

    if '--show' in sys.argv:
        cls = sys.argv[sys.argv.index('--show') + 1]
        for sol, res in buckets.get(cls, [])[:8]:
            print(f'\n{sol}')
            for i, mod, c in res:
                print(f'    {i:46s} {mod}  [{c}]')


if __name__ == '__main__':
    main()
