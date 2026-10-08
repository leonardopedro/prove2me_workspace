-- Generated from ChapterLayerNorm.lean — theorem BookProof.ChapterLayerNorm.sum_sq_sub_mean_eq
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterLayerNorm
import Definitions.Def_ChapterTotalVariance
open ChapterTotalVariance
open BookProof.ChapterLayerNorm


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d : ℕ}


theorem BookProof.ChapterLayerNorm.sum_sq_sub_mean_eq (hd : 0 < d) (x : Fin d → ℝ) :
    ∑ i, (x i - mean x) ^ 2 = (d : ℝ) * variance x := by sorry
