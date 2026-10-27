#!/usr/bin/env python3
"""Fix miss-ident sols whose missing identifier is merely NOT IN SCOPE.

For every sol in /tmp/fixq_miss-ident.txt we take the identifiers the cached
offline verdict reports as `Unknown identifier X`, find the module that
DECLARES X and the NAMESPACE it is declared under, then decide the smallest
fix:

  need-open    sol already imports the declaring module, but does not
               `open <namespace>`  -> append the open        [FIXABLE]
  need-import  sol does not import the declaring module, and the module is
               already PUBLISHED   -> append the import       [FIXABLE]
  no-namespace declaring module has no namespace (root decl) and the sol
               imports it -> the identifier really is absent   [blocked]
  unpublished  declaring module is not published yet             [blocked]
  not-found    no local module declares it                       [needs work]
  ambiguous    several distinct declaring modules                [needs review]

Only `need-open` and `need-import` are ever written.  Safety rules from
SKILL.md are enforced: never import/depend on the sol's own target theorem,
and never duplicate an import.  `open` lines are only appended when no
existing `open` line already covers the namespace.

Usage:  python3 debug/fix_sol_opens.py [--dry-run] [--show]
"""
import collections
import json
import os
import re
import shutil
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

DECL = re.compile(
    r'^\s*(?:@\[[^\]]*\]\s*)?(?:protected\s+|noncomputable\s+|private\s+)?'
    r'(?:def|theorem|lemma|abbrev|structure|inductive|class|instance)\s+'
    r"([A-Za-z0-9_.'\u1d4a-\u1d7f]+)",
    re.M)
NAMESPACE = re.compile(r'^namespace\s+([A-Za-z0-9_.\']+)', re.M)
MISS = re.compile(r"Unknown identifier [`'\"]([^`'\"\s]+)[`'\"]")


def namespace_spans(txt):
    """[(match_start, namespace_at_that_point)] for each line position."""
    spans, stack = [], []
    for m in re.finditer(r'^(namespace|end)\b\s*([A-Za-z0-9_.\']+)?', txt, re.M):
        if m.group(1) == 'namespace':
            stack.append(m.group(2) or '')
        elif stack:
            stack.pop()
        spans.append((m.start(), '.'.join(x for x in stack if x)))
    return spans


def ns_at(spans, pos):
    cur = ''
    for start, name in spans:
        if start <= pos:
            cur = name
        else:
            break
    return cur


def build_index():
    """declared bare name -> set of (kind, module, qualname, namespace)."""
    idx = collections.defaultdict(set)
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
            spans = namespace_spans(txt)
            for m in DECL.finditer(txt):
                bare = m.group(1)
                ns = ns_at(spans, m.start())
                base = bare.split('.')[-1]
                qual = f'{ns}.{bare}' if ns else bare
                idx[base].add((kind, mod, qual, ns))
    return idx


def opens_ns(lines, ns):
    """True if a plain `open` line exposes `ns`'s contents as bare names.

    Only an EXACT match counts: `open A.B` makes `A.B.c` usable as `c`, while
    `open A` only reduces it to `B.c`.  `open ... in` scopes to the next
    command and `open scoped` is a different keyword, so both are ignored.
    """
    if not ns:
        return True
    for l in lines:
        if not l.startswith('open '):
            continue
        body = l[5:].split('--')[0].strip()
        if body.endswith(' in') or body.startswith('scoped'):
            continue
        for tok in re.split(r'[\s,]+', body):
            if tok in ('scoped', 'in') or not tok:
                continue
            if tok == ns:
                return True
    return False


def imports_mod(lines, mod):
    return any(l.strip() == f'import {mod}' for l in lines)


def main():
    dry = '--dry-run' in sys.argv
    show = '--show' in sys.argv
    idx = build_index()
    verdicts = json.load(
        open(os.path.join(WS, 'state/offline_pending_check.json'), encoding='utf-8')
    ).get('sol', {}).get('items', {})
    ledger = json.load(open(os.path.join(WS, 'state/pipeline.json'),
                            encoding='utf-8'))['items']

    sols = [l.strip() for l in open('/tmp/fixq_miss-ident.txt', encoding='utf-8')
            if l.strip()]
    buckets = collections.defaultdict(list)

    for sol in sols:
        path = os.path.join(WS, 'Solutions', f'Sol_{sol}.lean')
        if not os.path.exists(path):
            buckets['no-local-file'].append((sol, []))
            continue
        lines = open(path, encoding='utf-8').read().split('\n')
        idents = list(dict.fromkeys(MISS.findall(verdicts.get(sol, ''))))
        if not idents:
            buckets['unparsed'].append((sol, []))
            continue

        add_imports, add_opens, notes, blocked = [], [], [], False
        for ident in idents:
            base = ident.split('.')[-1]
            cands = idx.get(base, set())
            # keep only candidates whose qualname actually matches the ident
            cands = {c for c in cands
                     if c[2] == ident or c[2].endswith('.' + ident)
                     or c[2].split('.')[-1] == ident}
            if not cands:
                blocked = True
                notes.append(f'{ident}: not-found')
                continue
            if len({m for _, m, _, _ in cands}) > 1:
                blocked = True
                notes.append(f'{ident}: ambiguous -> '
                             f'{sorted({m for _, m, _, _ in cands})[:3]}')
                continue
            kind, mod, qual, ns = next(iter(cands))
            # The namespace that must be `open`ed is the qualifier of the
            # RESOLVED name.  A decl written fully qualified
            # (`theorem A.B.c`) sits in no `namespace` block, so `ns` from the
            # block scan is empty -- deriving it from `qual` covers both.
            root_ns = qual.rsplit('.', 1)[0] if '.' in qual else ''
            # rule: never depend on the sol's own target theorem
            if mod.split('.', 1)[1][4:] == sol:
                blocked = True
                notes.append(f'{ident}: own target {mod}')
                continue
            key = (f'def:{mod.split(".", 1)[1]}' if kind == 'def'
                   else f'thm:{mod.split(".", 1)[1][4:]}')
            if ledger.get(key, {}).get('status') != 'done':
                blocked = True
                notes.append(f'{ident}: {mod} not published')
                continue
            have_import = imports_mod(lines, mod)
            have_open = opens_ns(lines, root_ns)
            if not have_import:
                add_imports.append(mod)
            if root_ns and not have_open:
                add_opens.append(root_ns)
            notes.append(f'{ident}: {qual} [{kind}] '
                         f'import={"+" if not have_import else "ok"} '
                         f'open={"+" if (root_ns and not have_open) else "ok"}')

        if blocked:
            cls = 'blocked'
        elif add_imports and add_opens:
            cls = 'import+open'
        elif add_imports:
            cls = 'need-import'
        elif add_opens:
            cls = 'need-open'
        else:
            cls = 'in-scope-already'   # identifier IS in scope; verdict stale
        buckets[cls].append((sol, notes, sorted(set(add_imports)),
                             sorted(set(add_opens)), path, lines))

    for cls in sorted(buckets, key=lambda c: -len(buckets[c])):
        with open(f'/tmp/fo_{cls}.txt', 'w') as f:
            f.writelines(e[0] + '\n' for e in buckets[cls])
        print(f'{cls:20s} {len(buckets[cls]):4d}   -> /tmp/fo_{cls}.txt')

    if show:
        for cls in buckets:
            for e in buckets[cls][:4]:
                if cls in ('need-open', 'need-import', 'import+open',
                           'in-scope-already'):
                    print(f'\n{e[0]}  [{cls}]')
                    for n in e[1]:
                        print(f'    {n}')

    # apply only the fixable classes
    editable = ('need-open', 'need-import', 'import+open')
    applied = 0
    for cls in editable:
        for sol, notes, imps, ops, path, lines in buckets[cls]:
            if not imps and not ops:
                continue
            if dry:
                print(f'  DRY  {sol}: +import {imps} +open {ops}')
                applied += 1
                continue
            bak = path + '.bak_openfix'
            if os.path.exists(bak):
                print(f'  KEEP {sol}: backup exists')
                continue
            shutil.copy2(path, bak)
            body = list(lines)
            # `open` only affects declarations that come AFTER it, so it must
            # land with the file's other opens -- never appended at the end.
            if ops:
                last_open = max((i for i, l in enumerate(body)
                                 if l.startswith('open ')), default=-1)
                if last_open < 0:
                    last_import = max((i for i, l in enumerate(body)
                                       if l.startswith('import ')), default=0)
                    last_open = last_import
                body[last_open + 1:last_open + 1] = [f'open {ns}' for ns in ops]
            if imps:
                last_import = max((i for i, l in enumerate(body)
                                   if l.startswith('import ')), default=0)
                body[last_import + 1:last_import + 1] = [f'import {m}'
                                                         for m in imps]
            open(path, 'w', encoding='utf-8').write('\n'.join(body))
            print(f'  EDIT {sol}: +import {imps} +open {ops}')
            applied += 1
    if editable:
        print(f'\n{"would apply" if dry else "applied"}: {applied}')


if __name__ == '__main__':
    main()
