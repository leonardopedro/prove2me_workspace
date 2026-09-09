import json
import re
import glob

# All identifiers used in SirkPerSystem thm statements
ids = set()
for p in glob.glob('Theorems/Thm_BookProof_ChapterSirkPerSystem_*.lean'):
    txt = open(p).read()
    m = re.search(r'\ntheorem ', txt)
    stmt = txt[m.start():] if m else ''
    for tok in re.findall(r"[A-Za-z][A-Za-z0-9_']*", stmt):
        if len(tok) >= 3:
            ids.add(tok)
STOP = {'theorem', 'by', 'sorry', 'open', 'import', 'Mathlib', 'Definitions', 'and', 'or',
        'not', 'exists', 'for', 'all', 'in', 'at', 'with', 'have', 'show', 'let', 'fun',
        'if', 'then', 'else', 'this', 'from', 'using', 'exact', 'simp', 'rw', 'as',
        'BookProof', 'ChapterSirkPerSystem', 'namespace', 'noncomputable', 'section',
        'variable', 'Type', 'Prop', 'u', 'v', 'w', 'end', 'def', 'structure', 'instance',
        'class', 'where', 'extends', 'lean', 'set_option', 'maxHeartbeats', 'true',
        'false', 'Submodule', 'ContinuousLinearMap', 'HasDerivAt', 'Exp', 'IsBounded'}
ids -= STOP
print(len(ids), 'statement identifiers')

# Map each to its defining chapter via the decl graph
g = {}
with open('/home/leo/Projects/timepiece/decl_graph.jsonl') as f:
    for line in f:
        r = json.loads(line)
        un = r['userName']
        short = un.split('.')[-1]
        g.setdefault(short, r['module'])
found = {}
for i in ids:
    if i in g:
        found.setdefault(g[i], []).append(i)
print('resolved to chapters:')
for mod in sorted(found):
    print('  %s: %s' % (mod, sorted(found[mod])))
unres = ids - set(g)
print('unresolved:', sorted(unres)[:30])