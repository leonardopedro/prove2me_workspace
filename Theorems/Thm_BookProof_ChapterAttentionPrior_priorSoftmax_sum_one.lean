-- Generated from ChapterAttentionPrior.lean — theorem BookProof.ChapterAttentionPrior.priorSoftmax_sum_one
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionPrior
open BookProof.ChapterAttentionPrior

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionPrior.priorSoftmax_sum_one {w : Fin m → ℝ} (hw : ∀ j, 0 < w j) (beta : ℝ)
    (s : Fin m → ℝ) (i : Fin m) : ∑ j, priorSoftmax w beta s j = 1 := by sorry
