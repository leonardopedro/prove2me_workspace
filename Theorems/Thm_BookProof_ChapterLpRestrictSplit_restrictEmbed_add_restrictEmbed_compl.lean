-- Generated from ChapterLpRestrictSplit.lean — theorem BookProof.ChapterLpRestrictSplit.restrictEmbed_add_restrictEmbed_compl
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterLpRestrictSplit
open BookProof.ChapterLpRestrictSplit

variable {α : Type*} [MeasurableSpace α] {mu : Measure α}


noncomputable section

open MeasureTheory


open BookProof.ChapterLinftyMultiplication


theorem BookProof.ChapterLpRestrictSplit.restrictEmbed_add_restrictEmbed_compl {A : Set α} (hA : MeasurableSet A)
    (u : Lp ℂ 2 mu) :
    restrictEmbed hA (restrictProj A u) + restrictEmbed hA.compl (restrictProj Aᶜ u) = u := by sorry
