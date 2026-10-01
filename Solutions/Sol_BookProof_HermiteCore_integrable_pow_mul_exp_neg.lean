-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.integrable_pow_mul_exp_neg
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
y ^ 2 / 4) (-(x / 2)) x := by
    have h0 : HasDerivAt (fun y : ℝ => -y ^ 2 / 4) (-(2 * x) / 4) x := by
      simpa using ((hasDerivAt_pow 2 x).neg).div_const 4
    convert h0 using 1 :=
    ring
    show HasDerivAt (fun y : ℝ => Real.exp (-y ^ 2 / 4)) (-(x / 2) * Real.exp (-x ^ 2 / 4)) x
    simpa [mul_comm] using h.exp
  
  /-- Every monomial is integrable against a Gaussian. -/
  theorem integrable_pow_mul_exp_neg (k : ℕ) {b : ℝ} (hb : 0 < b) :
      Integrable (fun x : ℝ => x ^ k * Real.exp (-b * x ^ 2)) := by
    have hdom : Integrable
        (fun x : ℝ => ((k.factorial : ℝ) * Real.exp (1 / (2 * b))) * Real.exp (-(b / 2) * x ^ 2)) :=
      (integrable_exp_neg_mul_sq (by positivity)).const_mul _
    refine hdom.mono' (Continuous.aestronglyMeasurable (by fun_prop)) ?_
    filter_upwards with x
    have hfac : (0 : ℝ) < (k.factorial : ℝ) := by positivity
    have h1 : |x| ^ k ≤ (k.factorial : ℝ) * Real.exp |x| := by
      have h := Real.pow_div_factorial_le_exp |x| (abs_nonneg x) k
      rw [div_le_iff₀ hfac] at h
      linarith [h]
    have h2 : |x| - b * x ^ 2 ≤ 1 / (2 * b) - (b / 2) * x ^ 2 := by
      have hx2 : x ^ 2 = |x| ^ 2 := (sq_abs x).symm
      rw [hx2, ← sub_nonneg]
      have key : 1 / (2 * b) - b / 2 * |x| ^ 2 - (|x| - b * |x| ^ 2)
          = (b * |x| - 1) ^ 2 / (2 * b) := by
        field_simp
        ring
      rw [key]
      positivity
    have hnorm : ‖x ^ k * Real.exp (-b * x ^ 2)‖ = |x| ^ k * Real.exp (-b * x ^ 2) := by
      rw [norm_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_pow, abs_of_pos (Real.exp_pos _)]
    rw [hnorm]
    calc |x| ^ k * Real.exp (-b * x ^ 2)
        ≤ ((k.factorial : ℝ) * Real.exp |x|) * Real.exp (-b * x ^ 2) := by gcongr
      _ = (k.factorial :
