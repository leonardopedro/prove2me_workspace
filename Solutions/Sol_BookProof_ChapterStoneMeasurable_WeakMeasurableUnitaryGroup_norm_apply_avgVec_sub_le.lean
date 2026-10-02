-- Generated from ChapterStoneMeasurable.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.norm_apply_avgVec_sub_le
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Theorems.Thm_BookProof_ChapterStoneMeasurable_norm_le_of_inner_self_bound
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_norm_inner_apply_avgVec_sub_le
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (G : WeakMeasurableUnitaryGroup H)

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace H] (s a : ℝ) (x : H) :
    ‖G.U s (G.avgVec x a) - G.avgVec x a‖ ≤ 2 * |s| * ‖x‖ := by

  refine norm_le_of_inner_self_bound (by positivity) ?_
  exact G.norm_inner_apply_avgVec_sub_le s a x _
