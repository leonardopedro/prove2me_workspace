-- Generated from ChapterAttentionPrior.lean — theorem BookProof.ChapterAttentionPrior.priorSoftmax_odds
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionPrior
open BookProof.ChapterAttentionPrior


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


theorem BookProof.ChapterAttentionPrior.priorSoftmax_odds {w : Fin m → ℝ} (hw : ∀ j, 0 < w j) (beta : ℝ) (s : Fin m → ℝ)
    (i j : Fin m) :
    priorSoftmax w beta s i
      = (w i / w j) * Real.exp (beta * (s i - s j)) * priorSoftmax w beta s j := by sorry
