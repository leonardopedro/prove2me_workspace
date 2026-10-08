-- Generated from ChapterAttentionPrior.lean — theorem BookProof.ChapterAttentionPrior.priorSoftmax_smul
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionPrior
open BookProof.ChapterAttentionPrior


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


theorem BookProof.ChapterAttentionPrior.priorSoftmax_smul {w : Fin m → ℝ} (hw : ∀ j, 0 < w j) {c : ℝ} (hc : 0 < c)
    (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    priorSoftmax (fun l => c * w l) beta s j = priorSoftmax w beta s j := by sorry
