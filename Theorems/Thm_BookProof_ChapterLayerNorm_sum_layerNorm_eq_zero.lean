-- Generated from ChapterLayerNorm.lean — theorem BookProof.ChapterLayerNorm.sum_layerNorm_eq_zero
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




theorem BookProof.ChapterLayerNorm.sum_layerNorm_eq_zero (hd : 0 < d) (x : Fin d → ℝ) : ∑ i, layerNorm x i = 0 := by sorry
