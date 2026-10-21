-- Generated from ChapterLimitCircleExample.lean — solution of BookProof.LimitCircleExample.memLp_lcSol
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
import Theorems.Thm_BookProof_LimitCircleExample_lcSol_sq_le
import Theorems.Thm_BookProof_LimitCircleExample_continuous_lcSol
open BookProof.LimitCircleExample




open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : MemLp lcSol 2 (volume : Measure ℝ) := by

  refine (memLp_two_iff_integrable_sq_norm
    continuous_lcSol.aestronglyMeasurable).2 ?_
  have hg : Integrable (fun x : ℝ => Real.exp π * (1 + x ^ 2)⁻¹) volume :=
    integrable_inv_one_add_sq.const_mul _
  refine Integrable.mono' hg ((continuous_lcSol.norm.pow 2).aestronglyMeasurable) ?_
  filter_upwards with x
  rw [Real.norm_eq_abs, abs_of_nonneg (by positivity)]
  exact lcSol_sq_le x
