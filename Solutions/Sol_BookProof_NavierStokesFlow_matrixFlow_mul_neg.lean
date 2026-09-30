-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.matrixFlow_mul_neg
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow










open scoped BigOperators Matrix Matrix.Norms.Operator




variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (A : Matrix (Fin n) (Fin n) ℂ) (t : ℝ) :
    matrixFlow A t * matrixFlow A (-t) = 1 := by

  have h : matrixFlow A t * matrixFlow A (-t) = NormedSpace.exp ((t • A) + ((-t) • A)) := by
    rw [Matrix.exp_add_of_commute _ _ (((Commute.refl A).smul_left t).smul_right (-t))]
    rfl
  rw [h]
  simp [NormedSpace.exp_zero]
