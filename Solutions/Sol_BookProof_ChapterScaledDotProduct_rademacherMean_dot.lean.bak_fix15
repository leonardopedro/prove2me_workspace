-- Generated from ChapterScaledDotProduct.lean — solution of BookProof.ChapterScaledDotProduct.rademacherMean_dot
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
import Theorems.Thm_BookProof_ChapterScaledDotProduct_sum_sgn_eq_zero
open BookProof.ChapterScaledDotProduct



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (k : Fin d → ℝ) :
    rademacherMean (fun x => dot (signVec x) k) = 0 := by

  have hswap : ∑ x : (Fin d → Bool), dot (signVec x) k
      = ∑ i, (∑ x : (Fin d → Bool), sgn (x i)) * k i := by
    simp only [dot, signVec, Finset.sum_mul]
    rw [Finset.sum_comm]
  rw [rademacherMean, hswap]
  simp [sum_sgn_eq_zero]
