-- Generated from ChapterLpRestrictSplit.lean — theorem BookProof.ChapterLpRestrictSplit.orthogonalFamily_splitEmbed
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterLpRestrictSplit
open BookProof.ChapterLpRestrictSplit


noncomputable section

open MeasureTheory


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {mu : Measure α}


theorem BookProof.ChapterLpRestrictSplit.orthogonalFamily_splitEmbed {A : Set α} (hA : MeasurableSet A) :
    OrthogonalFamily ℂ (fun b : Bool => Lp ℂ 2 (mu.restrict (splitSet A b)))
      (splitEmbed hA) := by sorry
