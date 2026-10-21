-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.memLp_cfSol
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_cfSol_sq_le
import Theorems.Thm_BookProof_ConformalFiberDeficiency_continuous_cfSol
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : MemLp cfSol 2 (volume : Measure ℝ) := by

  refine (memLp_two_iff_integrable_sq_norm continuous_cfSol.aestronglyMeasurable).2 ?_
  have hg : Integrable (fun x : ℝ => 4 * (1 + x ^ 2)⁻¹) volume :=
    integrable_inv_one_add_sq.const_mul _
  refine Integrable.mono' hg ((continuous_cfSol.norm.pow 2).aestronglyMeasurable) ?_
  filter_upwards with x
  rw [Real.norm_eq_abs, abs_of_nonneg (by positivity)]
  exact cfSol_sq_le x
