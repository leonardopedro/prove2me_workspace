import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterSirkRitzMinMax
import Mathlib


/-!
# Chapter ResolventMinMaxEquality — the ladder inequality is an **equality** at every rung

`BookProof.ChapterResolventMinMaxLadder` compares the Courant–Fischer ladder of an
unbounded non-negative self-adjoint relation `T` with the ladder of its bounded resolvent
`R = (T + 1)⁻¹` read from the top, and proves

```text
1 / ν_k − 1 ≤ μ_k(T)          (`resolvent_ladder_lower`)
```

for every `k`, with equality at the bottom rung `k = 0`.  Its recorded honest boundary was
that the reverse inequality for `k ≥ 1` "needs spectral projections of `R`, which are not
developed here".  This chapter supplies them — reusing the functional-calculus toolkit of
`BookProof.ChapterMinMaxSpectrum` — and closes the boundary: the ladder of the unbounded
operator is **exactly** the transformed ladder of its resolvent.

## The argument

Fix `c` slightly below `ν_k` and let `q` be the continuous symbol that vanishes below
`c − δ` and equals `1` above `c` (the `cocutoff` of `ChapterMinMaxSpectrum`).  Two spectral
estimates carry the proof, both instances of the order-preservation `cfc_le_iff` of the
functional calculus:

* **on the range of `q(R)`** the operator inequality `(c − δ) R ≤ R²` holds, i.e.
  `(c − δ) ⟪x, Rx⟫ ≤ ‖Rx‖²` (`mul_rayleigh_le_normSq_of_mem_range`) — because `q` vanishes
  where `t < c − δ`;
* **on the kernel of `q(R)`** the Rayleigh quotient of `R` is at most `c`
  (`rayleighVal_le_of_cfc_eq_zero`) — because `t ≤ c + t q(t)` everywhere.

Now either the range of `q(R)` contains a `(k+1)`-dimensional subspace `S₀` — and then
`R S₀` is a `(k+1)`-dimensional subspace of the domain of `T` on which the Rayleigh quotient
of `T` is at most `1/(c − δ) − 1`, by the first estimate — or it does not, and then `q(R)`
kills a unit vector of *every* `(k+1)`-dimensional subspace, so by the second estimate every
competitor has `inf ≤ c`, giving `ν_k ≤ c`, which contradicts the choice of `c`.

## Deliverables

* `stepUp` and its elementary properties — the continuous `0/1` symbol at `[c − δ, c]`.
* `mul_rayleigh_le_normSq_of_mem_range`, `rayleighVal_le_of_cfc_eq_zero` — the two spectral
  estimates.
* `exists_unit_mem_ker_of_no_range_subspace` — the dimension dichotomy.
* **`graphMinmaxLevel_le`** — `graphMinmaxLevel T k ≤ 1 / maxminLevel R k − 1`.
* **`graphMinmaxLevel_eq`** — the ladder correspondence
  `graphMinmaxLevel T k = 1 / maxminLevel R k − 1` at **every** rung, and
  `graphMinmaxLevel_eq_of_spectrum` in terms of the spectrum of `R`.
* **`graphMinmax_gap_eq`** — hence the gap of `T`'s ladder is exactly `1/ν₁ − 1/ν₀`.

## Honest boundary

The statements assume that the rung exists (`graphMinmaxSet T k` is non-empty, which the
resolvent guarantees as soon as the space has dimension `k + 1`) and that the resolvent's
level is strictly positive, `0 < maxminLevel R k`; at `k = 0` positivity is automatic
(`maxminLevel_zero_pos`).  The relation is assumed single-valued, as in the previous
chapter.  Nothing here produces a gap for a particular Hamiltonian.
-/

noncomputable section

namespace BookProof.ResolventLadderEq

open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-! ## 1. The continuous step symbol -/

/-- The continuous symbol that vanishes below `c − δ` and is `1` above `c`. -/
def stepUp (c δ : ℝ) : ℝ → ℝ := cocutoff (c - δ / 2) (δ / 2)











/-! ## 2. The two spectral estimates -/





/-! ## 3. The dimension dichotomy -/



/-! ## 4. The reverse ladder inequality -/

variable {T : Submodule ℂ (F × F)}



/-! ## 5. The ladder correspondence -/





end BookProof.ResolventLadderEq

end
