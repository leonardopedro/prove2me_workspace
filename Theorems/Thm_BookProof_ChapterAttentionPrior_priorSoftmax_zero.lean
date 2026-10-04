-- Generated from ChapterAttentionPrior.lean — theorem BookProof.ChapterAttentionPrior.priorSoftmax_zero
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionPrior
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionPrior

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionPrior.priorSoftmax_zero (w : Fin m → ℝ) (s : Fin m → ℝ) (j : Fin m) :
    priorSoftmax w 0 s j = w j / ∑ l, w l := by sorry
