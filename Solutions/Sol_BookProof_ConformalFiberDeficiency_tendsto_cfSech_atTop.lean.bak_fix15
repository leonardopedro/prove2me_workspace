-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.tendsto_cfSech_atTop
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_cfSech_le
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    Tendsto (fun y : ℝ => 1 / (2 * Real.cosh (y / 2) ^ 2)) atTop (𝓝 0) :=
  squeeze_zero (fun t => by have := Real.cosh_pos (t / 2); positivity) cfSech_le
      (by simpa using Real.tendsto_exp_neg_atTop_nhds_zero.const_mul (2 : ℝ))
