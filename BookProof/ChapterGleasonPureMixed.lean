import Mathlib

/-!
# Chapter "Wave-function parametrization of a probability measure", §4
*"Quantum Mechanics versus a non-commutative generalization of probability
theory"* — the 2-dimensional real pure-state vs. mixed-state (Gleason) contrast

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"*, §4 (`book.tex` line ~1550).

The book contrasts its own result (a probability measure over *commuting*
projections is always parametrized by a **wave-function**, i.e. a **pure**
state) with Gleason's theorem (a probability measure over *non-commuting*
projections needs a general **density matrix**, i.e. a possibly **mixed**
state).  It works out the difference explicitly in the *2-dimensional real*
case, with the two non-commuting projections

* `P0 = [[1,0],[0,0]]` — a diagonal (position-type) projection, and
* `Q  = ½[[1,1],[1,1]]` — the projection onto `(1,1)/√2` (momentum-type),

which do not commute.  The book's claims, formalized here over
`Matrix (Fin 2) (Fin 2) ℝ` with the expectation `E ρ A = tr(ρ A)`:

* `exists_pure_expP0` — there **is** a pure state `ρ` with `tr(ρ P0) = ½`
  (e.g. `ρ = Q`), and `exists_pure_expQ` — there **is** a pure state `ρ` with
  `tr(ρ Q) = ½` (e.g. `ρ = P0`);
* **headline** `no_pure_state_both` — there is **no** pure state `ρ` satisfying
  *both* `tr(ρ P0) = ½` and `tr(ρ Q) = ½` simultaneously (the wave-function
  cannot assign the "constant density ½" values to two non-commuting
  projections at once);
* **headline** `exists_mixed_state_both` — but there **is** a mixed state `ρ`
  (e.g. the maximally mixed `ρ = ½·I`) with both `tr(ρ P0) = ½` and
  `tr(ρ Q) = ½`, exactly as Gleason's theorem provides;
* `halfI_not_pure` — the witness `½·I` is genuinely mixed (not a pure state).

A *pure state* is a real symmetric idempotent of unit trace (an orthogonal
projection onto a line, i.e. `ρ = v vᵀ` for a real unit vector `v`); a *mixed
state* is a positive-semidefinite matrix of unit trace (a general density
matrix).  Note the restriction to **real** matrices is the book's own ("the
2-dimensional real case"): over `ℂ` the state
`[[½, i/2],[-i/2, ½]]` is pure and satisfies both constraints, so
`no_pure_state_both` is a genuinely real-field phenomenon.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

open scoped BigOperators
open Matrix

namespace BookProof.ChapterGleasonPureMixed

/-- The diagonal (position-type) projection `P0 = [[1,0],[0,0]]`. -/
noncomputable def P0 : Matrix (Fin 2) (Fin 2) ℝ := !![1, 0; 0, 0]

/-- The projection `Q = ½[[1,1],[1,1]]` onto `(1,1)/√2` (momentum-type). -/
noncomputable def Q : Matrix (Fin 2) (Fin 2) ℝ := !![1/2, 1/2; 1/2, 1/2]

/-- `E ρ A = tr(ρ A)`, the expectation of the observable `A` in the state `ρ`. -/
noncomputable def E (ρ A : Matrix (Fin 2) (Fin 2) ℝ) : ℝ := (ρ * A).trace

/-- A **pure state** (wave-function): a real symmetric idempotent of unit trace,
i.e. an orthogonal projection onto a line `ρ = v vᵀ`. -/
def IsPureState (ρ : Matrix (Fin 2) (Fin 2) ℝ) : Prop :=
  ρᵀ = ρ ∧ ρ * ρ = ρ ∧ ρ.trace = 1

/-- A **mixed state** (density matrix): a positive-semidefinite matrix of unit
trace. -/
def IsMixedState (ρ : Matrix (Fin 2) (Fin 2) ℝ) : Prop :=
  ρ.PosSemidef ∧ ρ.trace = 1

/-- `P0` and `Q` do not commute: they are complementary observables. -/
theorem P0_Q_not_commute : P0 * Q ≠ Q * P0 := by
  intro h
  have := congrFun (congrFun h 0) 1
  simp [P0, Q, Matrix.mul_apply, Fin.sum_univ_two] at this

/-- `P0` is a pure state. -/
theorem P0_isPure : IsPureState P0 := by
  refine ⟨?_, ?_, ?_⟩
  · ext i j; fin_cases i <;> fin_cases j <;> simp [P0]
  · ext i j; fin_cases i <;> fin_cases j <;>
      simp [P0, Matrix.mul_apply, Fin.sum_univ_two]
  · simp [P0, Matrix.trace, Fin.sum_univ_two]

/-- `Q` is a pure state. -/
theorem Q_isPure : IsPureState Q := by
  refine ⟨?_, ?_, ?_⟩
  · ext i j; fin_cases i <;> fin_cases j <;> simp [Q]
  · ext i j; fin_cases i <;> fin_cases j <;>
      simp [Q, Matrix.mul_apply, Fin.sum_univ_two] <;> norm_num
  · simp [Q, Matrix.trace, Fin.sum_univ_two]; norm_num

/-- `E Q P0 = tr(Q P0) = ½`. -/
theorem E_Q_P0 : E Q P0 = 1/2 := by
  simp [E, Q, P0, Matrix.trace, Fin.sum_univ_two]

/-- `E P0 Q = tr(P0 Q) = ½`. -/
theorem E_P0_Q : E P0 Q = 1/2 := by
  simp [E, Q, P0, Matrix.trace, Fin.sum_univ_two]

/-- There **is** a pure state `ρ` with `tr(ρ P0) = ½` (namely `ρ = Q`). -/
theorem exists_pure_expP0 : ∃ ρ : Matrix (Fin 2) (Fin 2) ℝ,
    IsPureState ρ ∧ E ρ P0 = 1/2 :=
  ⟨Q, Q_isPure, E_Q_P0⟩

/-- There **is** a pure state `ρ` with `tr(ρ Q) = ½` (namely `ρ = P0`). -/
theorem exists_pure_expQ : ∃ ρ : Matrix (Fin 2) (Fin 2) ℝ,
    IsPureState ρ ∧ E ρ Q = 1/2 :=
  ⟨P0, P0_isPure, E_P0_Q⟩

/-- **Headline.** There is **no** pure state `ρ` satisfying both
`tr(ρ P0) = ½` and `tr(ρ Q) = ½`: a wave-function cannot reproduce the
maximally-mixed values on the two non-commuting projections `P0`, `Q` at once. -/
theorem no_pure_state_both :
    ¬ ∃ ρ : Matrix (Fin 2) (Fin 2) ℝ, IsPureState ρ ∧ E ρ P0 = 1/2 ∧ E ρ Q = 1/2 := by
  rintro ⟨ρ, ⟨hsym, hidem, htr⟩, hP0, hQ⟩
  have e00 := congrFun (congrFun hidem 0) 0
  have esym := congrFun (congrFun hsym 0) 1
  simp only [Matrix.mul_apply, Fin.sum_univ_two, Matrix.transpose_apply] at e00 esym
  simp only [E, P0, Q, Matrix.trace, Fin.sum_univ_two, Matrix.mul_apply,
    Matrix.of_apply, Matrix.cons_val', Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.diag_apply] at hP0 hQ htr
  nlinarith [sq_nonneg (ρ 0 1), sq_nonneg (ρ 1 0), e00, esym, hP0, hQ, htr]

/-- The maximally mixed state `½·I` is a mixed state. -/
theorem halfI_isMixed :
    IsMixedState ((1/2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)) := by
  refine ⟨?_, ?_⟩
  · exact Matrix.PosSemidef.one.smul (by norm_num)
  · simp [Matrix.trace]

/-- The mixed witness `½·I` is genuinely **not** a pure state (it is not
idempotent). -/
theorem halfI_not_pure :
    ¬ IsPureState ((1/2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)) := by
  rintro ⟨-, hidem, -⟩
  have := congrFun (congrFun hidem 0) 0
  simp [Matrix.mul_apply, Fin.sum_univ_two] at this

/-- **Headline (Gleason side).** There **is** a mixed state `ρ` (namely the
maximally mixed `½·I`) satisfying both `tr(ρ P0) = ½` and `tr(ρ Q) = ½` — the
density matrix Gleason's theorem provides for the two non-commuting
projections. -/
theorem exists_mixed_state_both : ∃ ρ : Matrix (Fin 2) (Fin 2) ℝ,
    IsMixedState ρ ∧ E ρ P0 = 1/2 ∧ E ρ Q = 1/2 := by
  refine ⟨(1/2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ), halfI_isMixed, ?_, ?_⟩
  · simp [E, P0, Matrix.trace, Fin.sum_univ_two]
  · simp [E, Q, Matrix.trace, Fin.sum_univ_two]; norm_num

/-- **Summary (the book's §4 contrast).** For the two non-commuting projections
`P0`, `Q`: no *pure* state realizes the pair of values `(½, ½)`, yet a *mixed*
state does. -/
theorem pure_vs_mixed_gleason_contrast :
    (¬ ∃ ρ : Matrix (Fin 2) (Fin 2) ℝ, IsPureState ρ ∧ E ρ P0 = 1/2 ∧ E ρ Q = 1/2) ∧
    (∃ ρ : Matrix (Fin 2) (Fin 2) ℝ, IsMixedState ρ ∧ E ρ P0 = 1/2 ∧ E ρ Q = 1/2) :=
  ⟨no_pure_state_both, exists_mixed_state_both⟩

end BookProof.ChapterGleasonPureMixed
