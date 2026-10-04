-- Generated from ChapterAttentionPrior.lean — theorem BookProof.ChapterAttentionPrior.priorSoftmax_eq_scoreSoftmax_bias
import Mathlib
import Definitions.Def_ChapterAttentionPrior
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionPrior

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionPrior.priorSoftmax_eq_scoreSoftmax_bias {w : Fin m → ℝ} (hw : ∀ j, 0 < w j)
    {beta : ℝ} (hb : beta ≠ 0) (s : Fin m → ℝ) (j : Fin m) :
    priorSoftmax w beta s j
      = scoreSoftmax beta (fun l => s l + Real.log (w l) / beta) j := by sorry
