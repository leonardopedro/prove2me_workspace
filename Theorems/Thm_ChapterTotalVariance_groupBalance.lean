-- Generated from ChapterTotalVariance.lean — theorem ChapterTotalVariance.groupBalance
import Mathlib
import Definitions.Def_ChapterTotalVariance
import Definitions.Def_ChapterA4
open ChapterTotalVariance

variable {Ω κ : Type*} [Fintype Ω] [DecidableEq κ]



open scoped BigOperators
open Finset


theorem ChapterTotalVariance.groupBalance (w : Ω → ℝ) (X : Ω → κ) (Y : Ω → ℝ)
    (hw : ∀ ω, 0 ≤ w ω) (g : κ) :
    (∑ ω, if X ω = g then w ω * (Y ω - condMean w X Y g) else 0) = 0 := by sorry
