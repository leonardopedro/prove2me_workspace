-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.cfSol_sq_le
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_norm_cfSol
import Theorems.Thm_BookProof_ConformalFiberDeficiency_sq_le_sinh_sq
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (y : ℝ) : ‖cfSol y‖ ^ 2 ≤ 4 * (1 + y ^ 2)⁻¹ := by

  have hid : Real.cosh (y / 2) ^ 2 = Real.sinh (y / 2) ^ 2 + 1 := Real.cosh_sq _
  have hs := sq_le_sinh_sq (y / 2)
  have hpos : (0 : ℝ) < 1 + y ^ 2 := by positivity
  have hrw : (4 : ℝ) * (1 + y ^ 2)⁻¹ = 4 / (1 + y ^ 2) := by
    rw [inv_eq_one_div]; ring
  rw [norm_cfSol, div_pow, one_pow, hrw, div_le_div_iff₀ (by positivity) hpos]
  nlinarith
