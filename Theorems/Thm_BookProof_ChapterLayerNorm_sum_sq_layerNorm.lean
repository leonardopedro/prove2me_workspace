-- Generated from ChapterLayerNorm.lean — theorem BookProof.ChapterLayerNorm.sum_sq_layerNorm
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


theorem BookProof.ChapterLayerNorm.sum_sq_layerNorm (hd : 0 < d) {x : Fin d → ℝ} (hx : 0 < variance x) :
    ∑ i, (layerNorm x i) ^ 2 = (d : ℝ) := by sorry
