-- Generated from ChapterStoneConverse.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.eq_of_inner_eq_on_dense
import Mathlib
import Definitions.Def_ChapterStoneConverse
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable [CompleteSpace H] [TopologicalSpace.SeparableSpace H]
variable (G : WeakMeasurableUnitaryGroup H)

set_option maxHeartbeats 1000000 in
theorem solution {D : Set H} (hD : Dense D) {v w : H}
    (h : ∀ z ∈ D, ⟪z, v⟫_ℂ = ⟪z, w⟫_ℂ) : v = w :=
  ⟪z, w⟫_ℂ) : v = w := by
    have hcont1 : Continuous fun z : H => ⟪z, v⟫_ℂ := continuous_id.inner continuous_const
    have hcont2 : Continuous fun z : H => ⟪z, w⟫_ℂ := continuous_id.inner continuous_const
    have hall := Continuous.ext_on hD hcont1 hcont2 h
    have h2 : ⟪v - w, v⟫_ℂ = ⟪v - w, w⟫_ℂ := congrFun hall (v - w)
    have h3 : ⟪v - w, v - w⟫_ℂ = 0 := by rw [inner_sub_right, h2, sub_self]
    exact sub_eq_zero.mp (i
