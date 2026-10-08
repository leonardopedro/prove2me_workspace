-- Generated from ChapterLayerNorm.lean — theorem BookProof.ChapterLayerNorm.mean_smul
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


theorem BookProof.ChapterLayerNorm.mean_smul (a : ℝ) (x : Fin d → ℝ) : mean (fun i => a * x i) = a * mean x := by sorry
