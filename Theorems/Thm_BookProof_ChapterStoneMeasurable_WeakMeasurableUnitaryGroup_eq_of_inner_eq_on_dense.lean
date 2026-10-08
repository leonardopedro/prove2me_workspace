-- Generated from ChapterStoneConverse.lean — theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.eq_of_inner_eq_on_dense
import Mathlib
import Definitions.Def_ChapterStoneConverse
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable


open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable [CompleteSpace H] [TopologicalSpace.SeparableSpace H]
variable (G : WeakMeasurableUnitaryGroup H)

theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.eq_of_inner_eq_on_dense {D : Set H} (hD : Dense D) {v w : H}
    (h : ∀ z ∈ D, ⟪z, v⟫_ℂ = ⟪z, w⟫_ℂ) : v = w := by sorry
