-- Generated from ChapterStoneMeasurable.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.inner_apply_avgVec
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_apply_apply
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_inner_avgVec
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_inner_adjoint
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace H] (s a : ℝ) (x y : H) :
    ⟪ y, G.U s (G.avgVec x a) ⟫_ℂ = ∫ t in s..(s + a), ⟪ y, G.U t x ⟫_ℂ := by

  rw [G.inner_adjoint, G.inner_avgVec]
  have h : (fun t => ⟪ G.U (-s) y, G.U t x ⟫_ℂ) = fun t => ⟪ y, G.U (s + t) x ⟫_ℂ := by
    funext t
    rw [← G.apply_apply s t x]
    exact (G.inner_adjoint s y (G.U t x)).symm
  rw [h]
  have hc := intervalIntegral.integral_comp_add_left
    (f := fun u => ⟪ y, G.U u x ⟫_ℂ) (a := (0 : ℝ)) (b := a) s
  simpa using hc
