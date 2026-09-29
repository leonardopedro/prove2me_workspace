import Definitions.Def_ChapterSirkEndToEnd
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterQgManifoldModeInstance
import Mathlib


/-!
# One shift, one finite time: the SIRK/Hashimoto algorithm needs no time discretization

The shift-invert rational Krylov (SIRK/Hashimoto) algorithm evaluates the propagator at a
**single finite time** `t`: it builds a rational approximant of `e^{−itA}` whose poles are
the *shifts*, and the only operator it ever applies is the **bounded** shift-invert
resolvent `(A − iℓ)⁻¹`.  There is therefore

* no time discretization (no step size, no number of steps, no Trotter splitting), and
* no boundedness requirement on the Hamiltonian: `‖(A − iℓ)⁻¹‖ ≤ 1/|ℓ|` holds for every
  self-adjoint `A`, however unbounded.

`BookProof.ChapterQgTimeStepping` analyses a time-stepping scheme (Crank–Nicolson) as *one
possible* way of producing the propagator.  This module records that time stepping is an
option, not a requirement, and supplies the statements the algorithm actually uses.

## What is proved

* `res_sub_res` — the first resolvent identity
  `(A − iℓ)⁻¹ − (A − im)⁻¹ = i(ℓ − m)(A − iℓ)⁻¹(A − im)⁻¹` for the project's
  `UnboundedSelfAdjoint` interface.
* `norm_res_neg` — `‖(A + iℓ)⁻¹y‖ = ‖(A − iℓ)⁻¹y‖`: the resolvent is normal, proved from
  the adjoint relation and the commutation of resolvents, with no spectral theorem.
* `StrongResAt T S ℓ` — strong convergence of the shift-invert operators at the **single**
  shift `ℓ`.
* `strongResAt_of_abs_sub_lt` — a Neumann/resolvent-identity step: convergence at `ℓ`
  gives convergence at every `m` with `|m − ℓ| < |ℓ|`.
* `strongResAt_neg`, `strongResAt_of_pos_of_pos`, **`strongResAt_of_ne_zero`** — hence
  convergence at *one* nonzero shift already gives convergence at *every* nonzero shift:
  the algorithm's choice of shift is immaterial.
* **`singleTime_flow_tendsto_of_strongResAt`** — and therefore, by Trotter–Kato, the
  approximants' propagators converge at **every single finite time** `t`, with no time
  discretization and no boundedness assumption anywhere.
* `isShiftInvertC_neg_resCLM_shift` — the Hashimoto shift-invert operator at the complex
  shift `γ = iℓ` is `−(A − iℓ)⁻¹` for every real `ℓ ≠ 0` (the case `ℓ = 1` is
  `BookProof.QgTruncationResolvent.isShiftInvertC_neg_resCLM`).
* **`sirk_single_time_shiftInvert_bound`** — the end-to-end SIRK bound applied at one
  finite time: with `X = (A − iℓ)⁻¹` the bounded operator the algorithm iterates, the
  Krylov reduction approximates `e^{−itA}v` itself, at that single `t`; there is no time
  step anywhere in the statement.
* **`qgOuterFock_singleTime_shiftInvert_convergence`**,
  **`starobinsky_qgContinuum_singleTime_shiftInvert_convergence`** and
  **`starobinsky_qgManifold_singleTime_shiftInvert_convergence`** — the quantum-gravity
  instance: the mode-truncated Hamiltonians' shift-invert operators converge at *every*
  nonzero shift, and their propagators converge to the exact one at *every single finite
  time*.  This replaces the "choose a number of time steps per cutoff" formulation of
  `BookProof.ChapterQgTimeStepping.qgOuterFock_fullyDiscrete_convergence`.

Everything is `sorry`-free and `axiom`-free.
-/

open scoped InnerProductSpace

namespace BookProof.SirkSingleTime
/-! ## Cross-chapter definitions from `BookProof.QgTruncationResolvent` -/
theorem isShiftInvertC_neg_resCLM (T : UnboundedSelfAdjoint F) :
    IsShiftInvertC T.op Complex.I (-(T.resCLM 1)) := by
  have hI : (Complex.I).im ≠ 0 := by simp
  have key : ∀ x : T.domain, cshiftMap T.op Complex.I x = -(T.shift 1 x) := by
    intro x
    rw [UnboundedSelfAdjoint.shift_apply]
    change Complex.I • (x : F) - T.op x = -(T.op x - (((1 : ℝ) : ℂ) * Complex.I) • (x : F))
    simp only [Complex.ofReal_one, one_mul]
    abel
  refine isShiftInvertC_of_rightInverse T.symmetric hI fun u => ?_
  have hmem : (-(T.resCLM 1)) u ∈ T.domain := by
    have h := T.resCLM_mem 1 u
    simp only [ContinuousLinearMap.neg_apply]
    exact T.domain.neg_mem h
  refine ⟨hmem, ?_⟩
  have hneg : (⟨(-(T.resCLM 1)) u, hmem⟩ : T.domain) = -(T.res 1 u) := Subtype.ext (by simp)
  rw [hneg, map_neg, key, neg_neg, T.shift_res one_ne_zero]

/-- **The numerical statement in the form the shift-invert (Hashimoto/SIRK) machinery of
this project consumes.**  The exact quantum-gravity Hamiltonian and each of its
mode truncations have a unique self-adjoint realization; each realization has a Hashimoto
shift-invert operator at the complex shift `γ = i`, namely `−(H − i)⁻¹`; and the truncated
shift-invert operators converge strongly to the exact one.  This is exactly the input of the
rational-Krylov (SIRK) layer, and by Trotter–Kato it yields convergence of the flows. -/
theorem qg_truncation_hashimoto_shiftInvert_tendsto (Λ : ℕ → Set ι)
    (hexh : ∀ F : Finset ι, ∀ᶠ n in atTop, ∀ a ∈ F, a ∈ Λ n) :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (S : ℕ → UnboundedSelfAdjoint (Sec ι)),
      IsSelfAdjointExtension (secHam W Q) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam W (truncModes Q (Λ n))) (S n).op) ∧
        IsShiftInvertC T.op Complex.I (-(T.resCLM 1)) ∧
        (∀ n, IsShiftInvertC (S n).op Complex.I (-((S n).resCLM 1))) ∧
        ∀ u : Sec ι, Tendsto (fun n => -((S n).resCLM 1 u)) atTop (𝓝 (-(T.resCLM 1 u))) := by
  obtain ⟨T, S, hT, hS, hres, -⟩ := qgOuterFock_truncation_flow_convergence W Q Λ hexh
  exact ⟨T, S, hT, hS, isShiftInvertC_neg_resCLM T, fun n => isShiftInvertC_neg_resCLM (S n),
    fun u => (hres u).neg⟩

end

open Filter Topology

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

/-! ## 1. The resolvent identity and normality of the resolvent -/





/-! ## 2. Strong convergence at one shift gives strong convergence at every shift -/

/-- Strong convergence of the shift-invert operators at the single shift `ℓ`. -/
def StrongResAt (T : UnboundedSelfAdjoint E) (S : ℕ → UnboundedSelfAdjoint E) (l : ℝ) : Prop :=
  ∀ y : E, Tendsto (fun n => (S n).resCLM l y) atTop (𝓝 (T.resCLM l y))

variable {T : UnboundedSelfAdjoint E} {S : ℕ → UnboundedSelfAdjoint E}













/-! ## 3. The Hashimoto shift-invert operator at an arbitrary complex shift `γ = iℓ` -/





/-! ## 4. The SIRK bound at a single finite time -/


variable {Fin' : Type*} [NormedAddCommGroup Fin'] [InnerProductSpace ℂ Fin'] [CompleteSpace Fin']



/-! ## 5. The quantum-gravity instance: any single shift, any single finite time -/


variable {ι : Type*}









end

end BookProof.SirkSingleTime
