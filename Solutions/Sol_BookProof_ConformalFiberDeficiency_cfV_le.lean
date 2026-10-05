-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.cfV_le
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (y : ℝ) : cfV y ≤ 1 / 4 - Real.exp (-(2 * y)) := by

  have hc : 0 < Real.cosh (y / 2) := Real.cosh_pos _
  have he : 0 < Real.exp (-y) := Real.exp_pos _
  have hsq : Real.exp (-(2 * y)) = Real.exp (-y) * Real.exp (-y) := by
    rw [← Real.exp_add]; ring_nf
  have h1 : 0 < 1 / (2 * Real.cosh (y / 2) ^ 2) := by positivity
  unfold cfV
  rw [hsq]
  nlinarith
