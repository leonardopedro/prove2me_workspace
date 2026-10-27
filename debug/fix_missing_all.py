#!/usr/bin/env python3
"""Iteratively clear every `Unknown identifier` a def bundle reports.

check_def_local stops at the FIRST error, so a bundle with N missing
cross-bundle references costs N compiles and N manual rounds.  This captures the
compiler's FULL output, harvests every `Unknown identifier \`X\`` at once (from
the bundle AND from any Thm stub it pulls in), resolves each to its defining
module, adds the import/open, and recompiles -- repeating until the bundle
compiles or no progress is made.

Resolution mirrors debug/fix_next_missing.py: a theorem declared by BOTH its
Def bundle and its Thm stub is taken from the STUB, because the platform
publishes a defs-only projection of each bundle (theorems stripped), which is
precisely why the identifier went missing in the staged mirror.

Usage:
  python3 debug/fix_missing_all.py ChapterFoo [ChapterBar ...] [--rounds N]
"""
import collections
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
sys.path.insert(0, HERE)

import check_pending_offline as cpo  # noqa: E402

DECL = re.compile(
    r'^\s*(?:@\[[^\]]*\]\s*)?(?:protected\s+|noncomputable\s+|private\s+)?'
    r'(?:def|theorem|lemma|abbrev|structure|inductive|class|instance)\s+'
    r"([A-Za-z0-9_.\'\u1d4a-\u1d7f\u2070-\u209f]+)",
    re.M)
MISS = re.compile(r"Unknown identifier [`'\"]([^`'\"\s]+)[`'\"]")
#  .../Definitions/Def_Foo.lean:12:3: error...
SRCFILE = re.compile(r"([A-Za-z0-9_/.]+/(?:Definitions|Theorems)/[A-Za-z0-9_]+\.lean)")


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
    out, seen = [], set()
    for k, v in idx.items():
        if k == ident or k.endswith('.' + ident):
            for kind, mod, ns in v:
                if (kind, mod) not in seen:
                    seen.add((kind, mod))
                    out.append((kind, mod, ns))
    return out


def pick(cands):
    """Prefer the Thm stub (see module docstring); else the unique Def bundle."""
    if len(cands) == 1:
        return cands[0]
    thms = [c for c in cands if c[0] == 'thm']
    defs = [c for c in cands if c[0] == 'def']
    if len(thms) == 1:
        return thms[0]
    if len(defs) == 1:
        return defs[0]
    return None


def add_import_open(path, mod, decl_ns):
    """Insert `import mod` and (if needed) `open decl_ns`. True if changed."""
    txt = open(path, encoding='utf-8').read()
    orig = txt
    imp = f'import {mod}'
    if imp + '\n' not in txt:
        lines = txt.split('\n')
        if not any(l.startswith('import ') for l in lines):
            return False
        last_imp = max(i for i, l in enumerate(lines) if l.startswith('import '))
        lines.insert(last_imp + 1, imp)
        txt = '\n'.join(lines)
    if decl_ns:
        fm = re.search(r'^namespace (\S+)', txt, re.M)
        own = fm.group(1) if fm else ''
        covered = (own == decl_ns) or any(
            re.search(r'\b' + re.escape(decl_ns) + r'\b', o.group(0))
            for o in re.finditer(r'^open[^\n]*$', txt, re.M))
        if not covered:
            nm = re.search(r'^namespace \S[^\n]*\n', txt, re.M)
            if nm:
                txt = txt[:nm.end()] + f'open {decl_ns}\n' + txt[nm.end():]
            else:
                txt = f'open {decl_ns}\n' + txt
    if txt != orig:
        open(path, 'w', encoding='utf-8').write(txt)
        return True
    return False


def link_mirror_oleans(scratch):
    for sub in ('Theorems', 'Definitions'):
        os.makedirs(os.path.join(scratch, sub), exist_ok=True)
        src = os.path.join(cpo.MIRROR, sub)
        if not os.path.isdir(src):
            continue
        for ent in os.listdir(src):
            if ent.endswith('.olean'):
                dst = os.path.join(scratch, sub, ent)
                if not os.path.lexists(dst):
                    os.symlink(os.path.join(src, ent), dst)


def compile_full(lean, env, scratch, src, sub):
    base = os.path.basename(src)
    dst = os.path.join(scratch, sub, base)
    shutil.copy2(src, dst)
    olean = os.path.join(scratch, sub, base[:-5] + '.olean')
    if os.path.exists(olean) and not os.path.islink(olean):
        os.remove(olean)
    r = subprocess.run([lean, '-DautoImplicit=false', '-o', olean, dst],
                       cwd=scratch, env=env, capture_output=True, text=True,
                       timeout=900)
    return r.returncode == 0, (r.stdout + r.stderr)


def harvest(output, idx, target_path):
    """(ident, module, namespace, file_to_patch) tuples from full compiler output."""
    jobs, unresolved = [], []
    # map an on-disk file path to the module name we should import for it
    for line in output.splitlines():
        if 'Unknown identifier' not in line:
            continue
        m = MISS.search(line)
        if not m:
            continue
        ident = m.group(1)
        cands = resolve(idx, ident)
        chosen = pick(cands) if cands else None
        if chosen is None:
            unresolved.append(ident)
            continue
        # which file to patch: the file the error points at (bundle OR stub)
        fm = SRCFILE.search(line)
        if fm:
            srcfile = fm.group(1)
        else:
            srcfile = target_path
        # only patch files inside this workspace
        if not os.path.isabs(srcfile):
            srcfile = os.path.join('/' + srcfile.lstrip('/'))
        jobs.append((ident, chosen[1], chosen[2], srcfile))
    return jobs, unresolved


def main():
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    rounds = 6
    if '--rounds' in sys.argv:
        rounds = int(sys.argv[sys.argv.index('--rounds') + 1])
    if not args:
        print(__doc__)
        return 2
    lean, env_path = cpo.lean_env()
    if not lean:
        print('could not read the Lean environment from `lake env`')
        return 2
    env = dict(os.environ)
    idx = build_index()
    results = {}
    for ch in args:
        path = os.path.join(WS, 'Definitions', f'Def_{ch}.lean')
        if not os.path.exists(path):
            print(f'  MISSING Def_{ch}')
            results[ch] = 'missing'
            continue
        for rnd in range(1, rounds + 1):
            scratch = tempfile.mkdtemp(prefix='defiter-')
            try:
                link_mirror_oleans(scratch)
                env['LEAN_PATH'] = scratch + ':' + env_path
                # make sure the bundle's Thm imports have oleans
                text = open(path, encoding='utf-8').read()
                for mod in re.findall(r'^\s*import\s+(Theorems\.\S+)', text, re.M):
                    name = mod.split('.', 1)[1]
                    olean = os.path.join(scratch, 'Theorems', name + '.olean')
                    if os.path.lexists(olean) and not os.path.islink(olean):
                        continue
                    stub = os.path.join(WS, 'Theorems', name + '.lean')
                    if not os.path.exists(stub):
                        continue
                    if os.path.lexists(olean):
                        os.remove(olean)
                    ok, out = compile_full(lean, env, scratch, stub, 'Theorems')
                    if not ok:
                        # patch the STUB itself for its own missing idents
                        jobs, _ = harvest(out, idx, stub)
                        changed = False
                        for ident, mod, ns, srcfile in jobs:
                            f = srcfile if srcfile.startswith(WS) else stub
                            if os.path.exists(f) and add_import_open(f, mod, ns):
                                print(f'    r{rnd} stub {os.path.basename(stub)}: +{ident} from {mod}')
                                changed = True
                        if changed:
                            ok, out = compile_full(lean, env, scratch, stub, 'Theorems')
                        if not ok:
                            first = next((l for l in out.splitlines() if 'error' in l), '')
                            print(f'    r{rnd} stub {os.path.basename(stub)} still FAIL: {first[:120]}')
                ok, out = compile_full(lean, env, scratch, path, 'Definitions')
            finally:
                shutil.rmtree(scratch, ignore_errors=True)
            if ok:
                print(f'  OK   Def_{ch}  (round {rnd})')
                results[ch] = 'OK'
                break
            jobs, unresolved = harvest(out, idx, path)
            if not jobs:
                first = next((l for l in out.splitlines() if 'error' in l), '')
                print(f'  FAIL Def_{ch}: no auto-fixable unknown idents')
                print(f'        {first[:200]}')
                if unresolved:
                    print(f'        undeclared locally: {sorted(set(unresolved))}')
                results[ch] = 'manual'
                break
            changed = False
            seen = set()
            for ident, mod, ns, srcfile in jobs:
                f = srcfile if srcfile.startswith(WS) else path
                key = (f, mod)
                if key in seen or not os.path.exists(f):
                    continue
                seen.add(key)
                if add_import_open(f, mod, ns):
                    print(f'    r{rnd} Def_{ch}: +{ident} from {mod}')
                    changed = True
            if not changed:
                print(f'  FAIL Def_{ch}: made no progress')
                print('        ' + next((l for l in out.splitlines() if 'error' in l), '')[:200])
                results[ch] = 'stuck'
                break
        else:
            results[ch] = 'rounds-exhausted'
    ok = sum(1 for v in results.values() if v == 'OK')
    print(f'\n{ok}/{len(results)} bundle(s) now compile')
    for ch, v in results.items():
        if v != 'OK':
            print(f'  {v:16s} {ch}')
    return 0 if ok == len(results) else 1


if __name__ == '__main__':
    sys.exit(main())
