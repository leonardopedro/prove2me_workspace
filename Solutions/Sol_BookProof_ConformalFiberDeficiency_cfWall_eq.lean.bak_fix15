-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.cfWall_eq
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_cosh_half_ne_zero
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (y : ℝ) :
    cfWall y = 1 / (48 * Real.cosh (y / 2) ^ 2) + ((1 + Real.exp (-y)) ^ 2 - 1) / 24 := by

  have hc0 : Real.cosh (y / 2) ≠ 0 := cosh_half_ne_zero y
  unfold cfWall cfV
  field_simp
  ring
