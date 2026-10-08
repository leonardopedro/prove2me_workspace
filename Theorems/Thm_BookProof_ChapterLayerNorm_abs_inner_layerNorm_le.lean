-- Generated from ChapterLayerNorm.lean — theorem BookProof.ChapterLayerNorm.abs_inner_layerNorm_le
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


theorem BookProof.ChapterLayerNorm.abs_inner_layerNorm_le (hd : 0 < d) {x y : Fin d → ℝ} (hx : 0 < variance x)
    (hy : 0 < variance y) :
    |∑ i, layerNorm x i * layerNorm y i| ≤ (d : ℝ) := by sorry
