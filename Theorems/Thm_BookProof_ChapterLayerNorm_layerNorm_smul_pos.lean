-- Generated from ChapterLayerNorm.lean — theorem BookProof.ChapterLayerNorm.layerNorm_smul_pos
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


theorem BookProof.ChapterLayerNorm.layerNorm_smul_pos {a : ℝ} (ha : 0 < a) (x : Fin d → ℝ) (i : Fin d) :
    layerNorm (fun i => a * x i) i = layerNorm x i := by sorry
