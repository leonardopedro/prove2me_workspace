import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterSirkRitzMinMax
import Mathlib


/-!
# Chapter ResolventMinMaxLadder — the Courant–Fischer ladder of an **unbounded**
# non-negative self-adjoint relation, through its resolvent

`CONSOLIDATED_PLAN.md` records, as the QG next step, "the min–max ladder through the
resolvent for the continuum spectral claim", and the recorded honest boundary of
`BookProof.ChapterSirkRitzMinMax` / `BookProof.ChapterMinMaxSpectrum` is that *the operator
is bounded throughout — the unbounded case is reached through the resolvent, not directly*.

This chapter takes that step.  Let `T` be a non-negative self-adjoint linear relation on a
complex Hilbert space `F` (the object produced by the project's Friedrichs / essential
self-adjointness chapters) and let

```text
R = (T + 1)⁻¹      (`BookProof.NonnegSquareRoot.invCLMAt`, here `res hT`)
```

be its resolvent at `1`: a **bounded**, self-adjoint, non-negative operator, to which the
whole bounded min–max machinery applies.  The ladder of `T` is compared with the ladder of
`R` read **from the top** (`maxminLevel`), through the decreasing bijection
`λ ↦ 1/(1 + λ)`.

## The analytic core

For `(y, z) ∈ T` put `x = y + z`, so that `R x = y`.  Cauchy–Schwarz for the non-negative
form `(u, v) ↦ Re⟪u, R v⟫` applied to the pair `(x, R x)` gives `‖R x‖⁴ ≤ ⟪x, Rx⟫ ⟪Rx, RRx⟫`,
which in terms of `T` is the **pointwise ladder inequality**

```text
‖y‖⁴ ≤ (‖y‖² + Re⟪y, z⟫) · Re⟪y, R y⟫,
```

i.e. for a unit vector of the domain, `Re⟪y, z⟫ ≥ 1/Re⟪y, R y⟫ − 1`.  It is the operator
form of Jensen's inequality for the convex function `λ ↦ 1/(1 + λ)`, proved with no spectral
theory at all.

## Deliverables

* `posForm_cauchy_schwarz`, `normSq_sq_le_rayleigh_mul` — Cauchy–Schwarz for a non-negative
  bounded form, and its consequence `‖Rx‖⁴ ≤ rayleighVal R x · rayleighVal R (R x)`.
* `res`, `res_mem`, `res_eq_of_mem`, `res_injective` — the resolvent at `1` as an operator
  onto the domain of `T`.
* **`normSq_sq_le_rayleigh_graph`**, `one_le_add_mul_rayleigh_of_unit`,
  `inv_sub_one_le_of_rayleigh_le` — the pointwise ladder inequality.
* `rayleighInfOn`, `maxminSet`, `maxminLevel` — the Courant–Fischer ladder of a bounded
  operator read from the top, with `maxminLevel_zero_eq_sSup_rayleighSet`.
* `graphRayleighSet`, `graphRayleighSup`, `InDomain`, `graphMinmaxSet`,
  `graphMinmaxLevel` — the ladder of the **relation** `T`, over the finite-dimensional
  subspaces of its domain; `graphRayleighSet_bddAbove` (a closed operator is bounded on a
  finite-dimensional subspace of its domain) and `graphMinmaxSet_nonempty` (the resolvent
  supplies subspaces of every dimension inside the domain).
* **`resolvent_ladder_lower`** — for every `k`,
  `1 / maxminLevel R k − 1 ≤ graphMinmaxLevel T k`: the ladder of the unbounded `T` is
  bounded below by the ladder of the bounded resolvent, read from the top.
* **`graphMinmaxLevel_zero_eq`** — at the bottom rung the inequality is an **equality**:
  `graphMinmaxLevel T 0 = 1 / maxminLevel R 0 − 1`, and
  `graphMinmaxLevel_zero_eq_sSup_spectrum` writes it with the top of the spectrum of `R`.
* `maxminLevelIn`, `minmaxLevel_neg`, `maxminLevelIn_le_maxminLevel`,
  **`galerkin_maxminLevel_tendsto`**, `galerkin_maxmin_gap_eventually_pos` and
  **`graphMinmaxLevel_zero_le_of_computed`** — the computational side: the ladder from the
  top is the ladder of `−R` from the bottom, so the Galerkin levels of the resolvent
  converge to it, a computed Ritz level is a lower bound for the true level, and therefore
  `1/(computed level) − 1` is a rigorous **upper** bound for the ground level of `T`.
* **`graphMinmax_gap_lower`** — hence a gap of the resolvent's ladder is a gap of `T`'s:
  `graphMinmaxLevel T 1 − graphMinmaxLevel T 0 ≥ 1 / maxminLevel R 1 − 1 / maxminLevel R 0`,
  and `graphMinmax_gap_pos`: it is **positive** as soon as `maxminLevel R 1 < maxminLevel R 0`.

## Honest boundary

In *this* chapter only the bottom rung of the ladder is an equality; for `k ≥ 1` what is
proved here is the inequality `1/ν_k − 1 ≤ μ_k`, which is the direction a **gap** statement
needs (a lower bound for the excited level together with the exact ground level).  The
reverse inequality for `k ≥ 1` needs spectral projections of `R`; it is proved in
`BookProof.ChapterResolventMinMaxEquality`, where the ladder becomes an equality at every
rung.  Nothing in
this chapter produces a spectral gap for any particular Hamiltonian: it converts a gap of
the resolvent's numerical ladder into a gap of the ladder of `T`.
-/

noncomputable section

namespace BookProof.ResolventLadder

open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-! ## 1. Cauchy–Schwarz for a non-negative bounded form -/









/-! ## 2. The resolvent at `1` of a non-negative self-adjoint relation -/

variable {T : Submodule ℂ (F × F)}

/-- The resolvent `R = (T + 1)⁻¹` of a non-negative self-adjoint relation. -/
def res (hT : IsNonnegSelfAdjoint T) : F →L[ℂ] F := invCLMAt hT (a := 1) one_pos













/-! ## 3. The pointwise ladder inequality -/







/-! ## 4. The ladder of a bounded operator, read from the top -/

/-- The bottom of the numerical range of `R` on a subspace. -/
def rayleighInfOn (R : F →L[ℂ] F) (S : Submodule ℂ F) : ℝ := sInf (rayleighSetOn R S)

/-- The values `inf_{x ∈ S, ‖x‖ = 1} ⟪x, Rx⟫` over the `(k+1)`-dimensional subspaces. -/
def maxminSet (R : F →L[ℂ] F) (k : ℕ) : Set ℝ :=
  {t : ℝ | ∃ S : Submodule ℂ F, Module.finrank ℂ S = k + 1 ∧ t = rayleighInfOn R S}

/-- The `k`-th Courant–Fischer level of a bounded operator, **counted from the top**. -/
def maxminLevel (R : F →L[ℂ] F) (k : ℕ) : ℝ := sSup (maxminSet R k)























/-! ## 5. The ladder of the relation -/

/-- The Rayleigh values of `T` at the unit vectors of a subspace of its domain. -/
def graphRayleighSet (T : Submodule ℂ (F × F)) (S : Submodule ℂ F) : Set ℝ :=
  {t : ℝ | ∃ y z : F, (y, z) ∈ T ∧ y ∈ S ∧ ‖y‖ = 1 ∧ t = (inner ℂ y z : ℂ).re}

/-- The top of the numerical range of `T` on a subspace of its domain. -/
def graphRayleighSup (T : Submodule ℂ (F × F)) (S : Submodule ℂ F) : ℝ :=
  sSup (graphRayleighSet T S)

/-- A subspace inside the domain of the relation. -/
def InDomain (T : Submodule ℂ (F × F)) (S : Submodule ℂ F) : Prop := ∀ y ∈ S, ∃ z, (y, z) ∈ T

/-- The values `sup_{y ∈ S, ‖y‖ = 1} ⟪y, Ty⟫` over the `(k+1)`-dimensional subspaces of the
domain. -/
def graphMinmaxSet (T : Submodule ℂ (F × F)) (k : ℕ) : Set ℝ :=
  {t : ℝ | ∃ S : Submodule ℂ F,
    Module.finrank ℂ S = k + 1 ∧ InDomain T S ∧ t = graphRayleighSup T S}

/-- The `k`-th Courant–Fischer level of the relation `T`. -/
def graphMinmaxLevel (T : Submodule ℂ (F × F)) (k : ℕ) : ℝ := sInf (graphMinmaxSet T k)













/-! ## 6. The ladder inequality -/





/-! ## 7. The bottom rung: an equality -/







/-! ## 8. The gap -/





/-! ## 9. What the numerics computes: the Galerkin levels of the resolvent

The shift-invert schemes of the project diagonalise finite compressions of the **resolvent**,
not of the Hamiltonian.  This section transports the Galerkin convergence theorem of
`ChapterSirkRitzMinMax` to the ladder read from the top (by applying it to `−R`), and turns a
computed Ritz level into a rigorous upper bound for the ground level of the unbounded
operator. -/

/-- The levels of `R` from the top, computed only inside a fixed subspace `W`: the Ritz
levels the solver produces from the truncation to `W`. -/
def maxminSetIn (R : F →L[ℂ] F) (W : Submodule ℂ F) (k : ℕ) : Set ℝ :=
  {t : ℝ | ∃ S : Submodule ℂ F, S ≤ W ∧ Module.finrank ℂ S = k + 1 ∧ t = rayleighInfOn R S}

/-- The `k`-th Rayleigh–Ritz level of the truncation of `R` to `W`, counted from the top. -/
def maxminLevelIn (R : F →L[ℂ] F) (W : Submodule ℂ F) (k : ℕ) : ℝ := sSup (maxminSetIn R W k)























end BookProof.ResolventLadder

end
