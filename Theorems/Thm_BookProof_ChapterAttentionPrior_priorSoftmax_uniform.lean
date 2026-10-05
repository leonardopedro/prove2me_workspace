-- Generated from ChapterAttentionPrior.lean — theorem BookProof.ChapterAttentionPrior.priorSoftmax_uniform
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionPrior
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionPrior

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionPrior.priorSoftmax_uniform {c : ℝ} (hc : 0 < c) (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    priorSoftmax (fun _ => c) beta s j = scoreSoftmax beta s j := by sorry
