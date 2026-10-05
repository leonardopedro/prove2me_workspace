-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.hasDerivAt_cfP'
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_cosh_half_ne_zero
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (y : ℝ) : HasDerivAt cfP' (cfP'' y) y := by

  have hs : HasDerivAt (fun t : ℝ => Real.sinh (t / 2)) (Real.cosh (y / 2) * (1 / 2)) y := by
    have h := (Real.hasDerivAt_sinh (y / 2)).comp y ((hasDerivAt_id y).div_const 2)
    exact h
  have hc : HasDerivAt (fun t : ℝ => 2 * Real.cosh (t / 2))
      (2 * (Real.sinh (y / 2) * (1 / 2))) y := by
    have h :=
      ((Real.hasDerivAt_cosh (y / 2)).comp y ((hasDerivAt_id y).div_const 2)).const_mul 2
    exact h
  have hcne : (2 : ℝ) * Real.cosh (y / 2) ≠ 0 := by
    have := Real.cosh_pos (y / 2); positivity
  have h := (hs.div hc hcne).neg
  have hc0 : Real.cosh (y / 2) ≠ 0 := cosh_half_ne_zero y
  have hid : Real.sinh (y / 2) ^ 2 = Real.cosh (y / 2) ^ 2 - 1 := by
    have := Real.cosh_sq (y / 2); linarith
  have hnum : Real.cosh (y / 2) * (1 / 2) * (2 * Real.cosh (y / 2))
      - Real.sinh (y / 2) * (2 * (Real.sinh (y / 2) * (1 / 2))) = 1 := by
    nlinarith [hid]
  have hden : (2 * Real.cosh (y / 2)) ^ 2 = 4 * Real.cosh (y / 2) ^ 2 := by ring
  have hval : -((Real.cosh (y / 2) * (1 / 2) * (2 * Real.cosh (y / 2))
        - Real.sinh (y / 2) * (2 * (Real.sinh (y / 2) * (1 / 2)))) / (2 * Real.cosh (y / 2)) ^ 2)
      = cfP'' y := by
    unfold cfP''
    rw [hnum, hden]
  have hfun : -((fun t : ℝ => Real.sinh (t / 2))
      / (fun t : ℝ => 2 * Real.cosh (t / 2))) = cfP' := rfl
  rw [hfun] at h
  rwa [hval] at h
