-- Generated from ChapterTotalVariance.lean — theorem ChapterTotalVariance.between_nonneg
import Mathlib
import Definitions.Def_ChapterTotalVariance
import Definitions.Def_ChapterA4
open ChapterTotalVariance



open scoped BigOperators
open Finset

variable {Ω κ : Type*} [Fintype Ω] [DecidableEq κ]


theorem ChapterTotalVariance.between_nonneg (w : Ω → ℝ) (X : Ω → κ) (Y : Ω → ℝ) (hw : ∀ ω, 0 ≤ w ω) :
    0 ≤ between w X Y := by sorry
