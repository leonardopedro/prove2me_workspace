import Mathlib

/-!
# Chapter B4 — The Gleason contrast: pure vs. mixed states on non-commuting projections

Source: `book.tex` §4 (line ~1637, "Quantum Mechanics versus a non-commutative
generalization of probability theory").  The book compares its commuting
(wave-function) parametrization with Gleason's theorem, which parametrizes
probability assignments to *non-commuting* projections by a (possibly mixed)
density matrix.  The `2`-dimensional real worked example is a concrete,
finite-dimensional, fully self-contained statement flagged in
`FORMALIZATION_ROADMAP.md` (Chapter B remark) as "worth adding as a sanity
check".  This file formalizes it.

Fix the two non-commuting real projections
`P₁ = [[1,0],[0,0]]` and `P₂ = ½[[1,1],[1,1]]`.  A **pure state** in the
`2`-dimensional real case is a rank-one projector `v vᵀ` for a unit vector `v`
(`IsPureState`); a **density matrix** is a Hermitian, positive-semidefinite,
unit-trace matrix (`IsDensityMatrix`).  The Born value assigned to a projection
`P` by a state `ρ` is `tr(ρ P)`.  The results:

* `pure_state_satisfies_P1` — a pure state (namely `P₂` itself) gives
  `tr(ρ P₁) = ½`;
* `pure_state_satisfies_P2` — a pure state (namely `P₁` itself) gives
  `tr(ρ P₂) = ½`;
* **headline** `no_pure_state_satisfies_both` — **no** pure state gives
  `tr(ρ P₁) = ½` *and* `tr(ρ P₂) = ½` simultaneously;
* `mixed_state_satisfies_both` — the mixed state `ρ = ½ I` *does* satisfy both,
  and `mixed_state_not_pure` shows it is genuinely mixed (not pure), while
  `mixed_state_isDensityMatrix` confirms it is a legitimate density matrix.

This is exactly the book's point: the wave-function (pure states) cannot match
the Born data of two non-commuting projections at once, whereas Gleason's
mixed-state density matrix can.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

namespace BookProof.ChapterB4

open Matrix

noncomputable section

/-- The projection `P₁ = |1⟩⟨1| = [[1,0],[0,0]]`. -/
def P1 : Matrix (Fin 2) (Fin 2) ℝ := !![1, 0; 0, 0]

/-- The projection `P₂ = ½[[1,1],[1,1]]` (onto the `(1,1)/√2` direction). -/
def P2 : Matrix (Fin 2) (Fin 2) ℝ := !![1/2, 1/2; 1/2, 1/2]

/-- A **pure state** in the `2`-dimensional real case: the rank-one projector
`ρ = v vᵀ` associated to a real unit vector `v`. -/
def IsPureState (ρ : Matrix (Fin 2) (Fin 2) ℝ) : Prop :=
  ∃ v : Fin 2 → ℝ, v 0 ^ 2 + v 1 ^ 2 = 1 ∧ ρ = fun i j => v i * v j

/-- A **density matrix**: Hermitian, positive-semidefinite, unit trace. -/
def IsDensityMatrix (ρ : Matrix (Fin 2) (Fin 2) ℝ) : Prop :=
  ρ.IsHermitian ∧ ρ.PosSemidef ∧ Matrix.trace ρ = 1

/-- `P₂` is a pure state (the rank-one projector for `v = (1/√2, 1/√2)`). -/
theorem P2_isPureState : IsPureState P2 := by
  have hmul : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  refine ⟨![Real.sqrt 2 / 2, Real.sqrt 2 / 2], ?_, ?_⟩
  · simp only [Matrix.cons_val_zero, Matrix.cons_val_one]
    nlinarith [hmul]
  · ext i j
    fin_cases i <;> fin_cases j <;> simp [P2] <;> nlinarith [hmul]

/-- `P₁` is a pure state (the rank-one projector for `v = (1, 0)`). -/
theorem P1_isPureState : IsPureState P1 := by
  refine ⟨![1, 0], by norm_num, ?_⟩
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [P1]

/-- A pure state satisfying the first Born constraint `tr(ρ P₁) = ½`
(witnessed by `ρ = P₂`). -/
theorem pure_state_satisfies_P1 :
    ∃ ρ, IsPureState ρ ∧ Matrix.trace (ρ * P1) = 1 / 2 := by
  refine ⟨P2, P2_isPureState, ?_⟩
  simp [P1, P2, Matrix.trace_fin_two]

/-- A pure state satisfying the second Born constraint `tr(ρ P₂) = ½`
(witnessed by `ρ = P₁`). -/
theorem pure_state_satisfies_P2 :
    ∃ ρ, IsPureState ρ ∧ Matrix.trace (ρ * P2) = 1 / 2 := by
  refine ⟨P1, P1_isPureState, ?_⟩
  simp [P1, P2, Matrix.trace_fin_two]

/-- **Headline (the Gleason contrast, pure-state impossibility).** No pure state
`ρ` simultaneously satisfies `tr(ρ P₁) = ½` and `tr(ρ P₂) = ½`. -/
theorem no_pure_state_satisfies_both :
    ¬ ∃ ρ, IsPureState ρ ∧ Matrix.trace (ρ * P1) = 1 / 2 ∧
      Matrix.trace (ρ * P2) = 1 / 2 := by
  rintro ⟨ρ, ⟨v, hv, rfl⟩, h1, h2⟩
  simp only [P1, P2, Matrix.trace_fin_two, Matrix.mul_apply, Fin.sum_univ_two,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.of_apply,
    Matrix.cons_val'] at h1 h2
  nlinarith [hv, h1, h2, sq_nonneg (v 0 - v 1), sq_nonneg (v 0 + v 1)]

/-- The mixed state `ρ = ½ I` satisfies **both** Born constraints simultaneously. -/
theorem mixed_state_satisfies_both :
    Matrix.trace (((1 / 2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)) * P1) = 1 / 2 ∧
    Matrix.trace (((1 / 2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)) * P2) = 1 / 2 := by
  refine ⟨?_, ?_⟩ <;>
    norm_num [P1, P2, Matrix.trace_fin_two, Matrix.mul_apply, Fin.sum_univ_two,
      Matrix.one_apply]

/-- The mixed state `ρ = ½ I` is genuinely **not** a pure state. -/
theorem mixed_state_not_pure :
    ¬ IsPureState ((1 / 2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)) := by
  rintro ⟨v, hv, hρ⟩
  have e00 : v 0 * v 0 = 1 / 2 := by
    have := congrFun (congrFun hρ 0) 0
    simpa [Matrix.one_apply] using this.symm
  have e01 : v 0 * v 1 = 0 := by
    have := congrFun (congrFun hρ 0) 1
    simpa [Matrix.one_apply] using this.symm
  have e11 : v 1 * v 1 = 1 / 2 := by
    have := congrFun (congrFun hρ 1) 1
    simpa [Matrix.one_apply] using this.symm
  nlinarith [e00, e01, e11]

/-- The mixed state `ρ = ½ I` is a legitimate density matrix. -/
theorem mixed_state_isDensityMatrix :
    IsDensityMatrix ((1 / 2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)) := by
  have hpsd : ((1 / 2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)).PosSemidef :=
    Matrix.PosSemidef.one.smul (by norm_num)
  refine ⟨hpsd.1, hpsd, ?_⟩
  norm_num [Matrix.trace_fin_two, Matrix.one_apply]

end

end BookProof.ChapterB4
