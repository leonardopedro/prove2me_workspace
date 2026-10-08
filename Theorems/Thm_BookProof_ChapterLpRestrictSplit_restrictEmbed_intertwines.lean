-- Generated from ChapterLpRestrictSplit.lean — theorem BookProof.ChapterLpRestrictSplit.restrictEmbed_intertwines
import Mathlib
import Definitions.Def_ChapterLpRestrictSplit
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterLpRestrictSplit


noncomputable section

open MeasureTheory


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {mu : Measure α}


theorem BookProof.ChapterLpRestrictSplit.restrictEmbed_intertwines {A : Set α} (hA : MeasurableSet A) {g : α → ℂ}
    (hg : MemLp g ⊤ mu) (u : Lp ℂ 2 (mu.restrict A)) :
    restrictEmbed hA (multOp g (hg.restrict A) u) = multOp g hg (restrictEmbed hA u) := by sorry
