import json

st = json.load(open('state/pipeline.json'))
targets = [
    'sol:BookProof_ChapterSirkDiffusiveDecay_hasDerivAt_heatFlow_normSq',
    'sol:BookProof_ChapterSirkDiffusiveDecay_norm_heatFlow_apply_le',
]
for k in targets:
    if k in st['items']:
        st['items'][k] = {'status': 'pending', 'attempts': 0}
        print('reset', k)
    else:
        print('missing', k)
json.dump(st, open('state/pipeline.json', 'w'), indent=1)
from collections import Counter
print(Counter(i.get('status') for i in st['items'].values()))