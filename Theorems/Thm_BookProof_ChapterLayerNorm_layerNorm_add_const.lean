-- Generated from ChapterLayerNorm.lean — theorem BookProof.ChapterLayerNorm.layerNorm_add_const
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




theorem BookProof.ChapterLayerNorm.layerNorm_add_const (hd : 0 < d) (x : Fin d → ℝ) (c : ℝ) (i : Fin d) :
    layerNorm (fun i => x i + c) i = layerNorm x i := by sorry
