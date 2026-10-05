-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.cfV_tendsto_atTop
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_tendsto_cfSech_atTop
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : Tendsto cfV atTop (𝓝 (-(3 / 4))) := by

  have h0 : Tendsto (fun y : ℝ => 1 + Real.exp (-y)) atTop (𝓝 (1 + 0)) :=
    (tendsto_const_nhds (x := (1 : ℝ))).add Real.tendsto_exp_neg_atTop_nhds_zero
  have hB : Tendsto (fun y : ℝ => (1 + Real.exp (-y)) ^ 2) atTop (𝓝 1) := by
    simpa using h0.pow 2
  have h := ((tendsto_const_nhds (x := (1 / 4 : ℝ))).sub tendsto_cfSech_atTop).sub hB
  have hval : (1 / 4 : ℝ) - 0 - 1 = -(3 / 4) := by norm_num
  rw [hval] at h
  exact h
