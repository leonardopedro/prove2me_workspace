#!/usr/bin/env python3
"""One-shot surgery on Definitions/Def_ChapterStoneConverse.lean.

1. Insert `open BookProof.ChapterContinuityUnitaryInfinite (L2Z LinfZ summable_normSq norm_sq_eq_tsum)`
   after the `open Filter Topology MeasureTheory` line.
2. Inject the mulDomain/mulOp/adjointDomain helper block (copied from
   BookProof/ChapterUnboundedPosition.lean lines 62..193) right after the
   `variable {H ...}` line, inside namespace BookProof.ChapterStoneMeasurable.
3. Delete duplicated block A' = [norm_sq_eq_tsum .. line before the
   "/-- **The maximal multiplication operator ..." doc].
4. Delete duplicated fragment #1 = [first `def IsSelfAdjointOn` .. line before
   the first `def IsSymmetricOn`] (keeps the UnitaryTransport header).
5. Delete the 3rd copy of memℓp_two_of_summable = [its `Cross-chapter ...
   ContinuityUnitaryInfinite` header .. line before `theorem hasDerivAt_inner_right`].
6. Qualify the 2-argument adjointDomain uses as BookProof.ChapterUnitaryTransport.adjointDomain
   and de-qualify the 1-argument RHS in adjointDomain_mulOp.
"""
import sys

SC = "Definitions/Def_ChapterStoneConverse.lean"
SRC = "BookProof/ChapterUnboundedPosition.lean"

lines = open(SC, encoding="utf-8").read().split("\n")  # 0-based list; line N (1-based) = lines[N-1]
src = open(SRC, encoding="utf-8").read().split("\n")

def find(pred, start=0):
    return [i for i in range(start, len(lines)) if pred(lines[i])]

def one(cands, what):
    assert len(cands) == 1, f"{what}: expected 1 match, got {cands}"
    return cands[0]

# ---- anchors (0-based) ----
open_line = one(find(lambda l: l == "open Filter Topology MeasureTheory"), "top open line")
varH_line = one(find(lambda l: l.startswith("variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace")), "variable H")
assert lines[open_line + 1] == "" and lines[open_line + 2] == "namespace BookProof.ChapterStoneMeasurable"

normsq_start = one(find(lambda l: l.startswith("theorem norm_sq_eq_tsum (f : L2Z)")), "norm_sq_eq_tsum")
maxdoc = one(find(lambda l: "**The maximal multiplication operator is self-adjoint**" in l), "maximal doc")
D3 = (normsq_start, maxdoc - 1)  # inclusive range: everything before the doc (drops A' + dangling {phi line)

isself_cands = find(lambda l: l == "def IsSelfAdjointOn (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Prop :=")
assert len(isself_cands) == 2, isself_cands
isself_first = min(isself_cands)
issym_first = min(find(lambda l: l.startswith("def IsSymmetricOn (D : Submodule ℂ H)")))
assert isself_first < issym_first
D2 = (isself_first, issym_first - 1)  # drops frag1 incl. its mid opens; keeps UnitaryTransport header at isself_first-1

headers = find(lambda l: l == "/-! ## Cross-chapter definitions from `BookProof.ChapterContinuityUnitaryInfinite` -/")
assert len(headers) == 2, headers
third_hdr = headers[1]
hasderiv = one(find(lambda l: l.startswith("theorem hasDerivAt_inner_right")), "hasDerivAt_inner_right")
assert third_hdr < hasderiv
D1 = (third_hdr, hasderiv - 1)  # 3rd memℓp_two copy + its header

# ---- replacements (line no -> new line), only outside deletion ranges ----
def in_del(idx):
    return any(a <= idx <= b for a, b in (D1, D2, D3))

R = {}
for i in find(lambda l: l == "  adjointDomain D A = (D : Set H)"):
    if not in_del(i):
        R[i] = "  BookProof.ChapterUnitaryTransport.adjointDomain D A = (D : Set H)"
for i in find(lambda l: "adjointDomain (transportDomain W D) (transportOp W D A) = W '' adjointDomain D A" in l):
    if not in_del(i):
        R[i] = lines[i].replace("adjointDomain (transportDomain W D)",
                         "BookProof.ChapterUnitaryTransport.adjointDomain (transportDomain W D)") \
                .replace("= W '' adjointDomain D A", "= W '' BookProof.ChapterUnitaryTransport.adjointDomain D A")
        R[i] = R[i].replace("    adjointDomain (transport", "    BookProof.ChapterUnitaryTransport.adjointDomain (transport")
for i in find(lambda l: "adjointDomain (mulDomain f) (mulOp f) = BookProof.ChapterUnboundedPosition.adjointDomain f" in l):
    if not in_del(i):
        R[i] = ("    BookProof.ChapterUnitaryTransport.adjointDomain (mulDomain f) (mulOp f) = adjointDomain f")
expected_R = {i for i in range(len(lines)) if i in R}
assert len(R) >= 2, f"expected >=2 replacements, got {sorted(R)}"

# ---- insertion payloads ----
open_ins = ["open BookProof.ChapterContinuityUnitaryInfinite (L2Z LinfZ summable_normSq norm_sq_eq_tsum)"]
inj_a = next(i for i, s in enumerate(src) if s.startswith("/-! ## The natural domain"))
adj_i = next(i for i, s in enumerate(src) if "def adjointDomain (f : ℤ → ℝ) : Set L2Z" in s)
inj_b = adj_i + 1  # include the set-builder body line, stop before its docstring
assert "phi | ∃ eta" in src[inj_b], src[inj_b]
injection = src[inj_a: inj_b + 1]
assert not any(s.startswith("namespace") or s.startswith("end ") for s in injection)

out = []
for i, l in enumerate(lines):
    n = i + 1  # 1-based
    if any(a + 1 <= n <= b + 1 for a, b in (D1, D2, D3)):
        continue
    out.append(R.get(i, l))
    if i == open_line:
        out.extend(open_ins)
    if i == varH_line:
        out.extend([""] + injection)

open(SC, "w", encoding="utf-8").write("\n".join(out))
print(f"OK: {len(lines)} -> {len(out)} lines; deleted {D1} {D2} {D3}; replaced {sorted(R)}")
