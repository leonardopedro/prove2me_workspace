-- Generated from ChapterScaledDotProduct.lean — theorem BookProof.ChapterScaledDotProduct.scoreSoftmax_div
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterScaledDotProduct


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness

variable {d : ℕ}

variable {m : ℕ}

theorem BookProof.ChapterScaledDotProduct.scoreSoftmax_div (beta c : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta (fun l => s l / c) j = scoreSoftmax (beta / c) s j := by sorry
