-- Generated from ChapterLpRestrictSplit.lean — theorem BookProof.ChapterLpRestrictSplit.inner_restrictEmbed_eq_zero
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterLpRestrictSplit
open BookProof.ChapterLpRestrictSplit

variable {α : Type*} [MeasurableSpace α] {mu : Measure α}


noncomputable section

open MeasureTheory


open BookProof.ChapterLinftyMultiplication


theorem BookProof.ChapterLpRestrictSplit.inner_restrictEmbed_eq_zero {A B : Set α} (hA : MeasurableSet A) (hB : MeasurableSet B)
    (hAB : Disjoint A B) (u : Lp ℂ 2 (mu.restrict A)) (v : Lp ℂ 2 (mu.restrict B)) :
    inner ℂ (restrictEmbed hA u) (restrictEmbed hB v) = 0 := by sorry
