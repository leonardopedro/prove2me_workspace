-- Generated from ChapterLimitCircleExample.lean — solution of BookProof.LimitCircleExample.hasDerivAt_lcSol
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
import Theorems.Thm_BookProof_LimitCircleExample_hasDerivAt_lcLogFun
open BookProof.LimitCircleExample




open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x : ℝ) : HasDerivAt lcSol (lcLog' x * lcSol x) x := by

  have h := (hasDerivAt_lcLogFun x).cexp
  have hval : Complex.exp (((lcP x : ℝ) : ℂ) + Complex.I * ((lcQ x : ℝ) : ℂ))
      = lcSol x := by rfl
  have hfun : (fun t : ℝ => Complex.exp (((lcP t : ℝ) : ℂ) + Complex.I * ((lcQ t : ℝ) : ℂ)))
      = lcSol := by
    funext t; rfl
  rw [hfun] at h
  have hval : Complex.exp (((lcP x : ℝ) : ℂ) + Complex.I * ((lcQ x : ℝ) : ℂ)) = lcSol x := by rfl
  rw [hval, mul_comm] at h
  exact h
