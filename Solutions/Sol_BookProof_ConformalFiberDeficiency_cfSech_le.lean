-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.cfSech_le
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) : 1 / (2 * Real.cosh (t / 2) ^ 2) ≤ 2 * Real.exp (-t) := by

  have hct : 0 < Real.cosh (t / 2) := Real.cosh_pos _
  have h1 : Real.exp (t / 2) / 2 ≤ Real.cosh (t / 2) := by
    rw [Real.cosh_eq]
    have := Real.exp_pos (-(t / 2))
    linarith
  have hexp : Real.exp (t / 2) * Real.exp (t / 2) = Real.exp t := by
    rw [← Real.exp_add]; ring_nf
  have hrw : 2 * Real.exp (-t) = 2 / Real.exp t := by
    rw [Real.exp_neg]; ring
  rw [hrw, div_le_div_iff₀ (by positivity) (Real.exp_pos t)]
  nlinarith [Real.exp_pos (t / 2)]
