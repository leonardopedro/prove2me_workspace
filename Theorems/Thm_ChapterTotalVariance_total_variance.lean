-- Generated from ChapterTotalVariance.lean — theorem ChapterTotalVariance.total_variance
import Mathlib
import Definitions.Def_ChapterTotalVariance
import Definitions.Def_ChapterA4
open ChapterTotalVariance

variable {Ω κ : Type*} [Fintype Ω] [DecidableEq κ]



open scoped BigOperators
open Finset


theorem ChapterTotalVariance.total_variance [Finite κ] (w : Ω → ℝ) (X : Ω → κ) (Y : Ω → ℝ)
    (hw : ∀ ω, 0 ≤ w ω) :
    variance w Y = within w X Y + between w X Y := by sorry
