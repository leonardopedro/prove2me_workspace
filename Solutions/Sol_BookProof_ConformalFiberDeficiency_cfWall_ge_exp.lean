-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.cfWall_ge_exp
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_cfWall_eq
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (y : ℝ) : Real.exp (-y) / 12 ≤ cfWall y := by

  have hc : 0 < Real.cosh (y / 2) := Real.cosh_pos _
  have he : 0 < Real.exp (-y) := Real.exp_pos _
  rw [cfWall_eq]
  have h1 : 0 < 1 / (48 * Real.cosh (y / 2) ^ 2) := by positivity
  have h2 : Real.exp (-y) / 12 ≤ ((1 + Real.exp (-y)) ^ 2 - 1) / 24 := by nlinarith
  linarith
