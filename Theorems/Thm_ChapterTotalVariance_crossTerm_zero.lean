-- Generated from ChapterTotalVariance.lean — theorem ChapterTotalVariance.crossTerm_zero
import Mathlib
import Definitions.Def_ChapterTotalVariance
import Definitions.Def_ChapterA4
open ChapterTotalVariance

variable {Ω κ : Type*} [Fintype Ω] [DecidableEq κ]



open scoped BigOperators
open Finset


theorem ChapterTotalVariance.crossTerm_zero [Finite κ] (w : Ω → ℝ) (X : Ω → κ) (Y : Ω → ℝ)
    (hw : ∀ ω, 0 ≤ w ω) :
    (∑ ω, w ω * (Y ω - condMean w X Y (X ω)) * (condMean w X Y (X ω) - mean w Y))
      = 0 := by sorry
