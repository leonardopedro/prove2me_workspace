-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hermiteInner_eq
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_hermiteInner_succ_zero
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
 :=
  import Mathlib
  
  /-!
  # The Hermite functions: orthonormality, completeness, and the Hermite core of `L²(ℝ)`
  
  This chapter supplies the concrete object that the abstract Galerkin/Friedrichs
  chapter (`BookProof/ChapterHermiteGalerkinFriedrichs.lean`) and the quantum
  gravity chapter (`BookProof/ChapterQuantumGravityDensitized.lean`) so far only
  used *abstractly*: a genuine **Hilbert basis of Hermite functions** of `L²(ℝ)`,
  and hence a genuine **Hermite core** — the space of finite linear combinations of
  Hermite functions, i.e. "polynomials times the Gaussian".
  
  The convention is the probabilists' one: `H_{n+1} = X H_n − H_n'`
  (`Polynomial.hermite` of Mathlib), and the Hermite *functions* are
  
    `ψ_n(x) = H_n(x) e^{-x²/4}`,   `∫ ψ_m ψ_n = δ_{mn} n! √(2π)`.
  
  Contents:
  
  * `hermiteR`, `derivative_hermiteR`, `hermiteR_ode` — the polynomials, the
    derivative rule `H_{n+1}' = (n+1) H_n` and the Hermite differential equation;
  * `gint_ibp` — integration by parts against the Gaussian weight on all of `ℝ`;
  * `hermiteInner_eq` — the orthogonality relations
    `∫ H_m H_n e^{-x²/2} = δ_{mn} n! √(2π)`;
  * `orthonormal_hermiteLp` — the normalized Hermite functions are orthonormal in
    `L²(ℝ, ℂ)`;
  * `hermiteLp_span_dense`, `hermiteBasis` — completeness: they form a Hilbert
    basis (proved from scratch: orthogonality to all `xⁿ e^{-x²/4}` forces the
    Fourier transform of `e^{-x²/4} u` to vanish identically);
  * `hermiteFun_oscillator` — each Hermite function is an eigenfunction of the
    harmonic oscillator `-d²/dx² + x²/4` with eigenvalue `n + 1/2`.
  -/
  
  namespace BookProof.HermiteCore
  
  open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap
  
  noncomputable section
  
  /-! ## The Hermite polynomials over `ℝ` -/
  
  /-- The (probabilists') Hermite polynomials, as real polynomials. -/
  def hermiteR (n : ℕ) : Polynomial ℝ := (Polynomial.hermite n).map (Int.castRingHom ℝ)
  
  theorem hermiteR_zero : hermiteR 0 = 1 := by
    simp [hermiteR, Polynomial.hermite_zero]
  
  theorem hermiteR_one : hermiteR 1 = X := by
    simp [hermiteR]
  
  theorem hermiteR_succ (n : ℕ) :
      hermiteR (n + 1) = X * hermiteR n - derivative (hermiteR n) := by
    simp [hermiteR, Polynomial.hermite_succ, Polynomial.derivative_map]
  
  /-- `H_{n+1}' = (n+1) H_n`. -/
  theorem derivative_hermiteR (n : ℕ) :
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
      _ = ((k.factorial : ℝ) * Real.exp (1 / (2 * b))) * Real.exp (-(b / 2) * x ^ 2) := by
            rw [mul_assoc, ← Real.exp_add]; ring_nf
  
  /-- Every polynomial is integrable against a Gaussian. -/
  theorem integrable_poly_mul_exp_neg (p : Polynomial ℝ) {b : ℝ} (hb : 0 < b) :
      Integrable (fun x : ℝ => p.eval x * Real.exp (-b * x ^ 2)) := by
    induction p using Polynomial.induction_on' with
    | add p q hp hq =>
      refine (hp.add hq).congr (Filter.Eventually.of_forall fun x => ?_)
      simp [Polynomial.eval_add, add_mul]
    | monomial k a =>
        simpa [Polynomial.eval_monomial, mul_assoc] using
          (integrable_pow_mul_exp_neg k hb).const_mul a
  
  theorem integrable_poly_mul_gaussW (p : Polynomial ℝ) :
      Integrable (fun x : ℝ => p.eval x * gaussW x) := by
    have h := integrable_poly_mul_exp_neg p (b := 1 / 2) (by norm_num)
    refine h.congr (Filter.Eventually.of_forall fun x => ?_)
    simp only [gaussW]
    ring_nf
  
  theorem integrable_poly_mul_gaussH (p : Polynomial ℝ) :
      Integrable (fun x : ℝ => p.eval x * gaussH x) := by
    have h := integrable_poly_mul_exp_neg p (b := 1 / 4) (by norm_num)
    refine h.congr (Filter.Eventually.of_forall fun x => ?_)
    simp only [gaussH]
    ring_nf
  
  /-! ## The Gaussian-weighted integral of a polynomial -/
  
  /-- `gint p = ∫ p(x) e^{-x²/2} dx`, the Gaussian-weighted integral. -/
  def gint (p : Polynomial ℝ) : ℝ := ∫ x : ℝ, p.eval x * gaussW x
  
  @[simp] theorem gint_zero : gint 0 = 0 := by simp [gint]
  
  theorem gint_add (p q : Polynomial ℝ) : gint (p + q) = gint p + gint q := by
    simp only [gint, Polynomial.eval_add, add_mul]
    exact integral_add (integrable_poly_mul_gaussW p) (integrable_poly_mul_gaussW q)
  
  theorem gint_sub (p q : Polynomial ℝ) : gint (p - q) = gint p - gint q := by
    simp only [gint, Polynomial.eval_sub, sub_mul]
    exact integral_sub (integrable_poly_mul_gaussW p) (integrable_poly_mul_gaussW q)
  
  theorem gint_C_mul (c : ℝ) (p : Polynomial ℝ) : gint (C c * p) = c * gint p := by
    simp only [gint, Polynomial.eval_mul, Polynomial.eval_C, mul_assoc, integral_const_mul]
  
  theorem gint_one : gint 1 = Real.sqrt (2 * Real.pi) := by
    have h : (fun x : ℝ => (1 : Polynomial ℝ).eval x * gaussW x)
        = fun x : ℝ => Real.exp (-(1 / 2 : ℝ) * x ^ 2) := by
      funext x
      simp only [Polynomial.eval_one, one_mul, gaussW]
      ring_nf
    rw [gint, h, integral_gaussian]
    congr 1
    rw [div_eq_iff (by norm_num : (1 / 2 : ℝ) ≠ 0)]
    ring
  
  /-- **Integration by parts against the Gaussian weight**, on all of `ℝ`:
  `∫ p' q w = ∫ p (X q − q') w`, because `(q w)' = (q' − X q) w`. -/
  theorem gint_ibp (p q : Polynomial ℝ) :
      gint (derivative p * q) = gint (p * (X * q - derivative q)) := by
    have hu : ∀ x : ℝ, HasDerivAt (fun y : ℝ => p.eval y) ((derivative p).eval x) x :=
      fun x => p.hasDerivAt x
    have hv : ∀ x : ℝ, HasDerivAt (fun y : ℝ => q.eval y * gaussW y)
        (((derivative q).eval x - x * q.eval x) * gaussW x) x := by
      intro x
      have h := (q.hasDerivAt x).mul (hasDerivAt_gaussW x)
      convert h using 1 <;> first | rfl | ring
    have hiuv' : Integrable ((fun y : ℝ => p.eval y) *
        (fun y : ℝ => ((derivative q).eval y - y * q.eval y) * gaussW y)) := by
      refine (integrable_poly_mul_gaussW (p * (derivative q - X * q))).congr
        (Filter.Eventually.of_forall fun x => ?_)
      simp only [Pi.mul_apply, Polynomial.eval_mul, Polynomial.eval_sub, Polynomial.eval_X]
      ring
    have hiu'v : Integrable ((fun y : ℝ => (derivative p).eval y) *
        (fun y : ℝ => q.eval y * gaussW y)) := by
      refine (integrable_poly_mul_gaussW (derivative p * q)).congr
        (Filter.Eventually.of_forall fun x => ?_)
      simp only [Pi.mul_apply, Polynomial.eval_mul]
      ring
    have hiuv : Integrable ((fun y : ℝ => p.eval y) * (fun y : ℝ => q.eval y * gaussW y)) := by
      refine (integrable_poly_mul_gaussW (p * q)).congr (Filter.Eventually.of_forall fun x => ?_)
      simp only [Pi.mul_apply, Polynomial.eval_mul]
      ring
    have key := integral_mul_deriv_eq_deriv_mul_of_integrable
      (fun x _ => hu x) (fun x _ => hv x) hiuv' hiu'v hiuv
    have hL : ∫ x : ℝ, p.eval x * (((derivative q).eval x - x * q.eval x) * gaussW x)
        = - gint (p * (X * q - derivative q)) := by
      rw [gint, ← integral_neg]
      refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
      simp only [Polynomial.eval_mul, Polynomial.eval_sub, Polynomial.eval_X]
      ring
    have hR : ∫ x : ℝ, (derivative p).eval x * (q.eval x * gaussW x) = gint (derivative p * q) := by
      rw [gint]
      refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
      simp only [Polynomial.eval_mul]
      ring
    rw [hL, hR] at key
    linarith [key]
  
  /-! ## Orthogonality -/
  
  /-- The Gaussian-weighted inner product of two Hermite polynomials. -/
  def hermiteInner (m n : ℕ) : ℝ := gint (hermiteR m * hermiteR n)
  
  theorem hermiteInner_comm (m n : ℕ) : hermiteInner m n = hermiteInner n m := by
    rw [hermiteInner, hermiteInner, mul_comm]
  
  theorem hermiteInner_zero_zero : hermiteInner 0 0 = Real.sqrt (2 * Real.pi) := by
    rw [hermiteInner, hermiteR_zero, mul_one, gint_one]
  
  /-- One step of the recursion: `∫ H_{m+1} H_n w = ∫ H_m H_n' w`. -/
  theorem hermiteInner_succ_left (m n : ℕ) :
      hermiteInner (m + 1) n = gint (hermiteR m * derivative (hermiteR n)) := by
    have hibp : gint (derivative (hermiteR m) * hermiteR n)
        = gint (hermiteR m * (X * hermiteR n - derivative (hermiteR n))) := gint_ibp _ _
    have h1 : hermiteInner (m + 1) n
        = gint (X * hermiteR m * hermiteR n) - gint (derivative (hermiteR m) * hermiteR n) := by
      rw [hermiteInner, hermiteR_succ m, ← gint_sub]
      congr 1
      ring
    have h2 : gint (hermiteR m * (X * hermiteR n - derivative (hermiteR n)))
        = gint (X * hermiteR m * hermiteR n) - gint (hermiteR m * derivative (hermiteR n)) := by
      rw [← gint_sub]
      congr 1
      ring
    rw [h1, hibp, h2]
    ring
  
  theorem hermiteInner_succ_zero (m : ℕ) : hermiteInner (m + 1) 0 = 0 := by
    rw [hermiteInner_succ_left, hermiteR_zero]
    simp
  
  theorem hermiteInner_succ_succ (m n : ℕ) :
      hermiteInner (m + 1) (n + 1) = ((n : ℝ) + 1) * hermiteInner m n := by
    rw [hermiteInner_succ_left, derivative_hermiteR n,
      show hermiteR m * (C ((n : ℝ) + 1) * hermiteR n) = C ((n : ℝ) + 1) * (hermiteR m * hermiteR n)
        by ring, gint_C_mul, hermiteInner]
  
  /-- **The orthogonality relations**: `∫ H_m H_n e^{-x²/2} = δ_{mn} n! √(2π)`. -/
  theorem hermiteInner_eq (m n : ℕ) :
      hermiteInner m n = if m = n then (n.factorial : ℝ) * Real.sqrt (2 * Real.pi) else
