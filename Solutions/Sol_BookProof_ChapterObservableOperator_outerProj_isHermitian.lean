-- Generated from ChapterObservableOperator.lean — solution of BookProof.ChapterObservableOperator.outerProj_isHermitian
import Mathlib
import Definitions.Def_ChapterObservableOperator
open BookProof.ChapterObservableOperator



open scoped BigOperators

noncomputable section


variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (k : EuclideanSpace ℂ (Fin n)) :
    (outerProj k).IsHermitian := by

  ext a b
  simp [outerProj, Matrix.conjTranspose_apply, mul_comm]
