-- Generated from ChapterTotalVariance.lean — theorem ChapterTotalVariance.variance_nonneg
import Mathlib
import Definitions.Def_ChapterTotalVariance
import Definitions.Def_ChapterA4
open ChapterTotalVariance

variable {Ω κ : Type*} [Fintype Ω] [DecidableEq κ]



open scoped BigOperators
open Finset


theorem ChapterTotalVariance.variance_nonneg (w Y : Ω → ℝ) (hw : ∀ ω, 0 ≤ w ω) :
    0 ≤ variance w Y := by sorry
