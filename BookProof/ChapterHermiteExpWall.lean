import Mathlib
import BookProof.ChapterQgHermiteCore

/-!
# The exponential wall is not a relatively bounded perturbation (plan §10.6.1, target 2)

`CONSOLIDATED_PLAN.md` §10.6.1 target 2 proposes to obtain essential self-adjointness of
the one-particle scalaron Hamiltonian on the Gauss–polynomial (Hermite) core by a
Kato–Rellich argument: *"`V(φ)` is `(−Δ)`-bounded with arbitrarily small relative bound on
the Gauss core"*.  The plan itself flags that this target "needs restating".  This module
proves that it is in fact **false**, in the strongest sense: the scalaron potential is not
relatively bounded on the Hermite core with respect to the kinetic term, nor with respect
to the harmonic (conformal-mode) oscillator `−Δ + x²/4` — not with a small relative bound,
and not with *any* pair of constants.

## The mechanism

On the monomial core elements `ψ_N(x) = x^N e^{−x²/4}` the reference operators grow only
polynomially in `N`, because they act on the core by polynomial maps of fixed degree
increment:

* `osc_psi` — `(−d²/dx² + x²/4)(x^N e^{−x²/4}) = ((N + ½)x^N − N(N−1)x^{N−2})e^{−x²/4}`,
  so `‖H₀ψ_N‖ ≤ (N² + 1)‖ψ_N‖` (`l2_osc_le`);
* `neg_deriv2_psi` — `−d²/dx²(x^N e^{−x²/4}) = ((N + ½)x^N − N(N−1)x^{N−2} − ¼x^{N+2})e^{−x²/4}`,
  so `‖−ψ_N''‖ ≤ (N² + 1)‖ψ_N‖` (`l2_kin_le`).

The exponential wall, on the other hand, grows *super-polynomially* along the same family.
The quadratic form of the potential is an exponentially tilted Gaussian moment, and
expanding the tilt to eighth order gives

* `gaussMoment_tilt_ge` — `∫ e^{−2sx}x^{2N}e^{−x²/2}dx ≥ (2s⁸/315)·M_{2N+8}`,
* `gaussMoment_shift_eight` — `M_{2N+8} = (2N+7)(2N+5)(2N+3)(2N+1)·M_{2N}`,

hence `⟪ψ_N, Vψ_N⟫ ≥ c₀(K N⁴ − 1)‖ψ_N‖²` with `K = 8s⁸/315` (`quadForm_scalaron_ge`), and
Cauchy–Schwarz turns this into `‖Vψ_N‖ ≥ c₀(K N⁴ − 1)‖ψ_N‖` (`l2_scalaron_ge`).  A quartic
lower bound against a cubic upper bound is the contradiction.

## What is proved

* `not_relatively_bounded_of_cubic` — the abstract form: no operator whose norm along the
  monomial family grows at most cubically can dominate the scalaron potential;
* **`scalaronV_not_kinetic_relativelyBounded`** — there are **no** constants `a, b` with
  `‖Vψ‖ ≤ a‖ψ''‖ + b‖ψ‖` for all Gauss polynomials `ψ`;
* **`scalaronV_not_oscillator_relativelyBounded`** — there are **no** constants `a, b` with
  `‖Vψ‖ ≤ a‖(−Δ + x²/4)ψ‖ + b‖ψ‖` for all Gauss polynomials `ψ`.

Consequently the Kato–Rellich route of §10.6.1 target 2 — and, a fortiori, the
"arbitrarily small relative bound" it asks for — cannot be taken for the exponential wall,
either against the free kinetic term or against the conformal-mode oscillator whose Hermite
functions define the core.  This is a genuine obstruction, not a gap in the argument: it is
why `BookProof.ChapterQgHermiteOscillatorEsa` can only reach *bounded* perturbations of the
oscillator by Kato–Rellich, and why the exponential case in
`BookProof.ChapterScalaronHermiteEsa` had to be handled by a Fourier/moment argument
instead.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.HermiteExpWall

open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

/-- The `L²(ℝ)` norm of a real function, as a plain integral. -/
noncomputable def l2 (f : ℝ → ℝ) : ℝ := Real.sqrt (∫ x, f x ^ 2)

theorem l2_nonneg (f : ℝ → ℝ) : 0 ≤ l2 f := Real.sqrt_nonneg _

/-! ## 1. Gaussian moments -/

theorem gaussMoment_eq_integral (k : ℕ) :
    gaussMoment k = ∫ x : ℝ, x ^ k * gaussW x := by
  simp [gaussMoment, gint]

theorem gaussMoment_step (k : ℕ) : gaussMoment (k + 2) = ((k : ℝ) + 1) * gaussMoment k := by
  simpa using gaussMoment_succ (k + 1)

theorem gaussMoment_zero : gaussMoment 0 = Real.sqrt (2 * Real.pi) := by
  simpa [gaussMoment] using gint_one

theorem gaussMoment_even_pos (n : ℕ) : 0 < gaussMoment (2 * n) := by
  induction n with
  | zero =>
      rw [show 2 * 0 = 0 from rfl, gaussMoment_zero]
      exact Real.sqrt_pos.mpr (by positivity)
  | succ n ih =>
      rw [show 2 * (n + 1) = 2 * n + 2 by ring, gaussMoment_step]
      positivity

theorem gaussMoment_even_mono {m n : ℕ} (h : m ≤ n) :
    gaussMoment (2 * m) ≤ gaussMoment (2 * n) := by
  induction n with
  | zero => simp_all
  | succ n ih =>
      rcases Nat.lt_or_ge m (n + 1) with hlt | hge
      · have hpos := gaussMoment_even_pos n
        have hstep : gaussMoment (2 * n) ≤ gaussMoment (2 * (n + 1)) := by
          rw [show 2 * (n + 1) = 2 * n + 2 by ring, gaussMoment_step]
          nlinarith [hpos, Nat.cast_nonneg (α := ℝ) (2 * n)]
        exact le_trans (ih (Nat.lt_succ_iff.mp hlt)) hstep
      · rw [le_antisymm h hge]

/-! ## 2. The exponentially tilted moment -/

theorem integrable_exp_mul_pow_gaussW (c : ℝ) (k : ℕ) :
    Integrable (fun x : ℝ => Real.exp (c * x) * (x ^ k * gaussW x)) := by
  have hdom : Integrable
      (fun x : ℝ => Real.exp (2 * c ^ 2) * ‖x ^ k * Real.exp (-(3 / 8 : ℝ) * x ^ 2)‖) :=
    ((integrable_pow_mul_exp_neg k (by norm_num : (0:ℝ) < 3 / 8)).norm).const_mul _
  refine hdom.mono' (Continuous.aestronglyMeasurable (by unfold gaussW; fun_prop)) ?_
  filter_upwards with x
  have h1 : Real.exp (c * x) ≤ Real.exp (|c| * |x|) := by
    refine Real.exp_le_exp.mpr ?_
    calc c * x ≤ |c * x| := le_abs_self _
      _ = |c| * |x| := abs_mul c x
  have h2 : Real.exp (|c| * |x|) ≤ Real.exp (2 * |c| ^ 2) * Real.exp (x ^ 2 / 8) :=
    exp_abs_le_const_mul_exp_sq |c| x
  have hc : (2 : ℝ) * |c| ^ 2 = 2 * c ^ 2 := by rw [sq_abs]
  have hnorm : ‖Real.exp (c * x) * (x ^ k * gaussW x)‖
      = Real.exp (c * x) * (|x| ^ k * Real.exp (-x ^ 2 / 2)) := by
    rw [norm_mul, norm_mul, Real.norm_eq_abs, Real.norm_eq_abs, Real.norm_eq_abs, abs_pow,
      abs_of_pos (Real.exp_pos _), gaussW, abs_of_pos (Real.exp_pos _)]
  have hnorm2 : ‖x ^ k * Real.exp (-(3 / 8 : ℝ) * x ^ 2)‖
      = |x| ^ k * Real.exp (-(3 / 8) * x ^ 2) := by
    rw [norm_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_pow, abs_of_pos (Real.exp_pos _)]
  rw [hnorm, hnorm2]
  calc Real.exp (c * x) * (|x| ^ k * Real.exp (-x ^ 2 / 2))
      ≤ (Real.exp (2 * c ^ 2) * Real.exp (x ^ 2 / 8)) * (|x| ^ k * Real.exp (-x ^ 2 / 2)) := by
        gcongr
        calc Real.exp (c * x) ≤ Real.exp (|c| * |x|) := h1
          _ ≤ Real.exp (2 * |c| ^ 2) * Real.exp (x ^ 2 / 8) := h2
          _ = Real.exp (2 * c ^ 2) * Real.exp (x ^ 2 / 8) := by rw [hc]
    _ = Real.exp (2 * c ^ 2) * (|x| ^ k * Real.exp (-(3 / 8) * x ^ 2)) := by
        rw [show (-(3 / 8 : ℝ) * x ^ 2) = x ^ 2 / 8 + (-x ^ 2 / 2) by ring, Real.exp_add]
        ring

theorem abs_pow_eight (t : ℝ) : |t| ^ 8 = t ^ 8 := by
  rw [show (8 : ℕ) = 2 * 4 from rfl, pow_mul, pow_mul, sq_abs]

/-- **The tilted Gaussian moment beats every polynomial**: expanding the tilt to eighth
order, `∫ e^{−2sx}x^{2N}e^{−x²/2}dx ≥ (s⁸/315)·M_{2N+8}`. -/
theorem gaussMoment_tilt_ge (s : ℝ) (N : ℕ) :
    (s ^ 8 / 315) * gaussMoment (2 * N + 8)
      ≤ ∫ x : ℝ, Real.exp (-(2 * s) * x) * (x ^ (2 * N) * gaussW x) := by
  set F : ℝ → ℝ := fun x => Real.exp (-(2 * s) * x) * (x ^ (2 * N) * gaussW x) with hF
  set G : ℝ → ℝ := fun x => Real.exp ((2 * s) * x) * (x ^ (2 * N) * gaussW x) with hG
  have hFint : Integrable F := integrable_exp_mul_pow_gaussW (-(2 * s)) (2 * N)
  have hGint : Integrable G := integrable_exp_mul_pow_gaussW (2 * s) (2 * N)
  have hFG : ∫ x, G x = ∫ x, F x := by
    have h := integral_neg_eq_self F volume
    rw [← h]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only [hF, hG, gaussW]
    rw [show ((-x) ^ (2 * N) : ℝ) = x ^ (2 * N) from (Even.neg_pow ⟨N, by ring⟩ x)]
    ring_nf
  have hpoly : Integrable
      (fun x : ℝ => ((2 * s) ^ 8 / 40320) * (x ^ (2 * N + 8) * gaussW x)) := by
    have h := (integrable_poly_mul_gaussW ((Polynomial.X : Polynomial ℝ) ^ (2 * N + 8))).const_mul
      ((2 * s) ^ 8 / 40320)
    refine h.congr (Filter.Eventually.of_forall fun x => ?_)
    simp
  have hmono : ∀ x : ℝ, ((2 * s) ^ 8 / 40320) * (x ^ (2 * N + 8) * gaussW x) ≤ F x + G x := by
    intro x
    have hnn : 0 ≤ x ^ (2 * N) * gaussW x := by
      have h1 : 0 ≤ x ^ (2 * N) := (Even.pow_nonneg ⟨N, by ring⟩ x)
      have hg := (gaussW_pos x).le
      positivity
    have hexp : ((2 * s) ^ 8 / 40320) * x ^ 8
        ≤ Real.exp (-(2 * s) * x) + Real.exp ((2 * s) * x) := by
      have h1 : |2 * s * x| ^ 8 / (Nat.factorial 8 : ℝ) ≤ Real.exp |2 * s * x| :=
        Real.pow_div_factorial_le_exp _ (abs_nonneg _) 8
      have h2 : |2 * s * x| ^ 8 = (2 * s) ^ 8 * x ^ 8 := by
        rw [abs_mul, mul_pow, abs_pow_eight, abs_pow_eight]
      have h3 : Real.exp |2 * s * x| ≤ Real.exp (-(2 * s) * x) + Real.exp ((2 * s) * x) := by
        rcases abs_cases (2 * s * x) with ⟨he, -⟩ | ⟨he, -⟩
        · rw [he]
          nlinarith [Real.exp_pos (-(2 * s) * x)]
        · rw [he, show -(2 * s * x) = -(2 * s) * x by ring]
          nlinarith [Real.exp_pos ((2 * s) * x)]
      have hfac : (Nat.factorial 8 : ℝ) = 40320 := by norm_num [Nat.factorial]
      rw [h2, hfac] at h1
      calc ((2 * s) ^ 8 / 40320) * x ^ 8 = (2 * s) ^ 8 * x ^ 8 / 40320 := by ring
        _ ≤ Real.exp |2 * s * x| := h1
        _ ≤ _ := h3
    calc ((2 * s) ^ 8 / 40320) * (x ^ (2 * N + 8) * gaussW x)
        = (((2 * s) ^ 8 / 40320) * x ^ 8) * (x ^ (2 * N) * gaussW x) := by ring
      _ ≤ (Real.exp (-(2 * s) * x) + Real.exp ((2 * s) * x)) * (x ^ (2 * N) * gaussW x) :=
          mul_le_mul_of_nonneg_right hexp hnn
      _ = F x + G x := by simp only [hF, hG]; ring
  have hint : ∫ x : ℝ, ((2 * s) ^ 8 / 40320) * (x ^ (2 * N + 8) * gaussW x)
      ≤ ∫ x, (F x + G x) := integral_mono hpoly (hFint.add hGint) hmono
  rw [integral_add hFint hGint, hFG, integral_const_mul, ← gaussMoment_eq_integral] at hint
  nlinarith [hint]

/-! ## 3. The core family -/

/-- The monomial core elements `ψ_N(x) = x^N e^{−x²/4}`. -/
noncomputable def psi (N : ℕ) : ℝ → ℝ := gaussPoly ((Polynomial.X : Polynomial ℝ) ^ N)

theorem psi_apply (N : ℕ) (x : ℝ) : psi N x = x ^ N * gaussH x := by
  simp [psi, gaussPoly]

theorem psi_sq (N : ℕ) (x : ℝ) : psi N x ^ 2 = x ^ (2 * N) * gaussW x := by
  rw [psi_apply, mul_pow, ← gaussH_sq, pow_mul]
  ring_nf

theorem integral_psi_sq (N : ℕ) : ∫ x : ℝ, psi N x ^ 2 = gaussMoment (2 * N) := by
  rw [gaussMoment_eq_integral]
  exact integral_congr_ae (Filter.Eventually.of_forall fun x => psi_sq N x)

theorem l2_psi_sq (N : ℕ) : l2 (psi N) ^ 2 = gaussMoment (2 * N) := by
  rw [l2, Real.sq_sqrt]
  · exact integral_psi_sq N
  · rw [integral_psi_sq N]; exact (gaussMoment_even_pos N).le

theorem l2_psi_pos (N : ℕ) : 0 < l2 (psi N) := by
  have h := l2_psi_sq N
  have hnn : 0 ≤ l2 (psi N) := l2_nonneg _
  nlinarith [gaussMoment_even_pos N, h]

theorem memLp_psi (N : ℕ) : MemLp (psi N) 2 volume := by
  refine (memLp_two_iff_integrable_sq_norm
    ((continuous_gaussPoly _).aestronglyMeasurable)).mpr ?_
  have h := integrable_poly_mul_gaussW ((Polynomial.X : Polynomial ℝ) ^ (2 * N))
  refine h.congr (Filter.Eventually.of_forall fun x => ?_)
  simp only [Real.norm_eq_abs, sq_abs]
  rw [show gaussPoly ((Polynomial.X : Polynomial ℝ) ^ N) x = psi N x from rfl, psi_sq]
  simp

theorem memLp_scalaron_psi (M alpha : ℝ) (hM : 0 < M) (N : ℕ) :
    MemLp (fun x => starobinskyV M alpha x * psi N x) 2 volume := by
  have hVc : Continuous (starobinskyV M alpha) := continuous_starobinskyV M alpha
  have hVb : ExpBounded (starobinskyV M alpha) := expBounded_starobinskyV M alpha hM
  refine (memLp_two_iff_integrable_sq_norm
    ((hVc.mul (continuous_gaussPoly _)).aestronglyMeasurable)).mpr ?_
  have h := integrable_potential_gaussPoly_mul
    (W := fun x => starobinskyV M alpha x * starobinskyV M alpha x)
    (hVc.mul hVc) (hVb.mul hVb) ((Polynomial.X : Polynomial ℝ) ^ N)
    ((Polynomial.X : Polynomial ℝ) ^ N)
  refine h.congr (Filter.Eventually.of_forall fun x => ?_)
  simp only [Real.norm_eq_abs, sq_abs, Pi.mul_apply]
  ring

/-- Cauchy–Schwarz in `L²(ℝ)`, in the integral notation used here. -/
theorem integral_mul_le_l2_mul_l2 (f g : ℝ → ℝ) (hf : MemLp f 2 volume)
    (hg : MemLp g 2 volume) : ∫ x, ‖f x‖ * ‖g x‖ ≤ l2 f * l2 g := by
  have hc : Real.HolderConjugate 2 2 := by constructor <;> norm_num
  have h := MeasureTheory.integral_mul_norm_le_Lp_mul_Lq (μ := volume) (f := f) (g := g) hc
    (by simpa using hf) (by simpa using hg)
  have hrw : ∀ u : ℝ → ℝ, (∫ x, ‖u x‖ ^ (2:ℝ)) ^ (1 / (2:ℝ)) = l2 u := by
    intro u
    rw [l2, Real.sqrt_eq_rpow]
    congr 1
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp [Real.norm_eq_abs]
  rw [hrw f, hrw g] at h
  exact h

/-! ## 4. The quadratic form of the wall -/

theorem gaussMoment_shift_eight (N : ℕ) : gaussMoment (2 * N + 8)
    = ((2 * (N:ℝ)) + 7) * ((2 * (N:ℝ)) + 5) * ((2 * (N:ℝ)) + 3) * ((2 * (N:ℝ)) + 1)
        * gaussMoment (2 * N) := by
  have h1 : gaussMoment (2 * N + 8) = ((2 * N + 6 : ℕ) + 1 : ℝ) * gaussMoment (2 * N + 6) := by
    simpa using gaussMoment_step (2 * N + 6)
  have h2 : gaussMoment (2 * N + 6) = ((2 * N + 4 : ℕ) + 1 : ℝ) * gaussMoment (2 * N + 4) := by
    simpa using gaussMoment_step (2 * N + 4)
  have h3 : gaussMoment (2 * N + 4) = ((2 * N + 2 : ℕ) + 1 : ℝ) * gaussMoment (2 * N + 2) := by
    simpa using gaussMoment_step (2 * N + 2)
  have h4 : gaussMoment (2 * N + 2) = ((2 * N : ℕ) + 1 : ℝ) * gaussMoment (2 * N) := by
    simpa using gaussMoment_step (2 * N)
  rw [h1, h2, h3, h4]
  push_cast
  ring

/-- **The wall dominates a quartic**: the quadratic form of the scalaron potential along the
monomial core family grows at least like `N⁴`. -/
theorem quadForm_scalaron_ge (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha) (N : ℕ) :
    (M ^ 4 / (16 * alpha)) *
        ((8 * (Real.sqrt (2 / 3) / M) ^ 8 / 315) * (N : ℝ) ^ 4 - 1) * gaussMoment (2 * N)
      ≤ ∫ x : ℝ, starobinskyV M alpha x * psi N x ^ 2 := by
  set s : ℝ := Real.sqrt (2 / 3) / M with hs
  set c0 : ℝ := M ^ 4 / (16 * alpha) with hc0
  have hc0pos : 0 < c0 := by rw [hc0]; positivity
  set P : ℝ → ℝ := fun x => x ^ (2 * N) * gaussW x with hP
  have hPnn : ∀ x, 0 ≤ P x := by
    intro x
    have h1 : 0 ≤ x ^ (2 * N) := (Even.pow_nonneg ⟨N, by ring⟩ x)
    have hg := (gaussW_pos x).le
    simp only [hP]; positivity
  have hPint : Integrable P := by
    have h := integrable_poly_mul_gaussW ((Polynomial.X : Polynomial ℝ) ^ (2 * N))
    refine h.congr (Filter.Eventually.of_forall fun x => ?_)
    simp [hP]
  have hI1 : Integrable (fun x : ℝ => Real.exp (-s * x) * P x) :=
    integrable_exp_mul_pow_gaussW (-s) (2 * N)
  have hI2 : Integrable (fun x : ℝ => Real.exp (-(2 * s) * x) * P x) :=
    integrable_exp_mul_pow_gaussW (-(2 * s)) (2 * N)
  have hid : ∀ x : ℝ, starobinskyV M alpha x * psi N x ^ 2
      = c0 * (P x - 2 * (Real.exp (-s * x) * P x) + Real.exp (-(2 * s) * x) * P x) := by
    intro x
    have harg : -(Real.sqrt (2 / 3)) * x / M = -s * x := by
      rw [hs]; field_simp
    have hsq : Real.exp (-(2 * s) * x) = Real.exp (-s * x) ^ 2 := by
      rw [← Real.exp_nat_mul]; ring_nf
    rw [starobinskyV, psi_sq, harg, hsq, ← hc0]
    simp only [hP]
    ring
  have hInt : ∫ x : ℝ, starobinskyV M alpha x * psi N x ^ 2
      = c0 * ((∫ x, P x) - 2 * (∫ x, Real.exp (-s * x) * P x)
        + ∫ x, Real.exp (-(2 * s) * x) * P x) := by
    rw [integral_congr_ae (Filter.Eventually.of_forall hid), integral_const_mul]
    congr 1
    have hA : Integrable (fun x : ℝ => P x - 2 * (Real.exp (-s * x) * P x)) := by
      simpa using hPint.sub (hI1.const_mul 2)
    rw [integral_add hA hI2, integral_sub hPint (hI1.const_mul 2), integral_const_mul]
  have hPm : ∫ x, P x = gaussMoment (2 * N) := by
    rw [gaussMoment_eq_integral]
  have hAM : 2 * (∫ x, Real.exp (-s * x) * P x)
      ≤ (1 / 2) * (∫ x, Real.exp (-(2 * s) * x) * P x) + 2 * (∫ x, P x) := by
    have hmono : ∀ x : ℝ, 2 * (Real.exp (-s * x) * P x)
        ≤ (1 / 2) * (Real.exp (-(2 * s) * x) * P x) + 2 * P x := by
      intro x
      have hsq : Real.exp (-(2 * s) * x) = Real.exp (-s * x) ^ 2 := by
        rw [← Real.exp_nat_mul]; ring_nf
      have hkey : 2 * Real.exp (-s * x) ≤ (1 / 2) * Real.exp (-s * x) ^ 2 + 2 := by
        nlinarith [sq_nonneg (Real.exp (-s * x) - 2)]
      rw [hsq]
      nlinarith [hPnn x, hkey]
    have hL : Integrable (fun x : ℝ => 2 * (Real.exp (-s * x) * P x)) := hI1.const_mul 2
    have hR : Integrable (fun x : ℝ =>
        (1 / 2) * (Real.exp (-(2 * s) * x) * P x) + 2 * P x) :=
      (hI2.const_mul _).add (hPint.const_mul 2)
    have hmi := integral_mono hL hR hmono
    rwa [integral_add (hI2.const_mul _) (hPint.const_mul 2), integral_const_mul,
      integral_const_mul, integral_const_mul] at hmi
  have htilt : (s ^ 8 / 315) * gaussMoment (2 * N + 8)
      ≤ ∫ x, Real.exp (-(2 * s) * x) * P x := gaussMoment_tilt_ge s N
  have hmpos := gaussMoment_even_pos N
  have hNnn : (0:ℝ) ≤ (N:ℝ) := Nat.cast_nonneg N
  have hbig : 16 * (N:ℝ) ^ 4 * gaussMoment (2 * N) ≤ gaussMoment (2 * N + 8) := by
    rw [gaussMoment_shift_eight]
    have h : 16 * (N:ℝ) ^ 4
        ≤ (2 * (N:ℝ) + 7) * (2 * (N:ℝ) + 5) * (2 * (N:ℝ) + 3) * (2 * (N:ℝ) + 1) := by
      calc 16 * (N:ℝ) ^ 4 = (2 * (N:ℝ)) * (2 * (N:ℝ)) * (2 * (N:ℝ)) * (2 * (N:ℝ)) := by ring
        _ ≤ (2 * (N:ℝ) + 7) * (2 * (N:ℝ) + 5) * (2 * (N:ℝ) + 3) * (2 * (N:ℝ) + 1) := by
            gcongr <;> linarith
    exact mul_le_mul_of_nonneg_right h hmpos.le
  have hchain : (8 * s ^ 8 / 315) * (N:ℝ) ^ 4 * gaussMoment (2 * N)
      ≤ (1 / 2) * ∫ x, Real.exp (-(2 * s) * x) * P x := by
    have h1 : (s ^ 8 / 315) * (16 * (N:ℝ) ^ 4 * gaussMoment (2 * N))
        ≤ (s ^ 8 / 315) * gaussMoment (2 * N + 8) :=
      mul_le_mul_of_nonneg_left hbig (by positivity)
    nlinarith [htilt, h1]
  rw [hInt, hPm]
  nlinarith [hAM, hchain, hc0pos, hmpos]

/-- Cauchy–Schwarz turns the form bound into a norm bound. -/
theorem l2_scalaron_ge (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha) (N : ℕ) :
    (M ^ 4 / (16 * alpha)) *
        ((8 * (Real.sqrt (2 / 3) / M) ^ 8 / 315) * (N : ℝ) ^ 4 - 1) * l2 (psi N)
      ≤ l2 (fun x => starobinskyV M alpha x * psi N x) := by
  have hVnn : ∀ x, 0 ≤ starobinskyV M alpha x := fun x => starobinskyV_nonneg halpha x
  have hcs := integral_mul_le_l2_mul_l2 (fun x => starobinskyV M alpha x * psi N x) (psi N)
    (memLp_scalaron_psi M alpha hM N) (memLp_psi N)
  have hform : ∫ x, ‖starobinskyV M alpha x * psi N x‖ * ‖psi N x‖
      = ∫ x : ℝ, starobinskyV M alpha x * psi N x ^ 2 := by
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only [Real.norm_eq_abs, abs_mul, abs_of_nonneg (hVnn x)]
    rcases abs_cases (psi N x) with ⟨h, -⟩ | ⟨h, -⟩ <;> rw [h] <;> ring
  rw [hform] at hcs
  have hq := quadForm_scalaron_ge M alpha hM halpha N
  have hpos := l2_psi_pos N
  have hsq := l2_psi_sq N
  refine le_of_mul_le_mul_right ?_ hpos
  have hkey : (M ^ 4 / (16 * alpha)) *
      ((8 * (Real.sqrt (2 / 3) / M) ^ 8 / 315) * (N : ℝ) ^ 4 - 1) * l2 (psi N) * l2 (psi N)
      = (M ^ 4 / (16 * alpha)) *
        ((8 * (Real.sqrt (2 / 3) / M) ^ 8 / 315) * (N : ℝ) ^ 4 - 1) * gaussMoment (2 * N) := by
    rw [← hsq]; ring
  rw [hkey]
  linarith [hq, hcs]

/-! ## 5. The reference operators grow polynomially

Both `−d²/dx²` and `−d²/dx² + x²/4` map the monomial core family into itself, shifting the
degree by at most two, so their `L²` norms along the family grow only polynomially in `N`. -/

theorem integral_gaussPoly_sq (q : Polynomial ℝ) :
    ∫ x : ℝ, gaussPoly q x ^ 2 = gint (q * q) := by
  rw [← integral_gaussPoly_mul q q]
  exact integral_congr_ae (Filter.Eventually.of_forall fun x => sq (gaussPoly q x))

theorem gint_self_nonneg (q : Polynomial ℝ) : 0 ≤ gint (q * q) := by
  rw [← integral_gaussPoly_sq]
  exact integral_nonneg fun x => sq_nonneg _

theorem l2_gaussPoly_sq (q : Polynomial ℝ) : l2 (gaussPoly q) ^ 2 = gint (q * q) := by
  rw [l2, Real.sq_sqrt (by rw [integral_gaussPoly_sq]; exact gint_self_nonneg q)]
  exact integral_gaussPoly_sq q

/-- Comparing a core element with the reference family: a bound on the Gaussian second
moment of `q` gives a bound on `‖q e^{−x²/4}‖` in terms of `‖ψ_N‖`. -/
theorem l2_gaussPoly_le_of_gint_le {q : Polynomial ℝ} {K : ℝ} (hK : 0 ≤ K) (N : ℕ)
    (h : gint (q * q) ≤ K ^ 2 * gaussMoment (2 * N)) :
    l2 (gaussPoly q) ≤ K * l2 (psi N) := by
  have h1 : l2 (gaussPoly q) ^ 2 ≤ (K * l2 (psi N)) ^ 2 := by
    rw [l2_gaussPoly_sq, mul_pow, l2_psi_sq]; exact h
  have h2 : 0 ≤ l2 (gaussPoly q) := l2_nonneg _
  have h3 : 0 ≤ K * l2 (psi N) := mul_nonneg hK (l2_nonneg _)
  nlinarith

theorem gint_X_pow (k : ℕ) : gint ((Polynomial.X : Polynomial ℝ) ^ k) = gaussMoment k := rfl

/-- The two-parameter shape of the polynomial of `(−d²/dx² + x²/4)ψ_{m+2}`. -/
noncomputable def oscQ (m : ℕ) (a b : ℝ) : Polynomial ℝ :=
  Polynomial.C a * Polynomial.X ^ (m + 2) - Polynomial.C b * Polynomial.X ^ m

/-- The two-parameter shape of the polynomial of `−d²/dx² ψ_{m+2}`. -/
noncomputable def kinQ (m : ℕ) (a b : ℝ) : Polynomial ℝ :=
  oscQ m a b - Polynomial.C (1 / 4 : ℝ) * Polynomial.X ^ (m + 4)

/-- The coefficient of `x^{m+2}`: `N + ½` with `N = m + 2`. -/
noncomputable def aCoef (m : ℕ) : ℝ := ((m : ℝ) + 2) + 1 / 2

/-- The coefficient of `x^m`: `N(N−1)` with `N = m + 2`. -/
noncomputable def bCoef (m : ℕ) : ℝ := ((m : ℝ) + 2) * ((m : ℝ) + 1)

theorem aCoef_nonneg (m : ℕ) : 0 ≤ aCoef m := by
  unfold aCoef; positivity

theorem bCoef_nonneg (m : ℕ) : 0 ≤ bCoef m := by
  unfold bCoef; positivity

theorem gaussPolyDeriv_monomial (m : ℕ) :
    gaussPolyDeriv ((Polynomial.X : Polynomial ℝ) ^ (m + 2))
      = Polynomial.C ((m : ℝ) + 2) * Polynomial.X ^ (m + 1)
        - Polynomial.C (1 / 2 : ℝ) * Polynomial.X ^ (m + 3) := by
  unfold gaussPolyDeriv
  rw [Polynomial.derivative_X_pow]
  push_cast
  ring

theorem gaussPolyDeriv_two_monomial (m : ℕ) :
    gaussPolyDeriv (gaussPolyDeriv ((Polynomial.X : Polynomial ℝ) ^ (m + 2)))
      = - kinQ m (aCoef m) (bCoef m) := by
  rw [gaussPolyDeriv_monomial]
  unfold gaussPolyDeriv kinQ oscQ aCoef bCoef
  rw [Polynomial.derivative_sub, Polynomial.derivative_C_mul, Polynomial.derivative_C_mul,
    Polynomial.derivative_X_pow, Polynomial.derivative_X_pow]
  refine Polynomial.funext fun x => ?_
  simp only [Polynomial.eval_sub, Polynomial.eval_neg, Polynomial.eval_mul, Polynomial.eval_C,
    Polynomial.eval_X, Polynomial.eval_pow]
  push_cast
  ring

/-- `−ψ_{m+2}''` is the core element with polynomial `kinQ`. -/
theorem neg_deriv2_psi (m : ℕ) :
    (fun x => -deriv (deriv (psi (m + 2))) x) = gaussPoly (kinQ m (aCoef m) (bCoef m)) := by
  funext x
  simp only [psi, deriv2_gaussPoly, gaussPolyDeriv_two_monomial, gaussPoly, Polynomial.eval_neg]
  ring

/-- `(−d²/dx² + x²/4)ψ_{m+2}` is the core element with polynomial `oscQ`. -/
theorem osc_psi (m : ℕ) :
    (fun x => -deriv (deriv (psi (m + 2))) x + x ^ 2 / 4 * psi (m + 2) x)
      = gaussPoly (oscQ m (aCoef m) (bCoef m)) := by
  funext x
  have h := congrFun (neg_deriv2_psi m) x
  simp only at h
  rw [h, psi_apply]
  simp only [kinQ, gaussPoly, Polynomial.eval_sub, Polynomial.eval_mul, Polynomial.eval_C,
    Polynomial.eval_pow, Polynomial.eval_X]
  ring

theorem oscQ_sq (m : ℕ) (a b : ℝ) :
    oscQ m a b * oscQ m a b
      = Polynomial.C (a * a) * Polynomial.X ^ (2 * (m + 2))
        - Polynomial.C (2 * a * b) * Polynomial.X ^ (2 * (m + 1))
        + Polynomial.C (b * b) * Polynomial.X ^ (2 * m) := by
  unfold oscQ
  refine Polynomial.funext fun x => ?_
  simp only [Polynomial.eval_add, Polynomial.eval_sub, Polynomial.eval_mul, Polynomial.eval_C,
    Polynomial.eval_X, Polynomial.eval_pow]
  ring

theorem kinQ_sq (m : ℕ) (a b : ℝ) :
    kinQ m a b * kinQ m a b
      = Polynomial.C (a * a + b / 2) * Polynomial.X ^ (2 * (m + 2))
        + Polynomial.C (b * b) * Polynomial.X ^ (2 * m)
        + Polynomial.C (1 / 16 : ℝ) * Polynomial.X ^ (2 * (m + 4))
        - Polynomial.C (2 * a * b) * Polynomial.X ^ (2 * (m + 1))
        - Polynomial.C (a / 2) * Polynomial.X ^ (2 * (m + 3)) := by
  unfold kinQ oscQ
  refine Polynomial.funext fun x => ?_
  simp only [Polynomial.eval_add, Polynomial.eval_sub, Polynomial.eval_mul, Polynomial.eval_C,
    Polynomial.eval_X, Polynomial.eval_pow]
  ring

theorem gint_oscQ (m : ℕ) (a b : ℝ) :
    gint (oscQ m a b * oscQ m a b)
      = a * a * gaussMoment (2 * (m + 2)) - 2 * a * b * gaussMoment (2 * (m + 1))
        + b * b * gaussMoment (2 * m) := by
  rw [oscQ_sq, gint_add, gint_sub, gint_C_mul, gint_C_mul, gint_C_mul, gint_X_pow, gint_X_pow,
    gint_X_pow]

theorem gint_kinQ (m : ℕ) (a b : ℝ) :
    gint (kinQ m a b * kinQ m a b)
      = (a * a + b / 2) * gaussMoment (2 * (m + 2)) + b * b * gaussMoment (2 * m)
        + (1 / 16 : ℝ) * gaussMoment (2 * (m + 4))
        - 2 * a * b * gaussMoment (2 * (m + 1)) - a / 2 * gaussMoment (2 * (m + 3)) := by
  rw [kinQ_sq, gint_sub, gint_sub, gint_add, gint_add, gint_C_mul, gint_C_mul, gint_C_mul,
    gint_C_mul, gint_C_mul, gint_X_pow, gint_X_pow, gint_X_pow, gint_X_pow, gint_X_pow]

theorem gaussMoment_shift_four (m : ℕ) :
    gaussMoment (2 * (m + 4))
      = (2 * (m : ℝ) + 7) * (2 * (m : ℝ) + 5) * gaussMoment (2 * (m + 2)) := by
  have h1 : gaussMoment (2 * m + 8) = ((2 * m + 6 : ℕ) + 1 : ℝ) * gaussMoment (2 * m + 6) := by
    simpa using gaussMoment_step (2 * m + 6)
  have h2 : gaussMoment (2 * m + 6) = ((2 * m + 4 : ℕ) + 1 : ℝ) * gaussMoment (2 * m + 4) := by
    simpa using gaussMoment_step (2 * m + 4)
  have e1 : 2 * (m + 4) = 2 * m + 8 := by ring
  have e2 : 2 * (m + 2) = 2 * m + 4 := by ring
  rw [e1, e2, h1, h2]
  push_cast
  ring

theorem gint_oscQ_le (m : ℕ) (a b K : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b)
    (hK : a * a + b * b ≤ K ^ 2) :
    gint (oscQ m a b * oscQ m a b) ≤ K ^ 2 * gaussMoment (2 * (m + 2)) := by
  rw [gint_oscQ]
  have hlow : gaussMoment (2 * m) ≤ gaussMoment (2 * (m + 2)) :=
    gaussMoment_even_mono (by omega)
  have hmid : 0 ≤ gaussMoment (2 * (m + 1)) := (gaussMoment_even_pos (m + 1)).le
  have hpos : 0 < gaussMoment (2 * (m + 2)) := gaussMoment_even_pos (m + 2)
  have hbb : (0 : ℝ) ≤ b * b := mul_nonneg hb hb
  have hab : (0 : ℝ) ≤ 2 * a * b := by positivity
  nlinarith [mul_le_mul_of_nonneg_left hlow hbb, mul_nonneg hab hmid,
    mul_le_mul_of_nonneg_right hK hpos.le]

theorem gint_kinQ_le (m : ℕ) (a b K : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b)
    (hK : a * a + b / 2 + b * b + (1 / 16 : ℝ) * ((2 * (m : ℝ) + 7) * (2 * (m : ℝ) + 5))
      ≤ K ^ 2) :
    gint (kinQ m a b * kinQ m a b) ≤ K ^ 2 * gaussMoment (2 * (m + 2)) := by
  rw [gint_kinQ, gaussMoment_shift_four]
  have hlow : gaussMoment (2 * m) ≤ gaussMoment (2 * (m + 2)) :=
    gaussMoment_even_mono (by omega)
  have hmid : 0 ≤ gaussMoment (2 * (m + 1)) := (gaussMoment_even_pos (m + 1)).le
  have hodd : 0 ≤ gaussMoment (2 * (m + 3)) := (gaussMoment_even_pos (m + 3)).le
  have hpos : 0 < gaussMoment (2 * (m + 2)) := gaussMoment_even_pos (m + 2)
  have hbb : (0 : ℝ) ≤ b * b := mul_nonneg hb hb
  have hab : (0 : ℝ) ≤ 2 * a * b := by positivity
  have hah : (0 : ℝ) ≤ a / 2 := by positivity
  nlinarith [mul_le_mul_of_nonneg_left hlow hbb, mul_nonneg hab hmid, mul_nonneg hah hodd,
    mul_le_mul_of_nonneg_right hK hpos.le]

theorem l2_osc_le (N : ℕ) (hN : 2 ≤ N) :
    l2 (fun x => -deriv (deriv (psi N)) x + x ^ 2 / 4 * psi N x)
      ≤ ((N : ℝ) ^ 2 + 1) * l2 (psi N) := by
  obtain ⟨m, rfl⟩ : ∃ m, N = m + 2 := ⟨N - 2, by omega⟩
  rw [osc_psi m]
  have hK : (0 : ℝ) ≤ ((↑(m + 2) : ℝ) ^ 2 + 1) := by positivity
  refine l2_gaussPoly_le_of_gint_le hK (m + 2) ?_
  refine gint_oscQ_le m _ _ _ (aCoef_nonneg m) (bCoef_nonneg m) ?_
  unfold aCoef bCoef
  have hm : (0 : ℝ) ≤ (m : ℝ) := Nat.cast_nonneg m
  push_cast
  nlinarith [hm, sq_nonneg ((m : ℝ) + 1), sq_nonneg ((m : ℝ) + 2)]

theorem l2_kin_le (N : ℕ) (hN : 2 ≤ N) :
    l2 (fun x => -deriv (deriv (psi N)) x) ≤ ((N : ℝ) ^ 2 + 1) * l2 (psi N) := by
  obtain ⟨m, rfl⟩ : ∃ m, N = m + 2 := ⟨N - 2, by omega⟩
  rw [neg_deriv2_psi m]
  have hK : (0 : ℝ) ≤ ((↑(m + 2) : ℝ) ^ 2 + 1) := by positivity
  refine l2_gaussPoly_le_of_gint_le hK (m + 2) ?_
  refine gint_kinQ_le m _ _ _ (aCoef_nonneg m) (bCoef_nonneg m) ?_
  unfold aCoef bCoef
  have hm : (0 : ℝ) ≤ (m : ℝ) := Nat.cast_nonneg m
  push_cast
  nlinarith [hm, sq_nonneg ((m : ℝ) + 1), sq_nonneg ((m : ℝ) + 2)]

/-! ## 6. No relative bound -/

/-- **The abstract obstruction.**  An operator that grows at most cubically along the
monomial core family cannot dominate the scalaron potential. -/
theorem not_relatively_bounded_of_cubic (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha)
    (A : ℕ → ℝ → ℝ) (C : ℝ)
    (hA : ∀ N : ℕ, 2 ≤ N → l2 (A N) ≤ C * (N : ℝ) ^ 3 * l2 (psi N)) :
    ¬ ∃ a b : ℝ, ∀ N : ℕ, 2 ≤ N →
        l2 (fun x => starobinskyV M alpha x * psi N x) ≤ a * l2 (A N) + b * l2 (psi N) := by
  rintro ⟨a, b, hab⟩
  set c0 : ℝ := M ^ 4 / (16 * alpha) with hc0
  have hc0pos : 0 < c0 := by rw [hc0]; positivity
  set s : ℝ := Real.sqrt (2 / 3) / M with hs
  have hspos : 0 < s := by
    rw [hs]; exact div_pos (Real.sqrt_pos.mpr (by norm_num)) hM
  set K : ℝ := 8 * s ^ 8 / 315 with hKdef
  have hKpos : 0 < K := by rw [hKdef]; positivity
  obtain ⟨N, hNgt⟩ := exists_nat_gt (max 2 ((|a| * C + |b| + c0) / (c0 * K)))
  have hN2 : (2 : ℝ) < (N : ℝ) := lt_of_le_of_lt (le_max_left _ _) hNgt
  have hNnat : 2 ≤ N := by exact_mod_cast hN2.le
  have hNge : (2 : ℝ) ≤ (N : ℝ) := hN2.le
  have hT : (|a| * C + |b| + c0) / (c0 * K) < (N : ℝ) := lt_of_le_of_lt (le_max_right _ _) hNgt
  have hcK : 0 < c0 * K := mul_pos hc0pos hKpos
  have hTmul : |a| * C + |b| + c0 < c0 * K * (N : ℝ) := by
    rw [div_lt_iff₀ hcK] at hT; linarith [hT]
  have hpsi := l2_psi_pos N
  have hlow := l2_scalaron_ge M alpha hM halpha N
  rw [← hc0, ← hs, ← hKdef] at hlow
  have hup := hab N hNnat
  have hAN := hA N hNnat
  have hAnn : 0 ≤ l2 (A N) := l2_nonneg _
  have hterm : a * l2 (A N) ≤ |a| * (C * (N : ℝ) ^ 3 * l2 (psi N)) := by
    have h1 : a * l2 (A N) ≤ |a| * l2 (A N) :=
      mul_le_mul_of_nonneg_right (le_abs_self a) hAnn
    have h2 : |a| * l2 (A N) ≤ |a| * (C * (N : ℝ) ^ 3 * l2 (psi N)) :=
      mul_le_mul_of_nonneg_left hAN (abs_nonneg a)
    linarith
  have hbterm : b * l2 (psi N) ≤ |b| * l2 (psi N) :=
    mul_le_mul_of_nonneg_right (le_abs_self b) hpsi.le
  have hdiv : c0 * (K * (N : ℝ) ^ 4 - 1) ≤ |a| * C * (N : ℝ) ^ 3 + |b| := by
    refine le_of_mul_le_mul_right ?_ hpsi
    calc c0 * (K * (N : ℝ) ^ 4 - 1) * l2 (psi N)
        ≤ l2 (fun x => starobinskyV M alpha x * psi N x) := hlow
      _ ≤ a * l2 (A N) + b * l2 (psi N) := hup
      _ ≤ (|a| * C * (N : ℝ) ^ 3 + |b|) * l2 (psi N) := by nlinarith [hterm, hbterm]
  have hN1 : (1 : ℝ) ≤ (N : ℝ) := by linarith
  have hN3 : (1 : ℝ) ≤ (N : ℝ) ^ 3 := by
    calc (1 : ℝ) = 1 ^ 3 := by norm_num
      _ ≤ (N : ℝ) ^ 3 := by gcongr
  have hmul3 : (|a| * C + |b| + c0) * (N : ℝ) ^ 3 < c0 * K * (N : ℝ) * (N : ℝ) ^ 3 :=
    mul_lt_mul_of_pos_right hTmul (by positivity)
  have hb3 : |b| ≤ |b| * (N : ℝ) ^ 3 := by nlinarith [abs_nonneg b, hN3]
  have hc3 : c0 ≤ c0 * (N : ℝ) ^ 3 := by nlinarith [hc0pos, hN3]
  nlinarith [hdiv, hmul3, hb3, hc3]

/-- **The scalaron potential is not relatively bounded by the kinetic term on the Hermite
core**: no constants `a, b` satisfy `‖Vψ‖ ≤ a‖ψ''‖ + b‖ψ‖` for all Gauss polynomials. -/
theorem scalaronV_not_kinetic_relativelyBounded (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha) :
    ¬ ∃ a b : ℝ, ∀ p : Polynomial ℝ,
        l2 (fun x => starobinskyV M alpha x * gaussPoly p x)
          ≤ a * l2 (fun x => -deriv (deriv (gaussPoly p)) x) + b * l2 (gaussPoly p) := by
  rintro ⟨a, b, h⟩
  refine not_relatively_bounded_of_cubic M alpha hM halpha
    (fun N x => -deriv (deriv (psi N)) x) 1 ?_ ⟨a, b, ?_⟩
  · intro N hN
    refine le_trans (l2_kin_le N hN) ?_
    have hNge : (2 : ℝ) ≤ (N : ℝ) := by exact_mod_cast hN
    have hstep : ((N : ℝ) ^ 2 + 1) ≤ 1 * (N : ℝ) ^ 3 := by nlinarith [hNge]
    exact mul_le_mul_of_nonneg_right hstep (l2_nonneg _)
  · intro N _
    exact h ((Polynomial.X : Polynomial ℝ) ^ N)

/-- **The scalaron potential is not relatively bounded by the conformal-mode oscillator on
the Hermite core** either: no constants `a, b` satisfy `‖Vψ‖ ≤ a‖(−Δ + x²/4)ψ‖ + b‖ψ‖`. -/
theorem scalaronV_not_oscillator_relativelyBounded (M alpha : ℝ) (hM : 0 < M)
    (halpha : 0 < alpha) :
    ¬ ∃ a b : ℝ, ∀ p : Polynomial ℝ,
        l2 (fun x => starobinskyV M alpha x * gaussPoly p x)
          ≤ a * l2 (fun x => -deriv (deriv (gaussPoly p)) x + x ^ 2 / 4 * gaussPoly p x)
            + b * l2 (gaussPoly p) := by
  rintro ⟨a, b, h⟩
  refine not_relatively_bounded_of_cubic M alpha hM halpha
    (fun N x => -deriv (deriv (psi N)) x + x ^ 2 / 4 * psi N x) 1 ?_ ⟨a, b, ?_⟩
  · intro N hN
    refine le_trans (l2_osc_le N hN) ?_
    have hNge : (2 : ℝ) ≤ (N : ℝ) := by exact_mod_cast hN
    have hstep : ((N : ℝ) ^ 2 + 1) ≤ 1 * (N : ℝ) ^ 3 := by nlinarith [hNge]
    exact mul_le_mul_of_nonneg_right hstep (l2_nonneg _)
  · intro N _
    exact h ((Polynomial.X : Polynomial ℝ) ^ N)

end

end BookProof.HermiteExpWall
