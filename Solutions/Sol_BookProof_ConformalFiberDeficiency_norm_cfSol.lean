-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.norm_cfSol
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (y : ℝ) : ‖cfSol y‖ = 1 / Real.cosh (y / 2) := by

  rw [cfSol, Complex.norm_exp]
  have h : (((cfP y : ℝ) : ℂ) + Complex.I * ((cfQ y : ℝ) : ℂ)).re = cfP y := by simp
  rw [h, cfP, Real.exp_neg, Real.exp_log (Real.cosh_pos _)]
  ring
