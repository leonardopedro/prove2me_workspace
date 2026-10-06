-- Generated from ChapterB4.lean — solution of BookProof.ChapterB4.no_pure_state_satisfies_both
import Mathlib
import Definitions.Def_ChapterB4
open BookProof.ChapterB4




open Matrix

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ ∃ ρ, IsPureState ρ ∧ Matrix.trace (ρ * P1) = 1 / 2 ∧
      Matrix.trace (ρ * P2) = 1 / 2 := by

  rintro ⟨ρ, ⟨v, hv, hρ⟩, h1, h2⟩
  simp only [P1, P2, Matrix.trace_fin_two] at h1 h2
  simp only [Matrix.mul_apply, Fin.sum_univ_two, Matrix.of_apply, Matrix.cons_val_zero,
    Matrix.cons_val_one] at h1 h2
  rw [hρ] at h1 h2
  simp only at h1 h2
  nlinarith [hv, h1, h2]
