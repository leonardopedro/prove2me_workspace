-- Generated from ChapterLimitCircleExample.lean — solution of BookProof.LimitCircleExample.hasDerivAt_lcP
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
import Theorems.Thm_BookProof_LimitCircleExample_one_add_sq_pos
open BookProof.LimitCircleExample




open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x : ℝ) : HasDerivAt lcP (lcP' x) x := by

  have h1 : HasDerivAt Real.arctan (1 / (1 + x ^ 2)) x := by
    simpa using Real.hasDerivAt_arctan x
  have h2 : HasDerivAt (fun y : ℝ => 1 + y ^ 2) (2 * x) x := by
    simpa using (hasDerivAt_pow 2 x).const_add 1
  have h3 : HasDerivAt (fun y : ℝ => Real.log (1 + y ^ 2)) (2 * x / (1 + x ^ 2)) x :=
    h2.log (ne_of_gt (one_add_sq_pos x))
  have h4 := h1.sub (h3.div_const 2)
  have heq : 1 / (1 + x ^ 2) - (2 * x / (1 + x ^ 2)) / 2 = lcP' x := by
    unfold lcP'
    have := (one_add_sq_pos x).ne'
    field_simp
  rw [← heq]
  exact h4
