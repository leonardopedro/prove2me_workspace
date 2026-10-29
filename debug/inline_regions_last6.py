#!/usr/bin/env python3
"""One-off for the final 6 not-found sols (mi_not-found.txt).

Inlines unpublished source regions VERBATIM into sol files:

* BayesInference  <- timepiece331 BookProof/ChapterJointUnitary.lean
                     (`exists_unitary_column`, `exists_unitary_of_prob`,
                      `exists_unitary_joint`; namespace
                      BookProof.ChapterJointUnitary; needs `open Matrix`)
* G3 mehler_uniform_{isProbability,gauge_invariant,concentrates}
                 <- timepiece331 BookProof/PhysHSGaussian/Part1.lean
                     (gaussianE .. sphereUniform_rotation_invariant;
                      root namespace PhysHSGaussian; needs noncomputable
                      section -- the source file's defs rely on it)

Platform-world rule (see Def_ChapterG3): an unpublished dep cannot be
imported, so the content is copied in.  Each insertion is anchored on the
first `set_option maxHeartbeats` (G3) / the `open scoped BigOperators`
(Bayes) line; dry-run prints the region boundary lines for eyeballing.
"""
import os
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TS = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/timepiece331/BookProof"

APPLY = "--apply" in sys.argv


def lines(path):
    with open(path, encoding="utf-8") as f:
        return f.read().splitlines(keepends=True)


def find(pred, ls, start=0):
    for i in range(start, len(ls)):
        if pred(ls[i]):
            return i
    raise SystemExit("anchor not found")


# ---- region 1: ChapterJointUnitary 51..113 (0-based: 50..113) ----
ju = lines(os.path.join(TS, "ChapterJointUnitary.lean"))
s = find(lambda l: l.startswith("theorem exists_unitary_column "), ju)
e = find(lambda l: "h_unitary.choose_spec.2 ( x, y )" in l, ju)
region_ju = ju[s:e + 1]
print(f"JointUnitary region: lines {s+1}..{e+1} ({len(region_ju)} lines)")
print("  first:", region_ju[0].rstrip())
print("  last: ", region_ju[-1].rstrip())
for bad in ("omit", "variable", "open ", "namespace", "set_option", "section"):
    assert not any(l.startswith(bad) for l in region_ju), f"region_ju contains {bad!r}"

block_bayes = (
    "open Matrix\n"
    "\n"
    "namespace BookProof.ChapterJointUnitary\n"
    "\n"
    "/-- Inlined from the unpublished `ChapterJointUnitary` bundle\n"
    "(platform-world rule: an unpublished dep cannot be imported). -/\n"
    "variable {ι : Type*} [Fintype ι] [DecidableEq ι]\n"
    "\n"
    + "".join(region_ju)
    + "\n"
    "end BookProof.ChapterJointUnitary\n"
    "\n"
)

# ---- region 2: PhysHSGaussian/Part1  (gaussianE comment .. end-1) ----
p1 = lines(os.path.join(TS, "PhysHSGaussian", "Part1.lean"))
g = find(lambda l: l.startswith("def gaussianE "), p1)
assert p1[g - 1].startswith("/-- Standard Gaussian"), p1[g - 1]
en = find(lambda l: l.startswith("end PhysHSGaussian"), p1, g)
region_p1 = p1[g - 1:en]
print(f"PhysHSGaussian region: lines {g}..{en} ({len(region_p1)} lines)")
print("  first:", region_p1[0].rstrip())
print("  last: ", region_p1[-1].rstrip())
for bad in ("omit", "variable", "open ", "namespace", "set_option", "section"):
    assert not any(l.startswith(bad) for l in region_p1), f"region_p1 contains {bad!r}"

block_g3 = (
    "noncomputable section\n"
    "\n"
    "namespace PhysHSGaussian\n"
    "\n"
    "/-- Inlined from the unpublished `PhysHSGaussian` bundle (platform-world rule:\n"
    "an unpublished dep cannot be imported). -/\n"
    + "".join(region_p1)
    + "\n"
    "end PhysHSGaussian\n"
    "\n"
    "end\n"
    "\n"
)


def insert(path, anchor, block, after=True):
    p = os.path.join(WS, path)
    txt = open(p, encoding="utf-8").read()
    if "Inlined from the unpublished" in txt:
        print(f"SKIP (already inlined): {path}")
        return
    i = txt.find(anchor)
    assert i >= 0, f"anchor not found in {path}: {anchor!r}"
    assert txt.find(anchor, i + 1) < 0, f"anchor ambiguous in {path}"
    cut = i + len(anchor) if after else i
    new = txt[:cut] + block + txt[cut:]
    print(("APPLIED " if APPLY else "would apply ") + path)
    if APPLY:
        open(p, "w", encoding="utf-8").write(new)


insert(
    "Solutions/Sol_BookProof_ChapterBayesInference_exists_unitary_reproduces_posterior.lean",
    "open scoped BigOperators\n",
    block_bayes,
    after=True,
)

G3 = "set_option maxHeartbeats 1000000 in\n"
for slug in (
    "BookProof_ChapterG3_mehler_uniform_isProbability",
    "BookProof_ChapterG3_mehler_uniform_gauge_invariant",
    "BookProof_ChapterG3_mehler_uniform_concentrates",
):
    insert(f"Solutions/Sol_{slug}.lean", G3, block_g3, after=False)
