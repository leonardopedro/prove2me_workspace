import Mathlib

/-!
# Chapter "Wave-function parametrization of a probability measure", §4 —
# Quantum Mechanics versus a non-commutative generalization of probability theory

This file formalizes the concrete **2-dimensional real** comparison with Gleason's
theorem given in the `book.tex` chapter *"Wave-function parametrization of a
probability measure"*, section *"4. Quantum Mechanics versus a non-commutative
generalization of probability theory"* (`book.tex` line ~1550).

The book contrasts the wave-function parametrization (which uses only *commuting*
projections, hence pure states) with Gleason's theorem (which handles
*non-commuting* projections and requires mixed states). It exhibits two
non-commuting rank-one projections on `ℝ²`,

* `P₁ = !![1,0;0,0]`  (projection onto the first axis), and
* `Q  = ½ !![1,1;1,1]` (projection onto the diagonal `(1,1)`),

together with the two expectation constraints
`tr(ρ P₁) = ½` and `tr(ρ Q) = ½`, and observes:

* there **is** a *pure* state realizing each constraint separately;
* there is **no** *pure* state realizing **both** simultaneously; yet
* the *mixed* state `ρ = ½·I` realizes both.

We model a real pure state by a unit vector `v : Fin 2 → ℝ` through the rank-one
density matrix `ρ = v vᵀ = Matrix.vecMulVec v v`, and the expectation by the
trace `tr(ρ A)`.  A short computation gives the two expectation formulas
`tr(v vᵀ · P₁) = v₀²` and `tr(v vᵀ · Q) = (v₀+v₁)²/2`, from which every claim
follows.
-/

open scoped Matrix BigOperators

namespace BookProof.ChapterGleason2D

/-- The projection `P₁ = !![1,0;0,0]` onto the first axis of `ℝ²`. -/
def P1 : Matrix (Fin 2) (Fin 2) ℝ := !![1, 0; 0, 0]

/-- The projection `Q = ½ !![1,1;1,1]` onto the diagonal `(1,1)` direction. -/
noncomputable def Q : Matrix (Fin 2) (Fin 2) ℝ := !![1/2, 1/2; 1/2, 1/2]

/-- The real rank-one density matrix (pure state) attached to a vector `v`,
`ρ = v vᵀ`. -/
def pure (v : Fin 2 → ℝ) : Matrix (Fin 2) (Fin 2) ℝ := Matrix.vecMulVec v v

/-- The expectation `tr(ρ A)` of an observable `A` in the state `ρ`. -/
def expec (ρ A : Matrix (Fin 2) (Fin 2) ℝ) : ℝ := (ρ * A).trace

/-! ## Basic non-commutativity: the two projections do not commute. -/

/-
`P₁` and `Q` are non-commuting projections (the book's complementary
observables).
-/
theorem P1_Q_noncomm : P1 * Q ≠ Q * P1 := by
  intro h; have := congr_fun ( congr_fun h 0 ) 1; norm_num [ Q, P1, Matrix.mul_apply ] at this;

/-
Both `P₁` and `Q` are genuine orthogonal projections (`M² = M`, symmetric,
trace one).
-/
theorem P1_isProjection : P1 * P1 = P1 ∧ P1.transpose = P1 ∧ P1.trace = 1 := by
  norm_num [ P1, Matrix.trace ];
  exact ⟨ by ext i; fin_cases i <;> rfl, by ext i j; fin_cases i <;> fin_cases j <;> rfl ⟩

theorem Q_isProjection : Q * Q = Q ∧ Q.transpose = Q ∧ Q.trace = 1 := by
  norm_num [ Q, Matrix.trace ];
  ext i j; fin_cases i <;> fin_cases j <;> rfl;

/-! ## The two expectation formulas for a pure state `ρ = v vᵀ`. -/

/-
`tr(v vᵀ · P₁) = v₀²`.
-/
theorem expec_pure_P1 (v : Fin 2 → ℝ) : expec (pure v) P1 = (v 0) ^ 2 := by
  unfold expec pure P1; norm_num [ Fin.sum_univ_succ, Matrix.vecMulVec ] ; ring;
  norm_num [ Matrix.trace, Matrix.mul_apply, sq ]

/-
`tr(v vᵀ · Q) = (v₀ + v₁)² / 2`.
-/
theorem expec_pure_Q (v : Fin 2 → ℝ) : expec (pure v) Q = (v 0 + v 1) ^ 2 / 2 := by
  unfold expec pure Q;
  norm_num [ Matrix.trace, Matrix.mul_apply, Matrix.vecMulVec ] ; ring

/-! ## A pure state realizes each constraint separately. -/

/-
The unit vector `w = (1/√2, 1/√2)` gives a pure state with `tr(ρ Q) = ½`
(it also has unit norm).
-/
theorem pure_realizes_Q :
    ∃ v : Fin 2 → ℝ, (v 0) ^ 2 + (v 1) ^ 2 = 1 ∧ expec (pure v) Q = 1/2 := by
      refine ⟨ fun i => if i = 0 then 1 else 0, ?_, ?_ ⟩ <;> norm_num;
      convert expec_pure_Q ( fun i => if i = 0 then 1 else 0 ) using 1 ; norm_num

/-
A pure state realizing `tr(ρ P₁) = ½`: the unit vector `w = (1/√2, 1/√2)`
gives `tr(w wᵀ P₁) = w₀² = ½`.
-/
theorem pure_realizes_P1 :
    ∃ v : Fin 2 → ℝ, (v 0) ^ 2 + (v 1) ^ 2 = 1 ∧ expec (pure v) P1 = 1/2 := by
      refine ⟨fun i => if i = 0 then 1 / Real.sqrt 2 else 1 / Real.sqrt 2, ?_, ?_⟩
        <;> norm_num [expec, P1];
      convert expec_pure_P1 ( fun _ => ( Real.sqrt 2 ) ⁻¹ ) using 1 ; norm_num [ pure ]

/-! ## No pure state realizes both constraints simultaneously. -/

/-
**The key impossibility.** There is no real unit vector `v` (pure state
`ρ = v vᵀ`) with `tr(ρ P₁) = ½` and `tr(ρ Q) = ½` simultaneously.
-/
theorem no_pure_state_both :
    ¬ ∃ v : Fin 2 → ℝ, (v 0) ^ 2 + (v 1) ^ 2 = 1 ∧
      expec (pure v) P1 = 1/2 ∧ expec (pure v) Q = 1/2 := by
        norm_num [ expec_pure_P1, expec_pure_Q ];
        grind

/-! ## The mixed state `ρ = ½·I` realizes both constraints. -/

/-
The maximally mixed state `ρ = ½·I` is a density matrix (`tr ρ = 1`) and
realizes both expectation constraints `tr(ρ P₁) = ½`, `tr(ρ Q) = ½`, exactly as
Gleason's theorem predicts for the non-commuting pair.
-/
theorem mixed_state_both :
    let ρ : Matrix (Fin 2) (Fin 2) ℝ := (1/2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)
    ρ.trace = 1 ∧ expec ρ P1 = 1/2 ∧ expec ρ Q = 1/2 := by
      unfold expec P1 Q;
      norm_num [ Matrix.trace ]

end BookProof.ChapterGleason2D
