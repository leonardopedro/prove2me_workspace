#!/usr/bin/env python3
"""Measure which declarations each published def bundle is MISSING, and emit a
bottom-up publish order.

§2.67: ledger status `done` is *not* evidence a body is complete -- 71 defs in
the closure of the 7 empty ones are stored with fewer declarations than the
local source, and that silently breaks every downstream bundle that references
a missing name.

For each definition this reports:

  health    OK       published body has >= the local declarations
            PARTIAL  published, but missing >= 1 declaration the local source has
            MISSING  never published (no def node / no mirror copy)
  missing   the qualified names present locally but not in the published body
  level     0 = every import is OK (can be published/recovered right now),
            else 1 + max(level of its unhealthy imports)

Level is the work queue: recover level 0, re-run, level 1 becomes level 0.

Usage:
  python3 debug/def_body_delta.py                 # closure of the 7 empty defs
  python3 debug/def_body_delta.py --all           # every local definition
  python3 debug/def_body_delta.py --only NAME ... # specific definitions
  python3 debug/def_body_delta.py --wave 0        # just the ready set
  python3 debug/def_body_delta.py --show NAME     # the missing names
"""
import collections
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MIRROR = os.environ.get('DEF_MIRROR', '/tmp/published_mirror')

SEVEN = ["ChapterCarlemanSimplex", "ChapterCarlemanTwoStep",
         "ChapterFockWeightedSchurEsa", "ChapterQgBrstDerivativeGauge",
         "ChapterModeQuadraticEsa", "ChapterQgTimeIndependentFlow",
         "ChapterGradedBandSchurEsa"]

DECL = re.compile(
    r'^\s*(?:@\[[^\]]*\]\s*)?(?:protected\s+|noncomputable\s+|private\s+)?'
    r'(?:def|theorem|lemma|abbrev|structure|inductive|class|instance)\s+'
    r"([A-Za-z0-9_.'\u1d4a-\u1d7f]+)", re.M)
IMPORT = re.compile(r'^\s*import\s+Definitions\.Def_([A-Za-z0-9_]+)', re.M)
NAMESPACE = re.compile(r'^namespace\s+([A-Za-z0-9_.\']+)', re.M)


def decls(text):
    """Qualified declaration names, resolving enclosing namespace blocks."""
    spans, stack, out = [], [], set()
    for m in re.finditer(r'^(namespace|end)\b\s*([A-Za-z0-9_.\']+)?', text, re.M):
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

    for m in DECL.finditer(text):
        bare = m.group(1)
        ns = ns_at(m.start())
        out.add(f'{ns}.{bare}' if ns and '.' not in bare else bare)
    return out


def read(path):
    try:
        return open(path, encoding='utf-8', errors='ignore').read()
    except OSError:
        return None


def closure(roots):
    seen, stack = set(), list(roots)
    while stack:
        n = stack.pop()
        if n in seen:
            continue
        seen.add(n)
        p = f'{WS}/Definitions/Def_{n}.lean'
        t = read(p)
        if t:
            stack.extend(IMPORT.findall(t))
    return seen


def main():
    argv = sys.argv[1:]
    names = closure(SEVEN)
    if '--all' in argv:
        names = {f[4:-5] for f in os.listdir(f'{WS}/Definitions')
                 if f.startswith('Def_') and f.endswith('.lean')}
    if '--only' in argv:
        names = set(argv[argv.index('--only') + 1:])

    ledger = json.load(open(f'{WS}/state/pipeline.json'))['items']
    info = {}
    for n in sorted(names):
        local = read(f'{WS}/Definitions/Def_{n}.lean')
        pub = read(f'{MIRROR}/Definitions/Def_{n}.lean')
        if local is None:
            health, missing, imps = 'no-local', set(), []
            ld = set()
        else:
            ld = decls(local)
            imps = IMPORT.findall(local)
            if ledger.get(f'def:{n}', {}).get('status') != 'done' or pub is None:
                health = 'MISSING'
                missing = set(ld)
            else:
                missing = ld - decls(pub)
                health = 'PARTIAL' if missing else 'OK'
        info[n] = {'health': health, 'missing': missing,
                   'imports': imps, 'local_n': len(ld)}

    # levels: a node is ready when every import is OK (unknown-out-of-closure
    # imports are treated as OK, they are outside this recovery's scope)
    level, changed = {}, True
    while changed:
        changed = False
        for n, d in info.items():
            if n in level:
                continue
            deps = [x for x in d['imports'] if x in info]
            if all(info[x]['health'] == 'OK' or x in level for x in deps):
                level[n] = 0 if not deps or all(
                    info[x]['health'] == 'OK' for x in deps) else \
                    1 + max(level.get(x, 0) for x in deps
                            if info[x]['health'] != 'OK')
                changed = True

    c = collections.Counter(d['health'] for d in info.values())
    print(f'closure {len(info)}:  OK={c["OK"]} PARTIAL={c["PARTIAL"]} '
          f'MISSING={c["MISSING"]}')

    if '--show' in argv:
        for n in argv[argv.index('--show') + 1:]:
            d = info.get(n)
            if not d:
                print(f'{n}: not in set')
                continue
            print(f'\n{n}  [{d["health"]}] local decls={d["local_n"]} '
                  f'missing={len(d["missing"])}')
            for m in sorted(d['missing'])[:40]:
                print(f'    {m}')
            if len(d['missing']) > 40:
                print(f'    ... +{len(d["missing"]) - 40} more')
        return 0

    ready = sorted(n for n, d in info.items() if d['health'] != 'OK'
                   and level.get(n) == 0)
    print(f'\nready now (level 0, needs recovery): {len(ready)}')
    for n in ready:
        print(f'    {n:46s} {info[n]["health"]} '
              f'missing={len(info[n]["missing"])}')

    blocked = [(n, level.get(n, -1)) for n, d in info.items()
               if d['health'] != 'OK' and level.get(n, -1) != 0]
    blocked.sort(key=lambda x: x[1])
    print(f'\nblocked on upstream: {len(blocked)} (smallest levels first)')
    for n, lv in blocked[:25]:
        print(f'    L{lv} {n}')

    out = {n: {'health': d['health'], 'level': level.get(n),
               'missing': sorted(d['missing'])}
           for n, d in info.items()}
    json.dump(out, open('/tmp/def_body_delta.json', 'w'), indent=1)
    print('\nwrote /tmp/def_body_delta.json')
    return 0


if __name__ == '__main__':
    sys.exit(main())
