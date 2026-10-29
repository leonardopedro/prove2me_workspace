"""For a failing bundle: find every source-chapter decl it references that its
imported bundles don't provide, classifying each as STALE (bundle has it ->
just regate host) or MISSING (-> needs Thm stub import)."""
import re, sys, os, subprocess
PROJ = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/timepiece331"
def decls(path):
    out = {}
    try: lines = open(path, errors='ignore').read().splitlines()
    except OSError: return out
    for i, l in enumerate(lines, 1):
        m = re.match(r'\s*(?:@\[[^\]]*\]\s*)?(?:protected\s+|private\s+|noncomputable\s+)*(?:theorem|lemma|def|abbrev)\s+([A-Za-z_][\w\'.]*)', l)
        if m: out[m.group(1)] = (path, i)
    return out
def imports_of(p):
    try: t = open(p).read()
    except OSError: return []
    return re.findall(r'^import\s+([\w.]+)', t, re.M)
bundle = sys.argv[1]                    # e.g. Definitions/Def_ChapterHermiteGalerkinFriedrichs.lean
text = open(bundle, errors='ignore').read()
imp_mods = [m for m in imports_of(bundle) if m.startswith('Definitions.Def_')]
# gather decls of every imported bundle + their transitive source chapters
seen, stack, allb = set(), list(imp_mods), []
while stack:
    m = stack.pop()
    if m in seen: continue
    seen.add(m)
    allb.append(m)
    stack += [x for x in imports_of(m.replace('.', '/') + '.lean') if x.startswith('Definitions.Def_')]
# for each bundle, also consider the source chapter decls (missing ones)
missing, stale = {}, {}
for m in allb:
    bp = m.replace('.', '/') + '.lean'
    leaf = m.split('Def_',1)[1] if 'Def_' in m else None
    if not leaf: continue
    src = f"{PROJ}/BookProof/{leaf}.lean"
    s, b = decls(src), decls(bp)
    for name in s:
        if name not in b and re.search(r'\b' + re.escape(name) + r'\b', text):
            missing.setdefault(name, (src, s[name][1], bp))
for name, (src, ln, bp) in sorted(missing.items()):
    # is there a Thm stub declaring it?
    stub = subprocess.run(['grep','-rl',f'theorem BookProof\\..*\\b'+re.escape(name)+r'\b','Theorems/'],capture_output=True,text=True).stdout.split()
    stubs = [s for s in stub if s.endswith('.lean')]
    print(f"MISSING {name}  src={os.path.basename(src)}:{ln}  stub={stubs[0] if stubs else 'NONE'}")
print(f"TOTAL missing {len(missing)}   bundles scanned {len(allb)}")
