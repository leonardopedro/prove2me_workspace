-- Generated from ChapterBornMeasure.lean — solution of BookProof.ChapterBornMeasure.bornMeasure_iUnion
import Mathlib
import Definitions.Def_ChapterBornMeasure
open BookProof.ChapterBornMeasure



open MeasureTheory
open scoped ENNReal


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution (psi : Lp ℂ 2 μ) {s : ℕ → Set α}
    (hs : ∀ n, MeasurableSet (s n)) (hd : Pairwise (Function.onFun Disjoint s)) :
    bornMeasure psi (⋃ n, s n) = ∑' n, bornMeasure psi (s n) := measure_iUnion hd hs
