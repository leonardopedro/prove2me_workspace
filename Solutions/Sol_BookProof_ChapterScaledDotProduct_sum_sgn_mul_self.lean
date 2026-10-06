-- Generated from ChapterScaledDotProduct.lean — solution of BookProof.ChapterScaledDotProduct.sum_sgn_mul_self
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
import Theorems.Thm_BookProof_ChapterScaledDotProduct_sgn_mul_self
open BookProof.ChapterScaledDotProduct



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) :
    ∑ x : (Fin d → Bool), sgn (x i) * sgn (x i) = 2 ^ d := by

  rw [Finset.sum_congr rfl fun x (_ : x ∈ Finset.univ) => sgn_mul_self (x i)]
  simp
