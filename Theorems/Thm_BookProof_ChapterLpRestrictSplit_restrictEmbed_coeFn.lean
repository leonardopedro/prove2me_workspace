-- Generated from ChapterLpRestrictSplit.lean — theorem BookProof.ChapterLpRestrictSplit.restrictEmbed_coeFn
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterLpRestrictSplit
open BookProof.ChapterLpRestrictSplit


noncomputable section

open MeasureTheory


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {mu : Measure α}


theorem BookProof.ChapterLpRestrictSplit.restrictEmbed_coeFn {A : Set α} (hA : MeasurableSet A) (u : Lp ℂ 2 (mu.restrict A)) :
    (restrictEmbed hA u : α → ℂ) =ᵐ[mu] A.indicator (u : α → ℂ) := by sorry
