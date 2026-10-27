-- Generated from ChapterLimitCircleExample.lean — solution of BookProof.LimitCircleExample.hasDerivAt_lcQ
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
open BookProof.LimitCircleExample




open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x : ℝ) : HasDerivAt lcQ (lcQ' x) x := by

  have h : HasDerivAt (fun y : ℝ => -(y + y ^ 3 / 3) / 2) (-(1 + 3 * x ^ 2 / 3) / 2) x := by
    simpa using (((hasDerivAt_id x).add ((hasDerivAt_pow 3 x).div_const 3)).neg.div_const 2)
  have heq : -(1 + 3 * x ^ 2 / 3) / 2 = lcQ' x := by unfold lcQ'; ring
  rw [← heq]
  exact h
