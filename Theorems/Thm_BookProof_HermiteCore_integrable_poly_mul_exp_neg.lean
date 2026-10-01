-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.integrable_poly_mul_exp_neg
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore

import Mathlib

theorem BookProof.HermiteCore.integrable_poly_mul_exp_neg (n : ℕ) :
    derivative (hermiteR (n + 1)) = C ((n : ℝ) + 1) * hermiteR n := by
  induction n with
  | zero => simp [hermiteR_one, hermiteR_zero]
  | succ n ih =>
    have key : derivative (hermiteR (n + 1 + 1))
        = hermiteR (n + 1) + C ((n : ℝ) + 1) * (X * hermiteR n - derivative (hermiteR n)) := by
      rw [hermiteR_succ (n + 1), derivative_sub, derivative_mul, derivative_X, ih,
        derivative_C_mul]
      ring
    have hC : (C (((n : ℝ) + 1) + 1) : Polynomial ℝ) = C ((n : ℝ) + 1) + 1 := by
      rw [map_add, map_one]
    rw [key, ← hermiteR_succ n]
    push_cast
    rw [hC]
    ring

/-- The Hermite differential equation `H_n'' − X H_n' + n H_n = 0`. -/
theorem hermiteR_ode (n : ℕ) :
    derivative (derivative (hermiteR n)) - X * derivative (hermiteR n) + C (n : ℝ) * hermiteR n
      = 0 := by
  have h := derivative_hermiteR n
  rw [hermiteR_succ n, derivative_sub, derivative_mul, derivative_X] at h
  have hC : (C ((n : ℝ) + 1) : Polynomial ℝ) = C (n : ℝ) + 1 := by rw [map_add, map_one]
  rw [hC] at h
  linear_combination -h

/-! ## The Gaussian weights -/

/-- The Gaussian weight `e^{-x²/2}` of the Hermite polynomials. -/
def gaussW (x : ℝ) : ℝ := Real.exp (-x ^ 2 / 2)

/-- The half weight `e^{-x²/4}`, which turns Hermite *polynomials* into Hermite
*functions*. -/
def gaussH (x : ℝ) : ℝ := Real.exp (-x ^ 2 / 4)

theorem gaussH_pos (x : ℝ) : 0 < gaussH x := Real.exp_pos _

theorem continuous_gaussH : Continuous gaussH := by
  unfold gaussH; fun_prop

theorem continuous_gaussW : Continuous gaussW := by
  unfold gaussW; fun_prop

theorem gaussW_pos (x : ℝ) : 0 < gaussW x := Real.exp_pos _

theorem gaussH_sq (x : ℝ) : gaussH x * gaussH x = gaussW x := by
  rw [gaussH, gaussW, ← Real.exp_add]; ring

theorem hasDerivAt_gaussW (x : ℝ) : HasDerivAt gaussW (-x * gaussW x) x := by
  have h : HasDerivAt (fun y : ℝ => -y ^ 2 / 2) (-x) x := by
    have h0 : HasDerivAt (fun y : ℝ => -y ^ 2 / 2) (-(2 * x) / 2) x := by
      simpa using ((hasDerivAt_pow 2 x).neg).div_const 2
    convert h0 using 1
    ring
  show HasDerivAt (fun y : ℝ => Real.exp (-y ^ 2 / 2)) (-x * Real.exp (-x ^ 2 / 2)) x
  simpa [mul_comm] using h.exp

theorem hasDerivAt_gaussH (x : ℝ) : HasDerivAt gaussH (-(x / 2) * gaussH x) x := by
  have h : HasDerivAt (fun y : ℝ => -y ^ 2 / 4) (-(x / 2)) x := by
    have h0 : HasDerivAt (fun y : ℝ => -y ^ 2 / 4) (-(2 * x) / 4) x := by
      simpa using ((hasDerivAt_pow 2 x).neg).div_const 4
    convert h0 using 1
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
    _ = (k.factorial : ℝ) * Real.exp (|x| - b * x ^ 2) := by
          rw [mul_assoc, ← Real.exp_add]; ring_nf
    _ ≤ (k.factorial : ℝ) * Real.exp (1 / (2 * b) - (b / 2) * x ^ 2) := by gcongr
    _ = ((k.factorial : ℝ) := by sorry
