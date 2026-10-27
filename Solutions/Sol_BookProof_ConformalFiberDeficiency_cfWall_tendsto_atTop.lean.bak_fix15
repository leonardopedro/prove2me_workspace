-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.cfWall_tendsto_atTop
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_cfV_tendsto_atTop
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : Tendsto cfWall atTop (𝓝 0) := by

  have h := cfV_tendsto_atTop
  have h2 : Tendsto (fun y => -(cfV y) / 24 - 1 / 32) atTop (𝓝 (-(-(3 / 4)) / 24 - 1 / 32)) :=
    ((h.neg).div_const 24).sub_const _
  have hval : -(-(3 / 4 : ℝ)) / 24 - 1 / 32 = 0 := by norm_num
  rw [hval] at h2
  exact h2
