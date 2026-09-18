import json

with open('state/pipeline.json') as f:
    d = json.load(f)

state = d.get('state', [])
by_kind = {}
for item in state:
    k = item.get('kind', '?')
    by_kind.setdefault(k, []).append(item)

for k, items in by_kind.items():
    done = sum(1 for i in items if i.get('status') in ('done', 'published', 'Proved', 'Open'))
    fail = sum(1 for i in items if i.get('status') == 'failed')
    pend = sum(1 for i in items if i.get('status') in ('pending', 'submitted'))
    print(f'{k}: total={len(items)} done={done} pending={pend} failed={fail}')

failed = [i for i in state if i.get('status') == 'failed']
if failed:
    print('\nFailed items:')
    for f in failed[:10]:
        print(f'  {f.get("kind","?")}:{f.get("slug","?")} err={str(f.get("error",""))[:120]}')

pending_defs = [i for i in state if i.get('kind') == 'def' and i.get('status') in ('pending', 'submitted')]
print(f'\nPending defs: {len(pending_defs)}')
for d in pending_defs[:15]:
    print(f'  {d.get("slug","?")} status={d.get("status","?")} err={str(d.get("error",""))[:80]}')
