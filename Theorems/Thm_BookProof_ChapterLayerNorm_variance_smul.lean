-- Generated from ChapterLayerNorm.lean — theorem BookProof.ChapterLayerNorm.variance_smul
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




theorem BookProof.ChapterLayerNorm.variance_smul (a : ℝ) (x : Fin d → ℝ) :
    variance (fun i => a * x i) = a ^ 2 * variance x := by sorry
