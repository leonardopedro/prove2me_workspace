-- Generated from ChapterLayerNorm.lean — theorem BookProof.ChapterLayerNorm.mean_smul
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




theorem BookProof.ChapterLayerNorm.mean_smul (a : ℝ) (x : Fin d → ℝ) : mean (fun i => a * x i) = a * mean x := by sorry
