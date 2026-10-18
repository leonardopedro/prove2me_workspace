"""Repair red solutions by syncing their header from the theorem stub.

Every platform-generated solution stub is derived from its theorem stub, and
the failure classes in `state/failed_submissions.json` say the derivation lost
pieces of the header:

  * ``unknown namespace `BookProof.FarisLavine` ``  -> the def-bundle import
    that gives the namespace its name is missing from the sol.
  * ``Unknown identifier `d` ``                    -> the ``variable {d : ℕ}``
    line that binds it is missing (autoImplicit is off server-side).

The theorem stub always carries the correct import set and variable lines for
its statement, so: add the thm's imports the sol lacks (never the target's own
theorem module), and add any thm ``variable`` line that declares an identifier
the server reported as unknown.

Everything this script changes still has to pass `debug/check_sol_local.py`
before it is submitted; the script only repairs headers.

Usage:
  python3 debug/sync_sol_header.py            # dry run: report
  python3 debug/sync_sol_header.py --apply    # edit files
  python3 debug/sync_sol_header.py --only-file list.txt
"""
import json
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def thm_vars(thm_text):
    return [l.rstrip() for l in thm_text.splitlines() if l.startswith('variable ')]


def apply(slug, apply_changes, report):
    sol_p = os.path.join(ROOT, 'Solutions', f'Sol_{slug}.lean')
    thm_p = os.path.join(ROOT, 'Theorems', f'Thm_{slug}.lean')
    if not os.path.exists(sol_p):
        return False
    sol = open(sol_p).read()
    if not os.path.exists(thm_p):
        return False
    thm = open(thm_p).read()

    sol_imports = set(l.strip() for l in sol.splitlines() if l.startswith('import '))
    thm_imports = [l.strip() for l in thm.splitlines() if l.startswith('import ')]
    own = f'import Theorems.Thm_{slug}'
    to_add = [i for i in thm_imports
              if i not in sol_imports and i != own]

    # Unknown identifiers reported for this slug by the platform.
    rec = FAILED.get(slug, {})
    subs = rec.get('submissions', [])
    unknown = []
    if subs:
        msg = max(subs, key=lambda x: x.get('created_at', '')).get('error_message') or ''
        unknown = re.findall(r'Unknown identifier `([^`]+)`', msg)
    bare = [u for u in unknown if u.isidentifier()]
    if not bare:
        # No identifier errors (namespace/import errors only): imports suffice.
        bare = []

    needed_vars = []
    if bare:
        for vline in thm_vars(thm):
            names = re.findall(r'[^\s,{}()]+', vline.split('variable', 1)[1])
            if any(n in bare for n in names):
                if vline.strip() not in [l.strip() for l in sol.splitlines()]:
                    if vline not in sol:
                        needed_vars.append(vline)

    if not to_add and not needed_vars:
        return False

    if apply_changes:
        # 1) imports: after the last existing import line (imports must come first)
        if to_add:
            lines = sol.splitlines(keepends=True)
            last = max(i for i, l in enumerate(lines) if l.startswith('import '))
            indent = re.match(r'\s*', lines[last]).group(0)
            for k, imp in enumerate(to_add, 1):
                lines.insert(last + k, f'{indent}{imp}\n')
            sol = ''.join(lines)
        # 2) variable lines: directly before the set_option / theorem line
        if needed_vars:
            m = re.search(r'^(set_option[^\n]*\n|theorem solution)', sol, re.M)
            if m:
                sol = sol[:m.start()] + '\n'.join(needed_vars) + '\n' + sol[m.start():]
        open(sol_p, 'w').write(sol)
    report.append((slug, to_add, needed_vars))
    return True


if __name__ == '__main__':
    apply_changes = '--apply' in sys.argv
    FAILED = json.load(open(os.path.join(ROOT, 'state', 'failed_submissions.json')))
    only = None
    if '--only-file' in sys.argv:
        i = sys.argv.index('--only-file')
        only = set(l.strip() for l in open(sys.argv[i + 1]) if l.strip())
    report = []
    for slug in sorted(FAILED):
        if only and slug not in only:
            continue
        apply(slug, apply_changes, report)
    n_imp = sum(1 for _, i, v in report if i)
    n_var = sum(1 for _, i, v in report if v)
    print(f'{len(report)} sol(s) need header sync '
          f'({n_imp} import fixes, {n_var} variable fixes)'
          f'{" [APPLIED]" if apply_changes else " [dry run, --apply to write]"}')
    for slug, imps, vars_ in report[:15]:
        print(f'  {slug}')
        for x in imps:
            print(f'      + {x}')
        for x in vars_:
            print(f'      + {x.strip()}')
    if len(report) > 15:
        print(f'  ... and {len(report) - 15} more')
