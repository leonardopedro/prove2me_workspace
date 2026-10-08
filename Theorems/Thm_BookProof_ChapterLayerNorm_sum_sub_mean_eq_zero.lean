-- Generated from ChapterLayerNorm.lean — theorem BookProof.ChapterLayerNorm.sum_sub_mean_eq_zero
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


theorem BookProof.ChapterLayerNorm.sum_sub_mean_eq_zero (hd : 0 < d) (x : Fin d → ℝ) : ∑ i, (x i - mean x) = 0 := by sorry
