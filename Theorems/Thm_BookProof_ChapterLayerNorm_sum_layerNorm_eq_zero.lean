-- Generated from ChapterLayerNorm.lean — theorem BookProof.ChapterLayerNorm.sum_layerNorm_eq_zero
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


theorem BookProof.ChapterLayerNorm.sum_layerNorm_eq_zero (hd : 0 < d) (x : Fin d → ℝ) : ∑ i, layerNorm x i = 0 := by sorry
