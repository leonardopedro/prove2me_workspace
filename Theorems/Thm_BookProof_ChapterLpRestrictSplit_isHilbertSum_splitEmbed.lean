-- Generated from ChapterLpRestrictSplit.lean — theorem BookProof.ChapterLpRestrictSplit.isHilbertSum_splitEmbed
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterLpRestrictSplit
open BookProof.ChapterLpRestrictSplit

variable {α : Type*} [MeasurableSpace α] {mu : Measure α}


noncomputable section

open MeasureTheory


open BookProof.ChapterLinftyMultiplication


theorem BookProof.ChapterLpRestrictSplit.isHilbertSum_splitEmbed {A : Set α} (hA : MeasurableSet A) :
    IsHilbertSum ℂ (fun b : Bool => Lp ℂ 2 (mu.restrict (splitSet A b))) (splitEmbed hA) := by sorry
