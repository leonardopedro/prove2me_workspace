-- Generated from ChapterLimitCircleExample.lean — solution of BookProof.LimitCircleExample.hasDerivAt_lcQ'
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
open BookProof.LimitCircleExample




open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x : ℝ) : HasDerivAt lcQ' (-x) x := by

  have h : HasDerivAt (fun y : ℝ => -(1 + y ^ 2) / 2) (-(2 * x) / 2) x := by
    simpa using ((((hasDerivAt_pow 2 x).const_add 1).neg).div_const 2)
  have heq : -(2 * x) / 2 = -x := by ring
  rw [← heq]
  exact h
