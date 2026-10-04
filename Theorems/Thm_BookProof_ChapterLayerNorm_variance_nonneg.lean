-- Generated from ChapterLayerNorm.lean — theorem BookProof.ChapterLayerNorm.variance_nonneg
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




theorem BookProof.ChapterLayerNorm.variance_nonneg (x : Fin d → ℝ) : 0 ≤ variance x := by sorry
