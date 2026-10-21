-- Generated from ChapterScaledDotProduct.lean — solution of BookProof.ChapterScaledDotProduct.scoreSoftmax_div
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness

variable {d : ℕ}

variable {d : ℕ}
variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta c : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta (fun l => s l / c) j = scoreSoftmax (beta / c) s j := by

  simp only [scoreSoftmax, mul_div_assoc, div_mul_eq_mul_div]
