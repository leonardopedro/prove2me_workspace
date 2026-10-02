-- Generated from ChapterStoneMeasurable.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.tendsto_apply_avgVec
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_norm_apply_avgVec_sub_le
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (G : WeakMeasurableUnitaryGroup H)

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace H] (x : H) (a : ℝ) :
    Tendsto (fun s : ℝ => G.U s (G.avgVec x a)) (𝓝 0) (𝓝 (G.avgVec x a)) := by

  rw [tendsto_iff_norm_sub_tendsto_zero]
  have hbd : Tendsto (fun s : ℝ => 2 * |s| * ‖x‖) (𝓝 0) (𝓝 0) := by
    have hcont : Continuous (fun s : ℝ => 2 * |s| * ‖x‖) := by fun_prop
    simpa using hcont.tendsto 0
  exact squeeze_zero (fun s => norm_nonneg _) (fun s => G.norm_apply_avgVec_sub_le s a x) hbd
