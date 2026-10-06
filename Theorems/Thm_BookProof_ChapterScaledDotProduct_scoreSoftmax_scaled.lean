-- Generated from ChapterScaledDotProduct.lean — theorem BookProof.ChapterScaledDotProduct.scoreSoftmax_scaled
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterScaledDotProduct

variable {d : ℕ}
variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterScaledDotProduct.scoreSoftmax_scaled (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta (fun l => s l / Real.sqrt d) j
      = scoreSoftmax (beta / Real.sqrt d) s j := by sorry
