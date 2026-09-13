-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.tendsto_exp_abs_mul_gaussH_atTop
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Theorems.Thm_BookProof_QgHermiteCore_exp_abs_mul_gaussH_le
import Theorems.Thm_BookProof_QgHermiteCore_ExpBounded_const_mul
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterHermiteFunctions
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

set_option maxHeartbeats 1000000 in
theorem solution (c : ℝ) :
    Tendsto (fun x : ℝ => Real.exp (c * |x|) * gaussH x) atTop (𝓝 0) := by

  have h1 : Tendsto (fun x : ℝ => -x ^ 2 / 8) atTop atBot := by
    have hsq : Tendsto (fun x : ℝ => x ^ 2) atTop atTop := tendsto_pow_atTop (by norm_num)
    have : Tendsto (fun x : ℝ => -x ^ 2) atTop atBot := tendsto_neg_atTop_atBot.comp hsq
    simpa using this.atBot_div_const (by norm_num : (0:ℝ) < 8)
  have hlim : Tendsto (fun x : ℝ => Real.exp (2 * c ^ 2) * Real.exp (-x ^ 2 / 8)) atTop
      (𝓝 0) := by
    simpa using (Real.tendsto_exp_atBot.comp h1).const_mul (Real.exp (2 * c ^ 2))
  refine squeeze_zero (fun x => ?_) (fun x => exp_abs_mul_gaussH_le c x) hlim
  have := gaussH_pos x
  positivity
