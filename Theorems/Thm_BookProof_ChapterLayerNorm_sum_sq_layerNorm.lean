-- Generated from ChapterLayerNorm.lean — theorem BookProof.ChapterLayerNorm.sum_sq_layerNorm
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




theorem BookProof.ChapterLayerNorm.sum_sq_layerNorm (hd : 0 < d) {x : Fin d → ℝ} (hx : 0 < variance x) :
    ∑ i, (layerNorm x i) ^ 2 = (d : ℝ) := by sorry
