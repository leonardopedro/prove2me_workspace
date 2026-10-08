-- Generated from ChapterAttentionPrior.lean — theorem BookProof.ChapterAttentionPrior.priorSoftmax_eq_scoreSoftmax_bias
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionPrior
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionPrior


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


theorem BookProof.ChapterAttentionPrior.priorSoftmax_eq_scoreSoftmax_bias {w : Fin m → ℝ} (hw : ∀ j, 0 < w j)
    {beta : ℝ} (hb : beta ≠ 0) (s : Fin m → ℝ) (j : Fin m) :
    priorSoftmax w beta s j
      = scoreSoftmax beta (fun l => s l + Real.log (w l) / beta) j := by sorry
