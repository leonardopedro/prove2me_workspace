-- Generated from ChapterLayerNorm.lean — theorem BookProof.ChapterLayerNorm.variance_eq_zero_iff
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterLayerNorm
import Definitions.Def_ChapterTotalVariance
import Definitions.Def_ChapterA4
open ChapterTotalVariance
open BookProof.ChapterLayerNorm

variable {d : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterLayerNorm.variance_eq_zero_iff (hd : 0 < d) (x : Fin d → ℝ) :
    variance x = 0 ↔ ∀ i, x i = mean x := by sorry
