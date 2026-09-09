import Mathlib

/-!
# The Simader–Faris–Lavine cutoff method for `-d²/dx² + V`

This module carries out, in one space dimension and with no unproved input, the
**cutoff / commutator energy argument** for essential self-adjointness of a
Schrödinger operator `H = -Δ + V` with a potential that is allowed to grow
arbitrarily fast — the motivating example being the non-polynomial
`V(x) = eˣ + e⁻ˣ`, for which none of the polynomial-growth criteria apply.

The mathematical content is the classical energy estimate: if `u` is a
square-integrable classical solution of `-u'' + V u = z u` with
`Re z + 1 ≤ V` pointwise, then testing the equation against `χ_R² ū`,
integrating by parts once, and absorbing the cross term by Young's inequality
gives

  `∫_{[-R,R]} |u|² ≤ ∫ χ_R² (V - Re z) |u|² ≤ (2C²/R²) ‖u‖²_{L²}`,

where `C` bounds `|χ'|` for a fixed smooth cutoff `χ` equal to `1` on `[-1,1]`
and supported in `[-2,2]`, and `χ_R(x) = χ(x/R)`.  Letting `R → ∞` forces
`u = 0`.  Applied to `z = ± i` — whose real part is `0`, so that the hypothesis
`Re z + 1 ≤ V` only asks `V ≥ 1` — this says exactly that the classical
deficiency spaces of `H` are trivial, which is the analytic heart of essential
self-adjointness.

## Contents

* `integral_deriv_eq_zero_of_hasCompactSupport` — the one-dimensional
  integration-by-parts engine: the integral over `ℝ` of the derivative of a
  compactly supported `C¹` function vanishes.
* The section "the cutoff family" — a concrete smooth cutoff `chi` built from
  Mathlib's `ContDiffBump`, its basic properties, the gradient bound
  `exists_deriv_chi_bound`, and the rescaled family `exists_scaled_cutoff`
  (Milestone 3 of the plan: `|χ_R'| ≤ C/R`).
* `hasDerivAt_reInner` — the derivative of the energy density
  `x ↦ Re(conj (u x) · u'(x))`.
* `schrodingerOp`, `integral_conj_secondDeriv_comm` and `schrodingerOp_symmetric`
  — Milestone 2: the operator `H f = -f'' + V f` on the compactly supported
  twice differentiable core, and its Hermitian symmetry there, for an arbitrary
  real continuous `V` (no growth restriction).
* `cutoff_energy_core` — Milestone 4 in its sharpest form: under the weaker
  hypothesis `Re z ≤ V` it bounds *both* the potential energy
  `∫_{[-R,R]} (V - Re z)|u|²` and the Dirichlet energy `∫_{[-R,R]} |u'|²` by a
  multiple of `‖u‖²_{L²}/R²`.
* `cutoff_energy_estimate` — Milestone 4: the estimate displayed above, for an
  arbitrary continuous `V` and arbitrary `z` with `Re z + 1 ≤ V`.
* `l2_classical_solution_eq_zero` — Milestone 5: the limit `R → ∞`, giving
  `u = 0`.
* `l2_classical_solution_eq_zero_of_nonneg` — the same conclusion under the
  weaker hypothesis `Re z ≤ V`, obtained by running the limit on the Dirichlet
  term instead: `u' ≡ 0`, so `u` is constant, and a constant in `L²(ℝ)` is `0`.
* `laplacian_deficiency_trivial` / `..._I` / `..._negI` — the `V = 0`
  specialisation: the free Laplacian `-d²/dx²` on the line has no nonzero
  square-integrable classical solution of `-u'' = z u` when `Re z ≤ 0`, in
  particular for `z = ± i`.
* `Vexp`, `two_le_Vexp` and `schrodinger_exp_deficiency_trivial` /
  `schrodinger_exp_deficiency_trivial_I` / `..._negI` — the motivating
  application: for `V(x) = eˣ + e⁻ˣ` the operator `-d²/dx² + V` has no nonzero
  square-integrable classical solution of `H u = ± i u`.

Nothing here is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.SchrodingerCutoff

open MeasureTheory Filter Complex

/-! ## Integration by parts on the line -/

/-- The integral over `ℝ` of the derivative of a compactly supported `C¹`
function is zero.  This is the only integration-by-parts input of the whole
argument. -/
theorem integral_deriv_eq_zero_of_hasCompactSupport
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
    {g g' : ℝ → E} (h : ∀ x, HasDerivAt g (g' x) x) (hc : Continuous g')
    (hs : HasCompactSupport g) : ∫ x, g' x = 0 := by
  obtain ⟨M, hMpos, hM⟩ := hs.exists_pos_le_norm
  have hvanish : ∀ x : ℝ, M < |x| → g' x = 0 := by
    intro x hx
    have hnb : g =ᶠ[nhds x] fun _ => (0 : E) := by
      filter_upwards [(isOpen_lt continuous_const continuous_abs).mem_nhds hx] with y hy
      exact hM y (le_of_lt hy)
    exact (h x).unique ((hasDerivAt_const x (0 : E)).congr_of_eventuallyEq hnb)
  have hsub : ∫ x, g' x = ∫ x in Set.Ioc (-(M + 1)) (M + 1), g' x := by
    rw [setIntegral_eq_integral_of_forall_compl_eq_zero]
    intro x hx
    refine hvanish x ?_
    simp only [Set.mem_Ioc, not_and_or, not_lt, not_le] at hx
    rcases hx with hx | hx
    · rw [abs_of_nonpos (by linarith)]; linarith
    · rw [abs_of_pos (by linarith)]; linarith
  rw [hsub, ← intervalIntegral.integral_of_le (by linarith)]
  rw [show (fun x => g' x) = deriv g from funext fun x => ((h x).deriv).symm]
  rw [intervalIntegral.integral_deriv_eq_sub (fun x _ => (h x).differentiableAt)
      (by rw [show deriv g = g' from funext fun x => (h x).deriv]
          exact hc.intervalIntegrable _ _)]
  rw [hM (M + 1) (by rw [Real.norm_eq_abs, abs_of_pos (by linarith)]; linarith),
      hM (-(M + 1)) (by rw [Real.norm_eq_abs, abs_of_nonpos (by linarith)]; linarith)]
  simp

/-! ## The cutoff family -/

/-- The reference bump: equal to `1` on `[-1,1]`, supported in `[-2,2]`. -/
noncomputable def bump0 : ContDiffBump (0 : ℝ) := ⟨1, 2, one_pos, by norm_num⟩

/-- The reference cutoff `χ : ℝ → ℝ`. -/
noncomputable def chi : ℝ → ℝ := fun x => bump0 x

theorem chi_contDiff : ContDiff ℝ 2 chi := bump0.contDiff

theorem chi_continuous : Continuous chi := chi_contDiff.continuous

theorem chi_differentiable : Differentiable ℝ chi :=
  chi_contDiff.differentiable (by norm_num)

theorem deriv_chi_continuous : Continuous (deriv chi) :=
  chi_contDiff.continuous_deriv (by norm_num)

theorem chi_nonneg (x : ℝ) : 0 ≤ chi x := bump0.nonneg

theorem chi_le_one (x : ℝ) : chi x ≤ 1 := bump0.le_one

theorem chi_eq_one_of_abs_le_one {x : ℝ} (hx : |x| ≤ 1) : chi x = 1 :=
  bump0.one_of_mem_closedBall (by simpa [Real.dist_eq, bump0] using hx)

theorem chi_eq_zero {y : ℝ} (hy : 2 ≤ |y|) : chi y = 0 :=
  bump0.zero_of_le_dist (by simpa [Real.dist_eq, bump0] using hy)

theorem deriv_chi_eq_zero {y : ℝ} (hy : 2 < |y|) : deriv chi y = 0 := by
  have hnb : chi =ᶠ[nhds y] fun _ => (0 : ℝ) := by
    filter_upwards [(isOpen_lt continuous_const continuous_abs).mem_nhds hy] with t ht
    exact chi_eq_zero (le_of_lt ht)
  exact ((hasDerivAt_const y (0 : ℝ)).congr_of_eventuallyEq hnb).deriv

/-- The derivative of the reference cutoff is bounded (it is continuous with
compact support). -/
theorem exists_deriv_chi_bound : ∃ C : ℝ, 0 < C ∧ ∀ y, |deriv chi y| ≤ C := by
  have hc : Continuous fun y => |deriv chi y| := deriv_chi_continuous.abs
  have hs : HasCompactSupport fun y => |deriv chi y| :=
    (bump0.hasCompactSupport.deriv).abs
  obtain ⟨y0, hy0⟩ := hc.exists_forall_ge_of_hasCompactSupport hs
  exact ⟨|deriv chi y0| + 1, by positivity, fun y => by linarith [hy0 y]⟩

/-- **Milestone 3.**  The rescaled cutoff `χ_R(x) = χ(x/R)`: it is `1` on
`[-R,R]`, vanishes outside `[-2R,2R]`, and its derivative is bounded by `C/R`. -/
theorem exists_scaled_cutoff {C R : ℝ} (hC : ∀ y, |deriv chi y| ≤ C) (hR : 0 < R) :
    ∃ w wd : ℝ → ℝ, (∀ x, HasDerivAt w (wd x) x) ∧ Continuous w ∧ Continuous wd ∧
      (∀ x : ℝ, 2 * R < |x| → w x = 0) ∧ (∀ x : ℝ, 2 * R < |x| → wd x = 0) ∧
      (∀ x : ℝ, |x| ≤ R → w x = 1) ∧ (∀ x, |wd x| ≤ C / R) := by
  have hRi : (0 : ℝ) < R⁻¹ := by positivity
  refine ⟨fun x => chi (R⁻¹ * x), fun x => deriv chi (R⁻¹ * x) * R⁻¹, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · intro x
    have hlin : HasDerivAt (fun y : ℝ => R⁻¹ * y) R⁻¹ x := by
      simpa using (hasDerivAt_id x).const_mul R⁻¹
    simpa [Function.comp_def] using
      ((chi_differentiable (R⁻¹ * x)).hasDerivAt.comp x hlin)
  · exact chi_continuous.comp (by fun_prop)
  · exact (deriv_chi_continuous.comp (by fun_prop)).mul continuous_const
  · intro x hx
    refine chi_eq_zero ?_
    rw [abs_mul, abs_of_pos hRi]
    have h2 : R⁻¹ * (2 * R) ≤ R⁻¹ * |x| := by nlinarith
    calc (2 : ℝ) = R⁻¹ * (2 * R) := by field_simp
      _ ≤ R⁻¹ * |x| := h2
  · intro x hx
    have hgt : (2 : ℝ) < |R⁻¹ * x| := by
      rw [abs_mul, abs_of_pos hRi]
      have h2 : R⁻¹ * (2 * R) < R⁻¹ * |x| := by nlinarith
      calc (2 : ℝ) = R⁻¹ * (2 * R) := by field_simp
        _ < R⁻¹ * |x| := h2
    simp [deriv_chi_eq_zero hgt]
  · intro x hx
    refine chi_eq_one_of_abs_le_one ?_
    rw [abs_mul, abs_of_pos hRi]
    have h2 : R⁻¹ * |x| ≤ R⁻¹ * R := by nlinarith
    calc R⁻¹ * |x| ≤ R⁻¹ * R := h2
      _ = 1 := by field_simp
  · intro x
    rw [abs_mul, abs_of_pos hRi]
    have := hC (R⁻¹ * x)
    rw [div_eq_inv_mul]
    nlinarith [abs_nonneg (deriv chi (R⁻¹ * x))]

/-! ## The derivative of the energy density -/

/-- The derivative of `x ↦ Re(conj (u x) · u'(x))`. -/
theorem hasDerivAt_reInner (u u' u'' : ℝ → ℂ) (x : ℝ)
    (h1 : HasDerivAt u (u' x) x) (h2 : HasDerivAt u' (u'' x) x) :
    HasDerivAt (fun y => ((starRingEnd ℂ) (u y) * u' y).re)
      (‖u' x‖ ^ 2 + ((starRingEnd ℂ) (u x) * u'' x).re) x := by
  have hc : HasDerivAt (fun y => (starRingEnd ℂ) (u y)) ((starRingEnd ℂ) (u' x)) x := h1.star
  have hp : HasDerivAt (fun y => (starRingEnd ℂ) (u y) * u' y)
      ((starRingEnd ℂ) (u' x) * u' x + (starRingEnd ℂ) (u x) * u'' x) x := hc.mul h2
  simpa [Function.comp_def, Complex.reCLM_apply, Complex.add_re, Complex.mul_re,
    Complex.sq_norm, Complex.normSq_apply] using
    (Complex.reCLM.hasFDerivAt.comp_hasDerivAt x hp)

/-! ## Milestone 4: the cutoff energy estimate -/

/-- **The cutoff energy estimate, core form.**  If `u` is a twice differentiable
square-integrable solution of `-u'' + V u = z u` on the line and `Re z ≤ V`
pointwise, then for every `R > 0` both the potential energy and the Dirichlet
energy on `[-R,R]` are `O(1/R²)`:

  `∫_{[-R,R]} (V - Re z)|u|² ≤ (2C²/R²) ∫_ℝ |u|²`  and
  `∫_{[-R,R]} |u'|² ≤ (4C²/R²) ∫_ℝ |u|²`,

where `C` is any bound for `|χ'|`. -/
theorem cutoff_energy_core
    (V : ℝ → ℝ) (hV : Continuous V) (z : ℂ)
    (u u' u'' : ℝ → ℂ)
    (h1 : ∀ x, HasDerivAt u (u' x) x)
    (h2 : ∀ x, HasDerivAt u' (u'' x) x)
    (heq : ∀ x, -u'' x + (V x : ℂ) * u x = z * u x)
    (hVz : ∀ x, 0 ≤ V x - z.re)
    (hL2 : Integrable fun x => ‖u x‖ ^ 2)
    {C : ℝ} (hC : ∀ y, |deriv chi y| ≤ C)
    {R : ℝ} (hR : 0 < R) :
    (∫ x in Set.Icc (-R) R, (V x - z.re) * ‖u x‖ ^ 2)
        ≤ 2 * C ^ 2 / R ^ 2 * (∫ x, ‖u x‖ ^ 2) ∧
      (∫ x in Set.Icc (-R) R, ‖u' x‖ ^ 2) ≤ 4 * C ^ 2 / R ^ 2 * (∫ x, ‖u x‖ ^ 2) := by
  have hCnn : 0 ≤ C := le_trans (abs_nonneg _) (hC 0)
  have heq' : ∀ x, u'' x = ((V x : ℂ) - z) * u x := by
    intro x; linear_combination -heq x
  have hud : Differentiable ℝ u := fun x => (h1 x).differentiableAt
  have hu'd : Differentiable ℝ u' := fun x => (h2 x).differentiableAt
  have hucont : Continuous u := hud.continuous
  have hu'cont : Continuous u' := hu'd.continuous
  obtain ⟨w, wd, hwderiv, hwcont, hwdcont, hwzero, hwdzero, hwone, hwdbound⟩ :=
    exists_scaled_cutoff hC hR
  -- pieces of the energy identity
  set Rf : ℝ → ℝ := fun y => ((starRingEnd ℂ) (u y) * u' y).re with hRfdef
  set P : ℝ → ℝ := fun x => (V x - z.re) * ‖u x‖ ^ 2 with hPdef
  have hP : ∀ x, ((starRingEnd ℂ) (u x) * u'' x).re = P x := by
    intro x
    have hcm : (starRingEnd ℂ) (u x) * u x = (Complex.normSq (u x) : ℂ) :=
      Complex.normSq_eq_conj_mul_self.symm
    have hstep : (starRingEnd ℂ) (u x) * u'' x =
        ((V x : ℂ) - z) * (Complex.normSq (u x) : ℂ) := by
      rw [heq' x, ← hcm]; ring
    rw [hstep, hPdef]
    simp [Complex.mul_re, Complex.sub_re, Complex.sub_im, Complex.sq_norm]
  have hRfcont : Continuous Rf := Complex.continuous_re.comp (hucont.star.mul hu'cont)
  have hPcont : Continuous P := by fun_prop
  set g : ℝ → ℝ := fun x => w x ^ 2 * Rf x with hgdef
  set G : ℝ → ℝ := fun x => 2 * w x * wd x * Rf x + w x ^ 2 * (‖u' x‖ ^ 2 + P x) with hGdef
  have hg : ∀ x, HasDerivAt g (G x) x := by
    intro x
    have hR' := hasDerivAt_reInner u u' u'' x (h1 x) (h2 x)
    rw [hP x] at hR'
    have hw2 : HasDerivAt (fun y => w y ^ 2) (2 * w x * wd x) x := by
      simpa using (hwderiv x).pow 2
    exact hw2.mul hR'
  have hGcont : Continuous G := by fun_prop
  -- compact support of everything built from the cutoff
  have suppOf : ∀ f : ℝ → ℝ, (∀ x : ℝ, 2 * R < |x| → f x = 0) → HasCompactSupport f := by
    intro f hf
    apply HasCompactSupport.intro (isCompact_Icc (a := -(2 * R)) (b := 2 * R))
    intro x hx
    refine hf x ?_
    simp only [Set.mem_Icc, not_and_or, not_le] at hx
    rcases hx with hx | hx
    · rw [abs_of_nonpos (by linarith)]; linarith
    · rw [abs_of_pos (by linarith)]; linarith
  have hgsupp : HasCompactSupport g := suppOf g fun x hx => by simp [hgdef, hwzero x hx]
  have hGzero : ∫ x, G x = 0 := integral_deriv_eq_zero_of_hasCompactSupport hg hGcont hgsupp
  -- the three terms of the energy identity
  set T1 : ℝ → ℝ := fun x => 2 * w x * wd x * Rf x with hT1def
  set T2 : ℝ → ℝ := fun x => w x ^ 2 * ‖u' x‖ ^ 2 with hT2def
  set T3 : ℝ → ℝ := fun x => w x ^ 2 * P x with hT3def
  have hGsum : ∀ x, G x = T1 x + T2 x + T3 x := by
    intro x; simp only [hGdef, hT1def, hT2def, hT3def]; ring
  have hT1cont : Continuous T1 := by fun_prop
  have hT2cont : Continuous T2 := by fun_prop
  have hT3cont : Continuous T3 := by fun_prop
  have hI1 : Integrable T1 :=
    hT1cont.integrable_of_hasCompactSupport (suppOf T1 fun x hx => by simp [hT1def, hwzero x hx])
  have hI2 : Integrable T2 :=
    hT2cont.integrable_of_hasCompactSupport (suppOf T2 fun x hx => by simp [hT2def, hwzero x hx])
  have hI3 : Integrable T3 :=
    hT3cont.integrable_of_hasCompactSupport (suppOf T3 fun x hx => by simp [hT3def, hwzero x hx])
  have hsplit : (∫ x, T1 x) + (∫ x, T2 x) + (∫ x, T3 x) = 0 := by
    have hI12 : Integrable fun x => T1 x + T2 x := hI1.add hI2
    have e1 : (∫ x, G x) = (∫ x, T1 x + T2 x) + ∫ x, T3 x := by
      rw [← integral_add hI12 hI3]
      exact integral_congr_ae (Filter.Eventually.of_forall fun x => hGsum x)
    have e2 : (∫ x, T1 x + T2 x) = (∫ x, T1 x) + ∫ x, T2 x := integral_add hI1 hI2
    rw [e2] at e1
    rw [← e1, hGzero]
  -- Young's inequality on the cross term
  set Q : ℝ → ℝ := fun x => wd x ^ 2 * ‖u x‖ ^ 2 with hQdef
  have hQcont : Continuous Q := by fun_prop
  have hIQ : Integrable Q :=
    hQcont.integrable_of_hasCompactSupport (suppOf Q fun x hx => by simp [hQdef, hwdzero x hx])
  set B : ℝ → ℝ := fun x => 2 * Q x + 1 / 2 * T2 x with hBdef
  have hIB : Integrable B := (hIQ.const_mul 2).add (hI2.const_mul (1 / 2))
  have hyoung : ∀ x, -T1 x ≤ B x := by
    intro x
    have habs : |Rf x| ≤ ‖u x‖ * ‖u' x‖ := by
      calc |Rf x| ≤ ‖(starRingEnd ℂ) (u x) * u' x‖ := Complex.abs_re_le_norm _
        _ = ‖u x‖ * ‖u' x‖ := by rw [norm_mul, RCLike.norm_conj]
    have hb : |T1 x| ≤ 2 * (|wd x| * ‖u x‖) * (|w x| * ‖u' x‖) := by
      have hnn : (0 : ℝ) ≤ 2 * |w x| * |wd x| := by positivity
      calc |T1 x| = 2 * |w x| * |wd x| * |Rf x| := by
            simp only [hT1def, abs_mul, abs_two]
        _ ≤ 2 * |w x| * |wd x| * (‖u x‖ * ‖u' x‖) := by nlinarith [habs]
        _ = 2 * (|wd x| * ‖u x‖) * (|w x| * ‖u' x‖) := by ring
    have hsq : 2 * (|wd x| * ‖u x‖) * (|w x| * ‖u' x‖) ≤
        2 * (|wd x| * ‖u x‖) ^ 2 + 1 / 2 * (|w x| * ‖u' x‖) ^ 2 := by
      nlinarith [sq_nonneg (2 * (|wd x| * ‖u x‖) - (|w x| * ‖u' x‖))]
    have hrw : B x = 2 * (|wd x| * ‖u x‖) ^ 2 + 1 / 2 * (|w x| * ‖u' x‖) ^ 2 := by
      simp only [hBdef, hQdef, hT2def, mul_pow, sq_abs]
    have := le_trans (neg_le_abs (T1 x)) (le_trans hb hsq)
    linarith [hrw]
  have hT1bound : -(∫ x, T1 x) ≤ ∫ x, B x := by
    rw [← integral_neg]
    exact integral_mono hI1.neg hIB hyoung
  have hIBval : (∫ x, B x) = 2 * (∫ x, Q x) + 1 / 2 * (∫ x, T2 x) := by
    rw [hBdef, integral_add (hIQ.const_mul 2) (hI2.const_mul (1 / 2)), integral_const_mul,
      integral_const_mul]
  have hT2nonneg : 0 ≤ ∫ x, T2 x := integral_nonneg fun x => by rw [hT2def]; positivity
  have hT3nonneg : ∀ x, 0 ≤ T3 x := by
    intro x
    have hVpos : 0 ≤ V x - z.re := hVz x
    rw [hT3def, hPdef]; positivity
  have hT3int : 0 ≤ ∫ x, T3 x := integral_nonneg hT3nonneg
  rw [hIBval] at hT1bound
  have hT3le : (∫ x, T3 x) ≤ 2 * (∫ x, Q x) := by
    linarith [hsplit, hT1bound, hT2nonneg]
  have hT2le : (∫ x, T2 x) ≤ 4 * (∫ x, Q x) := by
    linarith [hsplit, hT1bound, hT3int]
  -- bound the gradient term
  have hQle : (∫ x, Q x) ≤ C ^ 2 / R ^ 2 * (∫ x, ‖u x‖ ^ 2) := by
    have hptwise : ∀ x, Q x ≤ C ^ 2 / R ^ 2 * ‖u x‖ ^ 2 := by
      intro x
      have hwd2 : wd x ^ 2 ≤ C ^ 2 / R ^ 2 := by
        have h0 := hwdbound x
        have hCR : (0 : ℝ) ≤ C / R := by positivity
        have : wd x ^ 2 = |wd x| ^ 2 := (sq_abs _).symm
        rw [this]
        calc |wd x| ^ 2 ≤ (C / R) ^ 2 := by nlinarith [abs_nonneg (wd x)]
          _ = C ^ 2 / R ^ 2 := by rw [div_pow]
      rw [hQdef]
      nlinarith [sq_nonneg ‖u x‖, norm_nonneg (u x)]
    calc (∫ x, Q x) ≤ ∫ x, C ^ 2 / R ^ 2 * ‖u x‖ ^ 2 :=
          integral_mono hIQ (hL2.const_mul _) hptwise
      _ = C ^ 2 / R ^ 2 * (∫ x, ‖u x‖ ^ 2) := integral_const_mul _ _
  -- the two left-hand sides
  have hwone' : ∀ x ∈ Set.Icc (-R) R, w x = 1 := by
    intro x hx
    refine hwone x ?_
    rcases hx with ⟨hx1, hx2⟩
    rw [abs_le]; constructor <;> linarith
  have hlhs1 : (∫ x in Set.Icc (-R) R, (V x - z.re) * ‖u x‖ ^ 2) ≤ ∫ x, T3 x := by
    have hIon : IntegrableOn (fun x => (V x - z.re) * ‖u x‖ ^ 2) (Set.Icc (-R) R) :=
      (by fun_prop : Continuous fun x => (V x - z.re) * ‖u x‖ ^ 2).integrableOn_Icc
    have hstep : (∫ x in Set.Icc (-R) R, (V x - z.re) * ‖u x‖ ^ 2)
        ≤ ∫ x in Set.Icc (-R) R, T3 x := by
      refine setIntegral_mono_on hIon hI3.integrableOn measurableSet_Icc fun x hx => le_of_eq ?_
      simp only [hT3def, hPdef, hwone' x hx, one_pow, one_mul]
    exact le_trans hstep
      (setIntegral_le_integral hI3 (Filter.Eventually.of_forall hT3nonneg))
  have hlhs2 : (∫ x in Set.Icc (-R) R, ‖u' x‖ ^ 2) ≤ ∫ x, T2 x := by
    have hIon : IntegrableOn (fun x => ‖u' x‖ ^ 2) (Set.Icc (-R) R) :=
      (by fun_prop : Continuous fun x => ‖u' x‖ ^ 2).integrableOn_Icc
    have hstep : (∫ x in Set.Icc (-R) R, ‖u' x‖ ^ 2) ≤ ∫ x in Set.Icc (-R) R, T2 x := by
      refine setIntegral_mono_on hIon hI2.integrableOn measurableSet_Icc fun x hx => le_of_eq ?_
      simp only [hT2def, hwone' x hx, one_pow, one_mul]
    refine le_trans hstep (setIntegral_le_integral hI2 (Filter.Eventually.of_forall ?_))
    intro x
    rw [hT2def]
    positivity
  have hfinal2 : (2 : ℝ) * (C ^ 2 / R ^ 2 * (∫ x, ‖u x‖ ^ 2)) =
      2 * C ^ 2 / R ^ 2 * (∫ x, ‖u x‖ ^ 2) := by ring
  have hfinal4 : (4 : ℝ) * (C ^ 2 / R ^ 2 * (∫ x, ‖u x‖ ^ 2)) =
      4 * C ^ 2 / R ^ 2 * (∫ x, ‖u x‖ ^ 2) := by ring
  exact ⟨by linarith [hlhs1, hT3le, hQle, hfinal2],
    by linarith [hlhs2, hT2le, hQle, hfinal4]⟩

/-- **The cutoff energy estimate** (Milestone 4 of the plan).  If `u` is a twice
differentiable square-integrable solution of `-u'' + V u = z u` on the line and
`Re z + 1 ≤ V` pointwise, then for every `R > 0`

  `∫_{[-R,R]} |u|² ≤ (2C²/R²) ∫_ℝ |u|²`,

where `C` is any bound for `|χ'|`. -/
theorem cutoff_energy_estimate
    (V : ℝ → ℝ) (hV : Continuous V) (z : ℂ)
    (u u' u'' : ℝ → ℂ)
    (h1 : ∀ x, HasDerivAt u (u' x) x)
    (h2 : ∀ x, HasDerivAt u' (u'' x) x)
    (heq : ∀ x, -u'' x + (V x : ℂ) * u x = z * u x)
    (hVz : ∀ x, 1 ≤ V x - z.re)
    (hL2 : Integrable fun x => ‖u x‖ ^ 2)
    {C : ℝ} (hC : ∀ y, |deriv chi y| ≤ C)
    {R : ℝ} (hR : 0 < R) :
    ∫ x in Set.Icc (-R) R, ‖u x‖ ^ 2 ≤ 2 * C ^ 2 / R ^ 2 * ∫ x, ‖u x‖ ^ 2 := by
  have hud : Differentiable ℝ u := fun x => (h1 x).differentiableAt
  have hucont : Continuous u := hud.continuous
  refine le_trans ?_ (cutoff_energy_core V hV z u u' u'' h1 h2 heq
    (fun x => le_trans zero_le_one (hVz x)) hL2 hC hR).1
  refine setIntegral_mono_on hL2.integrableOn
    ((by fun_prop : Continuous fun x => (V x - z.re) * ‖u x‖ ^ 2).integrableOn_Icc)
    measurableSet_Icc fun x _ => ?_
  nlinarith [hVz x, sq_nonneg ‖u x‖, norm_nonneg (u x)]

/-! ## Milestone 5: the limit `R → ∞` -/

/-- **The main vanishing theorem.**  A square-integrable classical solution of
`-u'' + V u = z u` on the line, with `Re z + 1 ≤ V` pointwise, is identically
zero. -/
theorem l2_classical_solution_eq_zero
    (V : ℝ → ℝ) (hV : Continuous V) (z : ℂ)
    (u u' u'' : ℝ → ℂ)
    (h1 : ∀ x, HasDerivAt u (u' x) x)
    (h2 : ∀ x, HasDerivAt u' (u'' x) x)
    (heq : ∀ x, -u'' x + (V x : ℂ) * u x = z * u x)
    (hVz : ∀ x, 1 ≤ V x - z.re)
    (hL2 : Integrable fun x => ‖u x‖ ^ 2) :
    u = 0 := by
  obtain ⟨C, hC0, hC⟩ := exists_deriv_chi_bound
  have hud : Differentiable ℝ u := fun x => (h1 x).differentiableAt
  have hucont : Continuous u := hud.continuous
  set A : ℝ := ∫ x, ‖u x‖ ^ 2 with hAdef
  have hA0 : 0 ≤ A := integral_nonneg fun x => by positivity
  -- the sets `Icc (-(n+1)) (n+1)` increase to the line
  have hmono : Monotone fun n : ℕ => Set.Icc (-((n : ℝ) + 1)) ((n : ℝ) + 1) := by
    intro m n hmn
    have hmn' : ((m : ℝ)) ≤ (n : ℝ) := by exact_mod_cast hmn
    exact Set.Icc_subset_Icc (by linarith) (by linarith)
  have hunion : (⋃ n : ℕ, Set.Icc (-((n : ℝ) + 1)) ((n : ℝ) + 1)) = Set.univ := by
    refine Set.eq_univ_of_forall fun x => ?_
    obtain ⟨n, hn⟩ := exists_nat_ge |x|
    exact Set.mem_iUnion.mpr ⟨n, ⟨by linarith [neg_abs_le x], by linarith [le_abs_self x]⟩⟩
  have htend : Tendsto (fun n : ℕ => ∫ x in Set.Icc (-((n : ℝ) + 1)) ((n : ℝ) + 1), ‖u x‖ ^ 2)
      atTop (nhds A) := by
    have h := tendsto_setIntegral_of_monotone (fun _ : ℕ => measurableSet_Icc) hmono
      (by rw [hunion]; exact hL2.integrableOn)
    rwa [hunion, setIntegral_univ, ← hAdef] at h
  have hbnd : Tendsto (fun n : ℕ => 2 * C ^ 2 / ((n : ℝ) + 1) ^ 2 * A) atTop (nhds 0) := by
    have hnn : Tendsto (fun n : ℕ => ((n : ℝ) + 1) ^ 2) atTop atTop :=
      (tendsto_pow_atTop (n := 2) (by norm_num)).comp
        (tendsto_atTop_add_const_right _ 1 tendsto_natCast_atTop_atTop)
    have h := (tendsto_const_nhds (x := 2 * C ^ 2 * A) (f := atTop (α := ℕ))).div_atTop hnn
    refine h.congr fun n => ?_
    ring
  have hAle : A ≤ 0 := by
    refine le_of_tendsto_of_tendsto' htend hbnd fun n => ?_
    exact cutoff_energy_estimate V hV z u u' u'' h1 h2 heq hVz hL2 hC
      (by positivity)
  have hAzero : A = 0 := le_antisymm hAle hA0
  have hae : (fun x => ‖u x‖ ^ 2) =ᵐ[volume] 0 :=
    (integral_eq_zero_iff_of_nonneg (fun x => by positivity) hL2).mp hAzero
  have hu_ae : u =ᵐ[volume] 0 := by
    filter_upwards [hae] with x hx
    have : ‖u x‖ ^ 2 = 0 := hx
    have : ‖u x‖ = 0 := by nlinarith [norm_nonneg (u x)]
    simpa using this
  exact (Continuous.ae_eq_iff_eq volume hucont continuous_const).mp hu_ae

/-- A continuous nonnegative function on the line whose integral over every
interval `[-(n+1), n+1]` vanishes is identically zero. -/
theorem eq_zero_of_setIntegral_Icc_eq_zero {f : ℝ → ℝ} (hf : Continuous f)
    (h0 : ∀ x, 0 ≤ f x)
    (h : ∀ n : ℕ, ∫ x in Set.Icc (-((n : ℝ) + 1)) ((n : ℝ) + 1), f x = 0) :
    f = 0 := by
  have key : ∀ n : ℕ, ∀ᵐ x, x ∈ Set.Icc (-((n : ℝ) + 1)) ((n : ℝ) + 1) → f x = 0 := by
    intro n
    have hres := (setIntegral_eq_zero_iff_of_nonneg_ae
      (Filter.Eventually.of_forall fun x => h0 x) hf.integrableOn_Icc).mp (h n)
    exact (ae_restrict_iff' measurableSet_Icc).mp hres
  have hall : ∀ᵐ x, ∀ n : ℕ, x ∈ Set.Icc (-((n : ℝ) + 1)) ((n : ℝ) + 1) → f x = 0 :=
    ae_all_iff.mpr key
  have hae : f =ᵐ[volume] 0 := by
    filter_upwards [hall] with x hx
    obtain ⟨n, hn⟩ := exists_nat_ge |x|
    exact hx n ⟨by linarith [neg_abs_le x], by linarith [le_abs_self x]⟩
  exact (Continuous.ae_eq_iff_eq volume hf continuous_const).mp hae

/-- **The vanishing theorem under the weaker hypothesis `Re z ≤ V`.**  Here the
potential-energy term need not control `|u|²` itself, so instead we run the
limit on the Dirichlet term: `∫_{[-R,R]} |u'|² ≤ (4C²/R²) ∫_ℝ |u|² → 0` forces
`u' ≡ 0`, hence `u` is constant, and a constant in `L²(ℝ)` is zero. -/
theorem l2_classical_solution_eq_zero_of_nonneg
    (V : ℝ → ℝ) (hV : Continuous V) (z : ℂ)
    (u u' u'' : ℝ → ℂ)
    (h1 : ∀ x, HasDerivAt u (u' x) x)
    (h2 : ∀ x, HasDerivAt u' (u'' x) x)
    (heq : ∀ x, -u'' x + (V x : ℂ) * u x = z * u x)
    (hVz : ∀ x, 0 ≤ V x - z.re)
    (hL2 : Integrable fun x => ‖u x‖ ^ 2) :
    u = 0 := by
  obtain ⟨C, hC0, hC⟩ := exists_deriv_chi_bound
  have hud : Differentiable ℝ u := fun x => (h1 x).differentiableAt
  have hu'd : Differentiable ℝ u' := fun x => (h2 x).differentiableAt
  have hu'cont : Continuous u' := hu'd.continuous
  have hg : Continuous fun x => ‖u' x‖ ^ 2 := by fun_prop
  set A : ℝ := ∫ x, ‖u x‖ ^ 2 with hAdef
  have hA0 : 0 ≤ A := integral_nonneg fun x => by positivity
  have hzero : ∀ n : ℕ, ∫ x in Set.Icc (-((n : ℝ) + 1)) ((n : ℝ) + 1), ‖u' x‖ ^ 2 = 0 := by
    intro n
    set R0 : ℝ := (n : ℝ) + 1 with hR0def
    have hR0pos : (0 : ℝ) < R0 := by positivity
    have hle : ∀ m : ℕ, (∫ x in Set.Icc (-R0) R0, ‖u' x‖ ^ 2)
        ≤ 4 * C ^ 2 / ((m : ℝ) + R0) ^ 2 * A := by
      intro m
      have hmnn : (0 : ℝ) ≤ (m : ℝ) := Nat.cast_nonneg m
      have hRpos : (0 : ℝ) < (m : ℝ) + R0 := by linarith
      have hsub : Set.Icc (-R0) R0 ⊆ Set.Icc (-((m : ℝ) + R0)) ((m : ℝ) + R0) :=
        Set.Icc_subset_Icc (by linarith) (by linarith)
      have hstep := setIntegral_mono_set (hg.integrableOn_Icc (μ := volume))
        (Filter.Eventually.of_forall fun x => by positivity) hsub.eventuallyLE
      exact le_trans hstep
        (cutoff_energy_core V hV z u u' u'' h1 h2 heq hVz hL2 hC hRpos).2
    have htend : Tendsto (fun m : ℕ => 4 * C ^ 2 / ((m : ℝ) + R0) ^ 2 * A) atTop (nhds 0) := by
      have hnn : Tendsto (fun m : ℕ => ((m : ℝ) + R0) ^ 2) atTop atTop :=
        (tendsto_pow_atTop (n := 2) (by norm_num)).comp
          (tendsto_atTop_add_const_right _ R0 tendsto_natCast_atTop_atTop)
      have h := (tendsto_const_nhds (x := 4 * C ^ 2 * A) (f := atTop (α := ℕ))).div_atTop hnn
      exact h.congr fun m => by ring
    have hle0 : (∫ x in Set.Icc (-R0) R0, ‖u' x‖ ^ 2) ≤ 0 :=
      ge_of_tendsto htend (Filter.Eventually.of_forall hle)
    have hge0 : (0 : ℝ) ≤ ∫ x in Set.Icc (-R0) R0, ‖u' x‖ ^ 2 :=
      setIntegral_nonneg measurableSet_Icc fun x _ => by positivity
    linarith
  have hu'zero : (fun x => ‖u' x‖ ^ 2) = 0 :=
    eq_zero_of_setIntegral_Icc_eq_zero hg (fun x => by positivity) hzero
  have hu'0 : ∀ x, u' x = 0 := by
    intro x
    have hx : ‖u' x‖ ^ 2 = 0 := congrFun hu'zero x
    have : ‖u' x‖ = 0 := by nlinarith [norm_nonneg (u' x)]
    simpa using this
  have hconst : ∀ x, u x = u 0 :=
    fun x => is_const_of_deriv_eq_zero hud (fun y => by rw [(h1 y).deriv, hu'0 y]) x 0
  have hL2' : Integrable fun _ : ℝ => ‖u 0‖ ^ 2 := by
    refine hL2.congr ?_
    filter_upwards with x using by rw [hconst x]
  have hc : ‖u 0‖ ^ 2 = 0 := by
    rcases integrable_const_iff.mp hL2' with h | h
    · exact h
    · exact absurd h.measure_univ_lt_top (by rw [Real.volume_univ]; exact lt_irrefl _)
  have hu0 : u 0 = 0 := by
    have : ‖u 0‖ = 0 := by nlinarith [norm_nonneg (u 0)]
    simpa using this
  funext x
  simpa [hu0] using hconst x

/-- **The free Laplacian on the line has trivial deficiency spaces** (for
classical square-integrable solutions).  If `-u'' = z u` with `Re z ≤ 0` and
`u ∈ L²(ℝ)` is twice differentiable, then `u = 0`.  This is the `V = 0` case of
`l2_classical_solution_eq_zero_of_nonneg`. -/
theorem laplacian_deficiency_trivial (z : ℂ) (hz : z.re ≤ 0)
    (u u' u'' : ℝ → ℂ)
    (h1 : ∀ x, HasDerivAt u (u' x) x)
    (h2 : ∀ x, HasDerivAt u' (u'' x) x)
    (heq : ∀ x, -u'' x = z * u x)
    (hL2 : Integrable fun x => ‖u x‖ ^ 2) :
    u = 0 :=
  l2_classical_solution_eq_zero_of_nonneg (fun _ => 0) continuous_const z u u' u''
    h1 h2 (fun x => by simpa using heq x) (fun _ => by simpa using hz) hL2

/-- Deficiency index `+i` for the free Laplacian: `-u'' = i u` in `L²(ℝ)` forces
`u = 0`. -/
theorem laplacian_deficiency_trivial_I
    (u u' u'' : ℝ → ℂ)
    (h1 : ∀ x, HasDerivAt u (u' x) x)
    (h2 : ∀ x, HasDerivAt u' (u'' x) x)
    (heq : ∀ x, -u'' x = Complex.I * u x)
    (hL2 : Integrable fun x => ‖u x‖ ^ 2) :
    u = 0 :=
  laplacian_deficiency_trivial Complex.I (by simp) u u' u'' h1 h2 heq hL2

/-- Deficiency index `-i` for the free Laplacian: `-u'' = -i u` in `L²(ℝ)` forces
`u = 0`. -/
theorem laplacian_deficiency_trivial_negI
    (u u' u'' : ℝ → ℂ)
    (h1 : ∀ x, HasDerivAt u (u' x) x)
    (h2 : ∀ x, HasDerivAt u' (u'' x) x)
    (heq : ∀ x, -u'' x = -Complex.I * u x)
    (hL2 : Integrable fun x => ‖u x‖ ^ 2) :
    u = 0 :=
  laplacian_deficiency_trivial (-Complex.I) (by simp) u u' u'' h1 h2 heq hL2

/-! ## Milestone 2: the operator on the smooth compactly supported core -/

/-- The Schrödinger operator `H f = -f'' + V f` on the line. -/
noncomputable def schrodingerOp (V : ℝ → ℝ) (f : ℝ → ℂ) : ℝ → ℂ :=
  fun x => -deriv (deriv f) x + (V x : ℂ) * f x

theorem schrodingerOp_apply (V : ℝ → ℝ) (f f' f'' : ℝ → ℂ)
    (hf1 : ∀ x, HasDerivAt f (f' x) x) (hf2 : ∀ x, HasDerivAt f' (f'' x) x) (x : ℝ) :
    schrodingerOp V f x = -f'' x + (V x : ℂ) * f x := by
  have hfd : deriv f = f' := funext fun y => (hf1 y).deriv
  simp only [schrodingerOp, hfd, (hf2 x).deriv]

/-- Integration by parts twice: `∫ conj (f'') g = ∫ conj f g''` for compactly
supported twice differentiable data. -/
theorem integral_conj_secondDeriv_comm
    (f g f' f'' g' g'' : ℝ → ℂ)
    (hf1 : ∀ x, HasDerivAt f (f' x) x) (hf2 : ∀ x, HasDerivAt f' (f'' x) x)
    (hg1 : ∀ x, HasDerivAt g (g' x) x) (hg2 : ∀ x, HasDerivAt g' (g'' x) x)
    (hf''c : Continuous f'') (hg''c : Continuous g'')
    (hfs : HasCompactSupport f) (hgs : HasCompactSupport g) :
    (∫ x, (starRingEnd ℂ) (f'' x) * g x) = ∫ x, (starRingEnd ℂ) (f x) * g'' x := by
  have hfd : Differentiable ℝ f := fun x => (hf1 x).differentiableAt
  have hf'd : Differentiable ℝ f' := fun x => (hf2 x).differentiableAt
  have hgd : Differentiable ℝ g := fun x => (hg1 x).differentiableAt
  have hg'd : Differentiable ℝ g' := fun x => (hg2 x).differentiableAt
  have hfc : Continuous f := hfd.continuous
  have hf'c : Continuous f' := hf'd.continuous
  have hgc : Continuous g := hgd.continuous
  have hg'c : Continuous g' := hg'd.continuous
  have hf's : HasCompactSupport f' := by
    rw [show f' = deriv f from funext fun x => ((hf1 x).deriv).symm]; exact hfs.deriv
  have hg's : HasCompactSupport g' := by
    rw [show g' = deriv g from funext fun x => ((hg1 x).deriv).symm]; exact hgs.deriv
  have hconjf : HasCompactSupport fun x => (starRingEnd ℂ) (f x) :=
    hfs.comp_left (g := starRingEnd ℂ) (by simp)
  -- first integration by parts, with `k = conj f' · g`
  have hk : ∀ x, HasDerivAt (fun y => (starRingEnd ℂ) (f' y) * g y)
      ((starRingEnd ℂ) (f'' x) * g x + (starRingEnd ℂ) (f' x) * g' x) x :=
    fun x => ((hf2 x).star).mul (hg1 x)
  have hk0 := integral_deriv_eq_zero_of_hasCompactSupport hk (by fun_prop) hgs.mul_left
  -- second integration by parts, with `m = conj f · g'`
  have hm : ∀ x, HasDerivAt (fun y => (starRingEnd ℂ) (f y) * g' y)
      ((starRingEnd ℂ) (f' x) * g' x + (starRingEnd ℂ) (f x) * g'' x) x :=
    fun x => ((hf1 x).star).mul (hg2 x)
  have hm0 := integral_deriv_eq_zero_of_hasCompactSupport hm (by fun_prop) hconjf.mul_right
  -- integrability of the three pieces
  have i1 : Integrable fun x => (starRingEnd ℂ) (f'' x) * g x :=
    (by fun_prop : Continuous fun x => (starRingEnd ℂ) (f'' x) * g x)
      |>.integrable_of_hasCompactSupport hgs.mul_left
  have i2 : Integrable fun x => (starRingEnd ℂ) (f' x) * g' x :=
    (by fun_prop : Continuous fun x => (starRingEnd ℂ) (f' x) * g' x)
      |>.integrable_of_hasCompactSupport hg's.mul_left
  have i3 : Integrable fun x => (starRingEnd ℂ) (f x) * g'' x :=
    (by fun_prop : Continuous fun x => (starRingEnd ℂ) (f x) * g'' x)
      |>.integrable_of_hasCompactSupport hconjf.mul_right
  rw [integral_add i1 i2] at hk0
  rw [integral_add i2 i3] at hm0
  linear_combination (norm := module) hk0 - hm0

/-- **Symmetry of `H = -d²/dx² + V` on the smooth compactly supported core.**
This is Milestone 2 of the plan: the operator is well defined and Hermitian on
compactly supported twice differentiable functions, for any real continuous `V`
(no growth restriction whatsoever). -/
theorem schrodingerOp_symmetric (V : ℝ → ℝ) (hV : Continuous V)
    (f g f' f'' g' g'' : ℝ → ℂ)
    (hf1 : ∀ x, HasDerivAt f (f' x) x) (hf2 : ∀ x, HasDerivAt f' (f'' x) x)
    (hg1 : ∀ x, HasDerivAt g (g' x) x) (hg2 : ∀ x, HasDerivAt g' (g'' x) x)
    (hf''c : Continuous f'') (hg''c : Continuous g'')
    (hfs : HasCompactSupport f) (hgs : HasCompactSupport g) :
    (∫ x, (starRingEnd ℂ) (schrodingerOp V f x) * g x)
      = ∫ x, (starRingEnd ℂ) (f x) * schrodingerOp V g x := by
  have hfd : Differentiable ℝ f := fun x => (hf1 x).differentiableAt
  have hgd : Differentiable ℝ g := fun x => (hg1 x).differentiableAt
  have hfc : Continuous f := hfd.continuous
  have hgc : Continuous g := hgd.continuous
  have hconjf : HasCompactSupport fun x => (starRingEnd ℂ) (f x) :=
    hfs.comp_left (g := starRingEnd ℂ) (by simp)
  have key := integral_conj_secondDeriv_comm f g f' f'' g' g'' hf1 hf2 hg1 hg2 hf''c hg''c hfs hgs
  have hcs : HasCompactSupport fun x => (starRingEnd ℂ) (f x) * g x := hgs.mul_left
  have iA0 : Integrable fun x => (starRingEnd ℂ) (f'' x) * g x :=
    (by fun_prop : Continuous fun x => (starRingEnd ℂ) (f'' x) * g x)
      |>.integrable_of_hasCompactSupport hgs.mul_left
  have iC0 : Integrable fun x => (starRingEnd ℂ) (f x) * g'' x :=
    (by fun_prop : Continuous fun x => (starRingEnd ℂ) (f x) * g'' x)
      |>.integrable_of_hasCompactSupport hconjf.mul_right
  have iB : Integrable fun x => (V x : ℂ) * ((starRingEnd ℂ) (f x) * g x) :=
    (by fun_prop : Continuous fun x => (V x : ℂ) * ((starRingEnd ℂ) (f x) * g x))
      |>.integrable_of_hasCompactSupport hcs.mul_left
  have e1 : ∀ x, (starRingEnd ℂ) (schrodingerOp V f x) * g x
      = -((starRingEnd ℂ) (f'' x) * g x) + (V x : ℂ) * ((starRingEnd ℂ) (f x) * g x) := by
    intro x
    rw [schrodingerOp_apply V f f' f'' hf1 hf2 x, map_add, map_neg, map_mul, Complex.conj_ofReal]
    ring
  have e2 : ∀ x, (starRingEnd ℂ) (f x) * schrodingerOp V g x
      = -((starRingEnd ℂ) (f x) * g'' x) + (V x : ℂ) * ((starRingEnd ℂ) (f x) * g x) := by
    intro x
    rw [schrodingerOp_apply V g g' g'' hg1 hg2 x]
    ring
  have iA : Integrable fun x => -((starRingEnd ℂ) (f'' x) * g x) := iA0.neg
  have iC : Integrable fun x => -((starRingEnd ℂ) (f x) * g'' x) := iC0.neg
  rw [integral_congr_ae (Filter.Eventually.of_forall e1),
      integral_congr_ae (Filter.Eventually.of_forall e2),
      integral_add iA iB, integral_add iC iB, integral_neg, integral_neg, key]

/-! ## The exponential potential -/

/-- The non-polynomial potential `V(x) = eˣ + e⁻ˣ` of the plan. -/
noncomputable def Vexp : ℝ → ℝ := fun x => Real.exp x + Real.exp (-x)

theorem Vexp_continuous : Continuous Vexp := by
  unfold Vexp; fun_prop

theorem two_le_Vexp (x : ℝ) : 2 ≤ Vexp x := by
  have hp : 0 < Real.exp x := Real.exp_pos x
  have hcancel : Real.exp x * (Real.exp x)⁻¹ = 1 := mul_inv_cancel₀ (ne_of_gt hp)
  rw [Vexp, Real.exp_neg]
  nlinarith [sq_nonneg (Real.exp x - 1), hp, hcancel]

/-- **The classical deficiency spaces of `-d²/dx² + (eˣ + e⁻ˣ)` are trivial.**
There is no nonzero square-integrable classical solution of `H u = z u` for any
`z` with `Re z ≤ 1`; in particular for `z = ± i`, which is exactly the
essential-self-adjointness condition. -/
theorem schrodinger_exp_deficiency_trivial
    (z : ℂ) (hz : z.re ≤ 1)
    (u u' u'' : ℝ → ℂ)
    (h1 : ∀ x, HasDerivAt u (u' x) x)
    (h2 : ∀ x, HasDerivAt u' (u'' x) x)
    (heq : ∀ x, -u'' x + (Vexp x : ℂ) * u x = z * u x)
    (hL2 : Integrable fun x => ‖u x‖ ^ 2) :
    u = 0 :=
  l2_classical_solution_eq_zero Vexp Vexp_continuous z u u' u'' h1 h2 heq
    (fun x => by linarith [two_le_Vexp x]) hL2

/-- The deficiency space at `+i`. -/
theorem schrodinger_exp_deficiency_trivial_I
    (u u' u'' : ℝ → ℂ)
    (h1 : ∀ x, HasDerivAt u (u' x) x)
    (h2 : ∀ x, HasDerivAt u' (u'' x) x)
    (heq : ∀ x, -u'' x + (Vexp x : ℂ) * u x = Complex.I * u x)
    (hL2 : Integrable fun x => ‖u x‖ ^ 2) :
    u = 0 :=
  schrodinger_exp_deficiency_trivial Complex.I (by simp) u u' u'' h1 h2 heq hL2

/-- The deficiency space at `-i`. -/
theorem schrodinger_exp_deficiency_trivial_negI
    (u u' u'' : ℝ → ℂ)
    (h1 : ∀ x, HasDerivAt u (u' x) x)
    (h2 : ∀ x, HasDerivAt u' (u'' x) x)
    (heq : ∀ x, -u'' x + (Vexp x : ℂ) * u x = (-Complex.I) * u x)
    (hL2 : Integrable fun x => ‖u x‖ ^ 2) :
    u = 0 :=
  schrodinger_exp_deficiency_trivial (-Complex.I) (by simp) u u' u'' h1 h2 heq hL2

end BookProof.SchrodingerCutoff
