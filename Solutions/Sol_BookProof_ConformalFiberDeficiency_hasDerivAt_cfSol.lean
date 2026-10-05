-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.hasDerivAt_cfSol
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_hasDerivAt_cfLogFun
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (y : ℝ) : HasDerivAt cfSol (cfLog' y * cfSol y) y := by

  have h := (hasDerivAt_cfLogFun y).cexp
  have hfun : (fun t : ℝ => Complex.exp (((cfP t : ℝ) : ℂ) + Complex.I * ((cfQ t : ℝ) : ℂ)))
      = cfSol := rfl
  rw [hfun] at h
  have hval : Complex.exp (((cfP y : ℝ) : ℂ) + Complex.I * ((cfQ y : ℝ) : ℂ))
      = cfSol y := rfl
  rw [hval, mul_comm] at h
  exact h
