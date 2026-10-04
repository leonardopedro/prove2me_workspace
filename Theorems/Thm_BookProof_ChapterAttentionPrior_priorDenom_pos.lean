-- Generated from ChapterAttentionPrior.lean — theorem BookProof.ChapterAttentionPrior.priorDenom_pos
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionPrior
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionPrior

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionPrior.priorDenom_pos {w : Fin m → ℝ} (hw : ∀ j, 0 < w j) (beta : ℝ) (s : Fin m → ℝ)
    (i : Fin m) : 0 < ∑ l, w l * Real.exp (beta * s l) := by sorry
