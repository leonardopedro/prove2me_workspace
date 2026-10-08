-- Generated from ChapterBornMeasure.lean — theorem BookProof.ChapterBornMeasure.bornMeasure_iUnion
import Mathlib
import Definitions.Def_ChapterBornMeasure
open BookProof.ChapterBornMeasure


open MeasureTheory
open scoped ENNReal


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


theorem BookProof.ChapterBornMeasure.bornMeasure_iUnion (psi : Lp ℂ 2 μ) {s : ℕ → Set α}
    (hs : ∀ n, MeasurableSet (s n)) (hd : Pairwise (Function.onFun Disjoint s)) :
    bornMeasure psi (⋃ n, s n) = ∑' n, bornMeasure psi (s n) := by sorry
