-- Generated from ChapterLayerNorm.lean — theorem BookProof.ChapterLayerNorm.mean_layerNorm
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


theorem BookProof.ChapterLayerNorm.mean_layerNorm (hd : 0 < d) (x : Fin d → ℝ) : mean (layerNorm x) = 0 := by sorry
