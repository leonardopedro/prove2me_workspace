-- Generated from ChapterAttentionPrior.lean — theorem BookProof.ChapterAttentionPrior.priorSoftmax_smul
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionPrior
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionPrior

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionPrior.priorSoftmax_smul {w : Fin m → ℝ} (hw : ∀ j, 0 < w j) {c : ℝ} (hc : 0 < c)
    (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    priorSoftmax (fun l => c * w l) beta s j = priorSoftmax w beta s j := by sorry
