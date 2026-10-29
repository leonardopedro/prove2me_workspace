"""audit_chain.py + own-chapter scan."""
import re, sys, os, subprocess
PROJ = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/timepiece331"
def decls(path):
    out = {}
    try: lines = open(path, errors='ignore').read().splitlines()
    except OSError: return out
    for i, l in enumerate(lines, 1):
        m = re.match(r'\s*(?:@\[[^\]]*\]\s*)?(?:protected\s+|private\s+|noncomputable\s+)*(?:theorem|lemma|def|abbrev)\s+([A-Za-z_][\w\'.]*)', l)
        if m: out[m.group(1)] = i
    return out
def imports_of(p):
    try: t = open(p).read()
    except OSError: return []
    return re.findall(r'^import\s+([\w.]+)', t, re.M)
bundle = sys.argv[1]
text = open(bundle, errors='ignore').read()
own_leaf = os.path.basename(bundle).replace('.lean','').replace('Def_','')
own_src = f"{PROJ}/BookProof/{own_leaf}.lean"
# own chapter: missing & referenced & NOT defined in bundle
s, b = decls(own_src), decls(bundle)
for name, ln in sorted(s.items()):
    if name not in b and re.search(r'\b'+re.escape(name)+r'\b', text):
        stub = subprocess.run(['grep','-rl',f'theorem BookProof\\..*\\b'+re.escape(name)+r'\b','Theorems/'],capture_output=True,text=True).stdout.split()
        print(f"OWN-MISSING {name}  src:{ln}  stub={stub[0] if stub else 'NONE'}")
# imported bundles: missing & referenced
imp_mods = [m for m in imports_of(bundle) if m.startswith('Definitions.Def_')]
seen, stack, allb = set(), list(imp_mods), []
while stack:
    m = stack.pop()
    if m in seen: continue
    seen.add(m); allb.append(m)
    stack += [x for x in imports_of(m.replace('.', '/') + '.lean') if x.startswith('Definitions.Def_')]
for m in allb:
    bp = m.replace('.', '/') + '.lean'
    if 'Def_' not in m: continue
    leaf = m.split('Def_',1)[1]
    src = f"{PROJ}/BookProof/{leaf}.lean"
    s, bb = decls(src), decls(bp)
    for name, ln in sorted(s.items()):
        if name not in bb and name not in b and re.search(r'\b'+re.escape(name)+r'\b', text):
            stub = subprocess.run(['grep','-rl',f'theorem BookProof\\..*\\b'+re.escape(name)+r'\b','Theorems/'],capture_output=True,text=True).stdout.split()
            print(f"IMP-MISSING {name}  {leaf}:{ln}  stub={stub[0] if stub else 'NONE'}")
