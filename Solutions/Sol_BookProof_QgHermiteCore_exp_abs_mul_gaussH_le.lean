-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.exp_abs_mul_gaussH_le
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Theorems.Thm_BookProof_QgHermiteCore_exp_abs_le_const_mul_exp_sq
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterHermiteFunctions
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

set_option maxHeartbeats 1000000 in
theorem solution (c x : ℝ) :
    Real.exp (c * |x|) * gaussH x ≤ Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8) := by

  have h := exp_abs_le_const_mul_exp_sq c x
  have hg : (0 : ℝ) < gaussH x := gaussH_pos x
  calc Real.exp (c * |x|) * gaussH x
      ≤ (Real.exp (2 * c ^ 2) * Real.exp (x ^ 2 / 8)) * gaussH x := by
        exact mul_le_mul_of_nonneg_right h hg.le
    _ = Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8) := by
        simp only [gaussH, ← Real.exp_add]
        ring_nf
