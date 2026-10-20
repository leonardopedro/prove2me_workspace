#!/usr/bin/env python3
"""Insert the missing `import Theorems.Thm_...` lines into sols whose only
defect is a dropped sibling import.

Input: /tmp/mi_FIXABLE-import.txt (written by `debug/resolve_miss_ident.py`) —
sol slugs whose missing identifiers all resolve to exactly one local module
each, every one of them already PUBLISHED.  For each sol we recompute the
needed modules, enforce two safety rules, then insert the import lines after
the file's last existing `import` line.

Safety rules (both hard stops, see SKILL.md "three basic rules"):

1. **never import your own target theorem** — `import Theorems.Thm_<slug>` is
   rejected because the target is a `sorry` stub; skip the sol entirely if the
   recomputed need set contains it;
2. **never duplicate an import** — a module already imported is not re-added.

Each edited file is first copied to `Solutions/Sol_<slug>.lean.bak_importfix`;
a file that already has that backup is left untouched, so re-runs are
idempotent.

Usage: python3 debug/add_missing_imports.py [--dry-run]
"""
import json
import os
import shutil
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, 'debug'))

import resolve_miss_ident as R  # noqa: E402

LIST = '/tmp/mi_FIXABLE-import.txt'


def needed_imports(sol, idx, verdict):
    """Modules declaring every identifier the verdict says is unknown."""
    mods = set()
    for ident in dict.fromkeys(R.MISS.findall(verdict)):
        cands = set()
        for k in idx:
            if k == ident or k.endswith('.' + ident):
                cands |= idx[k]
        for _kind, mod in cands:
            mods.add(mod)
    return sorted(mods)


def with_imports(lines, mods):
    """Return (new_lines, added). Imports not already present are inserted
    directly after the file's last existing import line."""
    present = {p for l in lines if l.startswith('import ')
               for p in l.split()[1:2]}
    todo = [m for m in mods if m not in present]
    if not todo:
        return list(lines), []
    last = max((i for i, l in enumerate(lines) if l.startswith('import ')),
               default=0)
    out = list(lines)
    out[last + 1:last + 1] = [f'import {m}' for m in todo]
    return out, todo


def main():
    dry = '--dry-run' in sys.argv
    idx = R.build_index()
    verdicts = json.load(
        open(os.path.join(WS, 'state/offline_pending_check.json'), encoding='utf-8')
    ).get('sol', {}).get('items', {})

    edited = skipped = already = 0
    sols = [l.strip() for l in open(LIST, encoding='utf-8') if l.strip()]
    for sol in sols:
        path = os.path.join(WS, 'Solutions', f'Sol_{sol}.lean')
        if not os.path.exists(path):
            print(f'  SKIP {sol}: no local file')
            skipped += 1
            continue
        bak = path + '.bak_importfix'
        if os.path.exists(bak):
            print(f'  KEEP {sol}: backup already exists (idempotent)')
            already += 1
            continue
        mods = needed_imports(sol, idx, verdicts.get(sol, ''))
        own = [m for m in mods if m.split('.', 1)[1][4:] == sol]
        if own:
            print(f'  SKIP {sol}: would import its OWN target {own}')
            skipped += 1
            continue
        original = open(path, encoding='utf-8').read()
        lines = original.split('\n')
        new_lines, added = with_imports(lines, mods)
        if not added:
            print(f'  KEEP {sol}: all imports already present')
            already += 1
            continue
        if dry:
            print(f'  DRY  {sol}: would add {added}')
        else:
            shutil.copy2(path, bak)
            open(path, 'w', encoding='utf-8').write('\n'.join(new_lines))
            print(f'  EDIT {sol}: + {added}')
        edited += 1
    print(f'\n{"would edit" if dry else "edited"}={edited} '
          f'already-clean={already} skipped={skipped}')


if __name__ == '__main__':
    main()
