-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.exp_abs_le_const_mul_exp_sq
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

set_option maxHeartbeats 1000000 in
theorem solution (c x : ℝ) :
    Real.exp (c * |x|) ≤ Real.exp (2 * c ^ 2) * Real.exp (x ^ 2 / 8) := by

  rw [← Real.exp_add]
  refine Real.exp_le_exp.mpr ?_
  nlinarith [sq_nonneg (|x| - 4 * c), abs_nonneg x, sq_abs x]
