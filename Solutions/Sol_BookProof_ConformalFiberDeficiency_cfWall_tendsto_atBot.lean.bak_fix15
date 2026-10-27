-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.cfWall_tendsto_atBot
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_cfWall_ge_exp
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : Tendsto cfWall atBot atTop := by

  refine tendsto_atTop_mono cfWall_ge_exp ?_
  have h1 : Tendsto (fun y : ℝ => Real.exp (-y)) atBot atTop :=
    Real.tendsto_exp_atTop.comp tendsto_neg_atBot_atTop
  simpa [div_eq_inv_mul] using h1.atTop_div_const (by norm_num : (0 : ℝ) < 12)
