-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.cfV_tendsto_atBot
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_cfV_le
import Theorems.Thm_BookProof_ConformalFiberDeficiency_tendsto_exp_neg_two_atBot
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : Tendsto cfV atBot atBot := by

  refine tendsto_atBot_mono cfV_le ?_
  have h := tendsto_neg_atTop_atBot.comp tendsto_exp_neg_two_atBot
  have h2 := tendsto_atBot_add_const_left atBot (1 / 4 : ℝ) h
  simpa [Function.comp, sub_eq_add_neg] using h2
