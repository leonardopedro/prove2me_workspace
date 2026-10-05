-- Generated from ChapterLayerNorm.lean — theorem BookProof.ChapterLayerNorm.variance_eq_zero_iff
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterLayerNorm
import Definitions.Def_ChapterTotalVariance
open ChapterTotalVariance
open BookProof.ChapterLayerNorm

variable {d : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterLayerNorm.variance_eq_zero_iff (hd : 0 < d) (x : Fin d → ℝ) :
    variance x = 0 ↔ ∀ i, x i = mean x := by sorry
