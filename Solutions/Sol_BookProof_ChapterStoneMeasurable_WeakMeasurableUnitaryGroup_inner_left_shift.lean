-- Generated from ChapterStoneMeasurable.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.inner_left_shift
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_inner_map_map
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_apply_apply
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_apply_zero
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution (s t : ℝ) (x y : H) :
    ⟪ y, G.U s (G.U t x) ⟫_ℂ = ⟪ G.U (-s) y, G.U t x ⟫_ℂ := by

  have h := G.inner_map_map s (G.U (-s) y) (G.U t x)
  rw [G.apply_apply] at h
  simp only [add_neg_cancel] at h
  rw [G.apply_zero] at h
  rw [← h]
