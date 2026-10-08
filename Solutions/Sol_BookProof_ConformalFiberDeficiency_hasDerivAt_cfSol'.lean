-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.hasDerivAt_cfSol'
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_hasDerivAt_cfSol
import Theorems.Thm_BookProof_ConformalFiberDeficiency_cfLog_ode
import Theorems.Thm_BookProof_ConformalFiberDeficiency_hasDerivAt_cfLog_prime
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (y : ℝ) :
    HasDerivAt (fun t => cfLog' t * cfSol t)
      ((((cfV y : ℝ) : ℂ) - Complex.I) * cfSol y) y := by

  have h := (hasDerivAt_cfLog_prime y).mul (hasDerivAt_cfSol y)
  have hval : (((cfP'' y : ℝ) : ℂ) + Complex.I * ((-Real.exp (-y) : ℝ) : ℂ)) * cfSol y
      + cfLog' y * (cfLog' y * cfSol y)
      = (((cfV y : ℝ) : ℂ) - Complex.I) * cfSol y := by
    have hode := cfLog_ode y
    linear_combination cfSol y * hode
  rw [← hval]
  exact h
