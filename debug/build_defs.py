"""Build Def_Chapter*.lean definitions in dependency order."""
import os, re, subprocess, sys, time

WS = os.getcwd()
LEAN = '/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean'
PKG_DIR = f'{WS}/.lake/packages'
LEAN_TOOLCHAIN = '/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.33.1/lib/lean'
LEAN_PATH = f'{WS}/.lake/build/lib/lean:{PKG_DIR}/mathlib/.lake/build/lib/lean:{PKG_DIR}/batteries/.lake/build/lib/lean:{PKG_DIR}/Qq/.lake/build/lib/lean:{PKG_DIR}/aesop/.lake/build/lib/lean:{PKG_DIR}/proofwidgets/.lake/build/lib/lean:{PKG_DIR}/importGraph/.lake/build/lib/lean:{PKG_DIR}/LeanSearchClient/.lake/build/lib/lean:{PKG_DIR}/plausible/.lake/build/lib/lean:{LEAN_TOOLCHAIN}'
os.environ['LEAN_PATH'] = LEAN_PATH

LEAN_DIR = f'{WS}/.lake/build/lib/lean/Definitions'
DEF_DIR = f'{WS}/Definitions'

BUILT = 0
FAILED = 0
FAIL_NAMES = []
T0 = time.time()

def parse_imports(path):
    try:
        with open(path) as f:
            content = f.read()
    except OSError:
        return []
    return [m[len('Definitions.'):].replace('.lean', '') for m in re.findall(r'^import\s+(Definitions\.\S+)', content, re.MULTILINE)]

def defs_deps(name, all_defs):
    try:
        imports = parse_imports(f'{DEF_DIR}/{name}.lean')
    except OSError:
        return set()
    return set(imp for imp in imports if imp in all_defs)

def try_compile(name):
    r = subprocess.run([LEAN, f'{DEF_DIR}/{name}.lean'], cwd=WS, capture_output=True, text=True, timeout=180)
    return r.returncode == 0, (r.stderr or r.stdout)[:200]

def log(msg):
    print(f'[{time.time()-T0:.0f}s] {msg}', flush=True)

def main():
    global BUILT, FAILED
    t0 = time.time()
    all_defs = sorted(
        f.replace('.lean', '') for f in os.listdir(DEF_DIR)
        if f.startswith('Def_Chapter') and f.endswith('.lean')
    )
    log(f'Found {len(all_defs)} definitions')

    all_defs_set = set(all_defs)
    graph = {name: defs_deps(name, all_defs_set) for name in all_defs}
    log(f'Parsed imports ({time.time()-t0:.1f}s)')

    built_set = set(name for name in all_defs if os.path.exists(f'{LEAN_DIR}/{name}.olean'))
    log(f'Already built: {len(built_set)}')

    round_num = 0
    max_rounds = 200
    # Track stuck definitions: if the same set of definitions keeps failing, break
    stuck_defs = set()

    while True:
        round_num += 1
        if round_num > max_rounds:
            log(f'Max rounds ({max_rounds}) reached. Stopping.')
            break

        ready = sorted(
            n for n in all_defs
            if n not in built_set and not (graph.get(n, set()) - built_set)
        )

        if not ready:
            stuck = [n for n in all_defs if n not in built_set]
            log(f'Round {round_num}: {len(ready)} ready. {len(stuck)} stuck.')
            for n in stuck[:25]:
                missing = sorted(graph.get(n, set()) - built_set)[:4]
                log(f'  STUCK: {n}  blocked by: {missing}')
            break

        # Check if we're stuck: same definitions failing repeatedly
        new_stuck = set(n for n in ready if n not in built_set)
        if new_stuck == stuck_defs and stuck_defs:
            log(f'Round {round_num}: stuck on same {len(stuck_defs)} definitions. Breaking.')
            break
        stuck_defs = new_stuck

        log(f'Round {round_num}: building {len(ready)} definitions')
        batch_built = 0
        batch_failed = 0
        for name in ready:
            if os.path.exists(f'{LEAN_DIR}/{name}.olean'):
                batch_built += 1
                continue
            ok, err = try_compile(name)
            if ok:
                built_set.add(name)
                BUILT += 1
                batch_built += 1
                log(f'  BUILT {name}')
            else:
                batch_failed += 1
                FAILED += 1
                FAIL_NAMES.append(name)
                log(f'  FAIL {name}: {err}')
        log(f'  Round done: built={batch_built}, failed={batch_failed}')

    log(f'\nDone. Built: {BUILT}, Failed: {FAILED} ({time.time()-T0:.0f}s total)')
    if FAIL_NAMES:
        log('Failed:')
        for n in FAIL_NAMES[:30]:
            log(f'  {n}')

if __name__ == '__main__':
    main()
