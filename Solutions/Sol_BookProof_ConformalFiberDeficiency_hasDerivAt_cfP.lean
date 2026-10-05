-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.hasDerivAt_cfP
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_cosh_half_ne_zero
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (y : ℝ) : HasDerivAt cfP (cfP' y) y := by

  have hc : HasDerivAt (fun t : ℝ => Real.cosh (t / 2)) (Real.sinh (y / 2) * (1 / 2)) y := by
    have h := (Real.hasDerivAt_cosh (y / 2)).comp y ((hasDerivAt_id y).div_const 2)
    exact h
  have hlog := (hc.log (cosh_half_ne_zero y)).neg
  have hcne : Real.cosh (y / 2) ≠ 0 := cosh_half_ne_zero y
  have hder : -(Real.sinh (y / 2) * (1 / 2) / Real.cosh (y / 2)) = cfP' y := by
    unfold cfP'
    field_simp
  show HasDerivAt (fun t : ℝ => -(Real.log (Real.cosh (t / 2)))) _ y
  rwa [hder] at hlog
