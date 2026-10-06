-- Generated from ChapterE3.lean — solution of BookProof.ChapterE3.eulerJ_antisymm
import Mathlib
import Definitions.Def_ChapterE3
open BookProof.ChapterE3



open scoped Matrix BigOperators


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (l w : Fin n → ℝ) :
    (eulerJ l w)ᵀ = - eulerJ l w := by

  ext i j; simp [eulerJ];
  simp [ Matrix.vecMulVec, mul_comm ]
