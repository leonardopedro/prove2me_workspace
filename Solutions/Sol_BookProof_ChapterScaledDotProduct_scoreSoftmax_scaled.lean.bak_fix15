-- Generated from ChapterScaledDotProduct.lean — solution of BookProof.ChapterScaledDotProduct.scoreSoftmax_scaled
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
import Theorems.Thm_BookProof_ChapterScaledDotProduct_scoreSoftmax_div
open BookProof.ChapterScaledDotProduct



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness

variable {d : ℕ}

variable {d : ℕ}
variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta (fun l => s l / Real.sqrt d) j
      = scoreSoftmax (beta / Real.sqrt d) s j := scoreSoftmax_div beta (Real.sqrt d) s j
