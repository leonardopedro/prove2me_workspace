import Mathlib
import BookProof.ChapterQgHermiteOscillatorEsa

/-!
# The exponentially growing scalaron potential is essentially self-adjoint on the
Gauss–polynomial (Hermite) core

`CONSOLIDATED_PLAN.md` §10.6.1 target 4 asks for **essential** self-adjointness on the
Gauss–polynomial core of `L²(ℝᵈ)` for the potentials of the gauge-fixed `R + αR²`
Hamiltonian.  `BookProof.ChapterQgHermiteOscillatorEsa` settles the conformal-mode
(harmonic) potential `‖x‖²/4`, and, by Kato–Rellich, harmonic-plus-*bounded*; the
Starobinsky scalaron potential

`V(φ) = (M⁴/16α)(1 − e^{−√(2/3)φ/M})²`

is neither, since it grows **exponentially** as `φ → −∞`.  On the compactly supported
smooth core the exponential wall was already shown to be harmless
(`BookProof.ChapterScalaronCoreEsa`), but that core is not the core the Hermite/SIRK
numerics work in.

This module removes the restriction for the **potential term** on the *Hermite* core: for
every continuous, exponentially bounded real potential `W` on `ℝᵈ` — in particular for the
scalaron potential and for the full two-variable sector potential `V₃(R_c) + V(φ)` —
multiplication by `W` is essentially self-adjoint on the Gauss–polynomial core.

## The argument

A deficiency vector `w ∈ L²` at a non-real `z` satisfies `∫ p e^{−‖x‖²/4} (W − z) w = 0`
for every polynomial `p`.  The function `u = (W − z)w` is *not* in `L²` (it is only in
`L²_loc`, `W` being unbounded), so the moment lemma of
`BookProof.ChapterHermiteProductCore` does not apply verbatim.  What does survive — and is
all the Fourier argument ever needed — is `GaussExpDecay u`: `e^{c‖x‖}e^{−‖x‖²/4}u` is
integrable for *every* `c`, because `|u| ≤ C e^{c‖x‖}|w|` and the Gaussian beats every
exponential while `w ∈ L²`.  Under that hypothesis the Fourier transform of `e^{−‖x‖²/4}u`
is given by an everywhere convergent power series whose coefficients are the (vanishing)
moments, hence is identically zero, hence `u = 0` a.e.; and `W − z ≠ 0` pointwise because
`W` is real and `z` is not, so `w = 0`.

## What is proved

* `GaussExpDecay`, `gaussExpDecay_of_memLp_mul`, `integrable_pgFun_mul_of_gaussExpDecay` —
  the growth class replacing `MemLp _ 2` in the moment argument;
* `fourier_gaussD_mul_eq_zero_of_gaussExpDecay`, `ae_eq_zero_of_moments_of_gaussExpDecay` —
  the generalized moment/Fourier uniqueness lemma;
* `potCore_deficiencyTrivialAt`, `potCore_essentiallySelfAdjoint` — the headline statement,
  for an arbitrary continuous exponentially bounded real potential;
* `scalaronPot_essentiallySelfAdjoint`, `scalaronSector_essentiallySelfAdjoint` — the two
  instances the plan asks for (the one-variable scalaron potential and the reduced
  `(R_c, φ)` sector potential `V₃ + V`);
* `potCore_stone_flow`, `scalaronPot_stone_flow`, `scalaronSector_stone_flow` — the
  self-adjoint realization and the unitary group it generates, obtained from essential
  self-adjointness rather than from a choice of extension.

**Honest boundary.**  What is proved here is essential self-adjointness of the *potential*
term on the Hermite core, for exponentially growing potentials.  The sum `−Δ + V` on the
Hermite core with the exponential scalaron potential is *not* claimed: §10.6.1 target 4 for
the full Hamiltonian remains open (the Friedrichs extension of
`BookProof.ChapterQgHermiteFriedrichs` continues to be what is available there).
-/

namespace BookProof.ScalaronHermiteEsa

open MeasureTheory Complex MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

/-! ## 1. The growth class -/

/-- `u` has **Gaussian exponential decay**: multiplied by the Gaussian `e^{−‖x‖²/4}` it stays
integrable against every exponential `e^{c‖x‖}`.  This is the hypothesis under which the
moment/Fourier argument of `BookProof.ChapterHermiteProductCore` works; it is strictly
weaker than `MemLp u 2` in the direction that matters here — `u` may grow exponentially. -/
def GaussExpDecay (u : Vd d → ℂ) : Prop :=
  ∀ c : ℝ, Integrable (fun x : Vd d => ((Real.exp (c * ‖x‖) * gaussD x : ℝ) : ℂ) * u x)

/-- The continuous weight `x ↦ e^{c‖x‖}e^{−‖x‖²/4}`, as a complex valued function. -/
theorem continuous_expGauss (c : ℝ) :
    Continuous fun x : Vd d => ((Real.exp (c * ‖x‖) * gaussD x : ℝ) : ℂ) :=
  Complex.continuous_ofReal.comp
    ((Real.continuous_exp.comp (continuous_const.mul continuous_norm)).mul continuous_gaussD)

theorem norm_expGauss (c : ℝ) (x : Vd d) :
    ‖((Real.exp (c * ‖x‖) * gaussD x : ℝ) : ℂ)‖ = Real.exp (c * ‖x‖) * gaussD x := by
  rw [Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (mul_pos (Real.exp_pos _) (gaussD_pos x)).le]

/-- A function of Gaussian exponential decay is measurable. -/
theorem GaussExpDecay.aestronglyMeasurable {u : Vd d → ℂ} (hu : GaussExpDecay u) :
    AEStronglyMeasurable u (volume : Measure (Vd d)) := by
  have h0 := (hu 0).aestronglyMeasurable
  simp only [zero_mul, Real.exp_zero, one_mul] at h0
  have hinv : Continuous fun x : Vd d => (((gaussD x)⁻¹ : ℝ) : ℂ) :=
    Complex.continuous_ofReal.comp
      (continuous_gaussD.inv₀ fun x => ne_of_gt (gaussD_pos x))
  refine (hinv.aestronglyMeasurable.mul h0).congr (Filter.Eventually.of_forall fun x => ?_)
  simp only [Pi.mul_apply]
  rw [← mul_assoc, ← Complex.ofReal_mul, inv_mul_cancel₀ (ne_of_gt (gaussD_pos x)),
    Complex.ofReal_one, one_mul]

/-- An exponentially bounded multiple of an `L²` function has Gaussian exponential decay. -/
theorem gaussExpDecay_of_memLp_mul {u w : Vd d → ℂ} {C c : ℝ}
    (hu : AEStronglyMeasurable u (volume : Measure (Vd d)))
    (hw : MemLp w 2 (volume : Measure (Vd d)))
    (hbd : ∀ x, ‖u x‖ ≤ C * Real.exp (c * ‖x‖) * ‖w x‖) :
    GaussExpDecay u := by
  intro s
  have hmaj : Integrable
      (fun x : Vd d => ((Real.exp ((s + c) * ‖x‖) * gaussD x : ℝ) : ℂ) * w x) :=
    integrable_mul_of_memLp_two (memLp_two_exp_norm_mul_gaussD (s + c)) hw
  refine Integrable.mono' (hmaj.norm.const_mul C)
    ((continuous_expGauss s).aestronglyMeasurable.mul hu)
    (Filter.Eventually.of_forall fun x => ?_)
  have hexp : Real.exp ((s + c) * ‖x‖) = Real.exp (s * ‖x‖) * Real.exp (c * ‖x‖) := by
    rw [← Real.exp_add]; ring_nf
  rw [norm_mul, norm_expGauss, norm_mul, norm_expGauss, hexp]
  have h1 : Real.exp (s * ‖x‖) * gaussD x * ‖u x‖
      ≤ Real.exp (s * ‖x‖) * gaussD x * (C * Real.exp (c * ‖x‖) * ‖w x‖) :=
    mul_le_mul_of_nonneg_left (hbd x) (mul_pos (Real.exp_pos _) (gaussD_pos x)).le
  calc Real.exp (s * ‖x‖) * gaussD x * ‖u x‖
      ≤ Real.exp (s * ‖x‖) * gaussD x * (C * Real.exp (c * ‖x‖) * ‖w x‖) := h1
    _ = C * (Real.exp (s * ‖x‖) * Real.exp (c * ‖x‖) * gaussD x * ‖w x‖) := by ring

/-- A polynomial times the Gaussian, against a function of Gaussian exponential decay,
is integrable. -/
theorem integrable_pgFun_mul_of_gaussExpDecay {u : Vd d → ℂ} (hu : GaussExpDecay u)
    (p : MvPolynomial (Fin d) ℂ) : Integrable (fun x : Vd d => pgFun p x * u x) := by
  obtain ⟨C, c, hC, hc, hb⟩ := exists_exp_bound_mvPolyEval p
  refine Integrable.mono' ((hu c).norm.const_mul C)
    ((continuous_pgFun p).aestronglyMeasurable.mul hu.aestronglyMeasurable)
    (Filter.Eventually.of_forall fun x => ?_)
  rw [norm_mul, pgFun, norm_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_pos (gaussD_pos x), norm_mul, norm_expGauss]
  have hnn : (0 : ℝ) ≤ gaussD x * ‖u x‖ := mul_nonneg (gaussD_pos x).le (norm_nonneg _)
  calc ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p‖ * gaussD x * ‖u x‖
      = ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p‖ * (gaussD x * ‖u x‖) := by ring
    _ ≤ C * Real.exp (c * ‖x‖) * (gaussD x * ‖u x‖) :=
        mul_le_mul_of_nonneg_right (hb x) hnn
    _ = C * (Real.exp (c * ‖x‖) * gaussD x * ‖u x‖) := by ring

/-! ## 2. The generalized moment lemma -/

/-- If all Gaussian moments of `u` vanish, the Fourier transform of `e^{−‖x‖²/4}u` vanishes
identically.  The `MemLp` hypothesis of
`BookProof.HermiteProductCore.fourier_gaussD_mul_eq_zero` is replaced by `GaussExpDecay`. -/
theorem fourier_gaussD_mul_eq_zero_of_gaussExpDecay {u : Vd d → ℂ} (hu : GaussExpDecay u)
    (hmom : ∀ p : MvPolynomial (Fin d) ℂ, ∫ x : Vd d, pgFun p x * u x = 0) (w : Vd d) :
    𝓕 (fun x : Vd d => ((gaussD x : ℝ) : ℂ) * u x) w = 0 := by
  set F : ℕ → Vd d → ℂ := fun N x =>
    (∑ k ∈ Finset.range N,
        (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ)) ^ k / (k.factorial : ℂ))
      * (((gaussD x : ℝ) : ℂ) * u x) with hF
  have hterm : ∀ p : MvPolynomial (Fin d) ℂ, Integrable (fun x : Vd d => pgFun p x * u x) :=
    fun p => integrable_pgFun_mul_of_gaussExpDecay hu p
  have hFint : ∀ N, ∫ x : Vd d, F N x = 0 := by
    intro N
    have hpt : ∀ x : Vd d, F N x = ∑ k ∈ Finset.range N,
        ((Complex.I * ((-2 * Real.pi : ℝ) : ℂ)) ^ k / (k.factorial : ℂ))
          * (pgFun ((innerPoly w) ^ k) x * u x) := by
      intro x
      simp only [hF, Finset.sum_mul]
      refine Finset.sum_congr rfl fun k _ => ?_
      rw [pgFun_innerPoly_pow]
      push_cast
      ring
    simp_rw [hpt]
    rw [integral_finset_sum _ (fun k _ => (hterm _).const_mul _)]
    simp [integral_const_mul, hmom]
  set c : ℝ := 2 * Real.pi * ‖w‖ with hc
  have hbdd : Integrable (fun x : Vd d => ((Real.exp (c * ‖x‖) * gaussD x : ℝ) : ℂ) * u x) :=
    hu c
  have hgu : AEStronglyMeasurable (fun x : Vd d => ((gaussD x : ℝ) : ℂ) * u x)
      (volume : Measure (Vd d)) :=
    ((Complex.continuous_ofReal.comp continuous_gaussD).aestronglyMeasurable).mul
      hu.aestronglyMeasurable
  have hmeas : ∀ N, AEStronglyMeasurable (F N) (volume : Measure (Vd d)) := by
    intro N
    refine AEStronglyMeasurable.mul (Continuous.aestronglyMeasurable ?_) hgu
    refine continuous_finset_sum _ fun k _ => ?_
    refine Continuous.div_const ?_ _
    exact (continuous_const.mul (Complex.continuous_ofReal.comp
      (continuous_const.mul (by fun_prop)))).pow k
  have hdom : ∀ N, ∀ᵐ x : Vd d, ‖F N x‖
      ≤ ‖((Real.exp (c * ‖x‖) * gaussD x : ℝ) : ℂ) * u x‖ := by
    intro N
    filter_upwards with x
    have hinner : |(inner ℝ x w : ℝ)| ≤ ‖x‖ * ‖w‖ := abs_real_inner_le_norm x w
    have hsum : ‖∑ k ∈ Finset.range N,
        (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ)) ^ k / (k.factorial : ℂ)‖
        ≤ Real.exp (c * ‖x‖) := by
      have hstep : ∀ k ∈ Finset.range N,
          ‖(Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ)) ^ k / (k.factorial : ℂ)‖
            ≤ (c * ‖x‖) ^ k / (k.factorial : ℝ) := by
        intro k _
        rw [norm_div, norm_pow]
        have hnum : ‖Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ)‖ ≤ c * ‖x‖ := by
          rw [norm_mul, Complex.norm_I, one_mul, Complex.norm_real, Real.norm_eq_abs, abs_mul,
            hc]
          have h2pi : |(-2 * Real.pi : ℝ)| = 2 * Real.pi := by
            rw [abs_of_nonpos (by nlinarith [Real.pi_pos] : (-2 * Real.pi : ℝ) ≤ 0)]; ring
          rw [h2pi]
          calc 2 * Real.pi * |(inner ℝ x w : ℝ)| ≤ 2 * Real.pi * (‖x‖ * ‖w‖) :=
                mul_le_mul_of_nonneg_left hinner (by positivity)
            _ = 2 * Real.pi * ‖w‖ * ‖x‖ := by ring
        have hden : ‖(k.factorial : ℂ)‖ = (k.factorial : ℝ) := by simp
        rw [hden]
        gcongr
      calc ‖∑ k ∈ Finset.range N,
            (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ)) ^ k / (k.factorial : ℂ)‖
          ≤ ∑ k ∈ Finset.range N,
              ‖(Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ)) ^ k
                / (k.factorial : ℂ)‖ := norm_sum_le _ _
        _ ≤ ∑ k ∈ Finset.range N, (c * ‖x‖) ^ k / (k.factorial : ℝ) :=
            Finset.sum_le_sum hstep
        _ ≤ Real.exp (c * ‖x‖) := Real.sum_le_exp_of_nonneg (by positivity) N
    simp only [hF, norm_mul]
    have h2 : ‖((gaussD x : ℝ) : ℂ)‖ = gaussD x := by
      rw [Complex.norm_real, Real.norm_eq_abs, abs_of_pos (gaussD_pos x)]
    rw [norm_expGauss, h2]
    have hg : (0 : ℝ) ≤ gaussD x * ‖u x‖ := mul_nonneg (gaussD_pos x).le (norm_nonneg _)
    calc ‖∑ k ∈ Finset.range N,
          (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ)) ^ k / (k.factorial : ℂ)‖
            * (gaussD x * ‖u x‖)
        ≤ Real.exp (c * ‖x‖) * (gaussD x * ‖u x‖) := mul_le_mul_of_nonneg_right hsum hg
      _ = Real.exp (c * ‖x‖) * gaussD x * ‖u x‖ := by ring
  have hlim : ∀ᵐ x : Vd d, Filter.Tendsto (fun N => F N x) Filter.atTop
      (nhds (Complex.exp (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ))
        * (((gaussD x : ℝ) : ℂ) * u x))) := by
    filter_upwards with x
    have hsum := (NormedSpace.expSeries_div_hasSum_exp (𝔸 := ℂ)
      (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ)))
    have hsum' : HasSum (fun k : ℕ =>
        (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ)) ^ k / (k.factorial : ℂ))
        (Complex.exp (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ))) := by
      simpa [Complex.exp_eq_exp_ℂ] using hsum
    exact hsum'.tendsto_sum_nat.mul_const _
  have hconv := MeasureTheory.tendsto_integral_of_dominated_convergence
    (fun x : Vd d => ‖((Real.exp (c * ‖x‖) * gaussD x : ℝ) : ℂ) * u x‖)
    hmeas hbdd.norm hdom hlim
  have hval : ∫ x : Vd d, Complex.exp (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ))
      * (((gaussD x : ℝ) : ℂ) * u x) = 0 := by
    have hc0 : Filter.Tendsto (fun _ : ℕ => (0 : ℂ)) Filter.atTop
        (nhds (∫ x : Vd d, Complex.exp (Complex.I * ((-2 * Real.pi * (inner ℝ x w : ℝ) : ℝ) : ℂ))
          * (((gaussD x : ℝ) : ℂ) * u x))) := by
      simpa [hFint] using hconv
    exact tendsto_nhds_unique hc0 tendsto_const_nhds
  rw [Real.fourier_eq', ← hval]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [smul_eq_mul]
  congr 2
  push_cast
  ring

/-- **Vanishing of all Gaussian moments forces `u = 0`**, for `u` of Gaussian exponential
decay. -/
theorem ae_eq_zero_of_moments_of_gaussExpDecay {u : Vd d → ℂ} (hu : GaussExpDecay u)
    (hmom : ∀ p : MvPolynomial (Fin d) ℂ, ∫ x : Vd d, pgFun p x * u x = 0) :
    ∀ᵐ x : Vd d, u x = 0 := by
  have hv : Integrable (fun x : Vd d => ((gaussD x : ℝ) : ℂ) * u x) := by
    have h0 := hu 0
    simpa only [zero_mul, Real.exp_zero, one_mul] using h0
  have hzero := ae_eq_zero_of_fourier_eq_zero hv
    (fun w => fourier_gaussD_mul_eq_zero_of_gaussExpDecay hu hmom w)
  filter_upwards [hzero] with x hx
  have hne : ((gaussD x : ℝ) : ℂ) ≠ 0 := by
    exact_mod_cast ne_of_gt (gaussD_pos x)
  exact (mul_eq_zero.mp hx).resolve_left hne

/-! ## 3. Essential self-adjointness of the potential term -/

/-- An exponentially bounded (complex) multiplier times an `L²` function has Gaussian
exponential decay. -/
theorem gaussExpDecay_mul_lp {g : Vd d → ℂ} {C c : ℝ}
    (hg : AEStronglyMeasurable g (volume : Measure (Vd d)))
    (hbd : ∀ x, ‖g x‖ ≤ C * Real.exp (c * ‖x‖)) (w : L2d d) :
    GaussExpDecay (fun x : Vd d => g x * (w : Vd d → ℂ) x) := by
  refine gaussExpDecay_of_memLp_mul (C := C) (c := c) (hg.mul (Lp.memLp w).1) (Lp.memLp w)
    fun x => ?_
  rw [norm_mul]
  exact mul_le_mul_of_nonneg_right (hbd x) (norm_nonneg _)

/-- An `L²` function has Gaussian exponential decay. -/
theorem gaussExpDecay_lp (w : L2d d) : GaussExpDecay ((w : Vd d → ℂ)) :=
  gaussExpDecay_of_memLp_mul (C := 1) (c := 0) (Lp.memLp w).1 (Lp.memLp w) fun x => by simp

/-- Vanishing of the *monomial* Gaussian moments already forces all of them to vanish. -/
theorem moments_of_monomial_moments {u : Vd d → ℂ} (hu : GaussExpDecay u)
    (hmon : ∀ a : Fin d →₀ ℕ, ∫ x : Vd d, pgFun (monomial a (1 : ℂ)) x * u x = 0)
    (p : MvPolynomial (Fin d) ℂ) : ∫ x : Vd d, pgFun p x * u x = 0 := by
  have hsum : p = ∑ v ∈ p.support, (monomial v) (MvPolynomial.coeff v p) :=
    (MvPolynomial.support_sum_monomial_coeff p).symm
  have hpt : ∀ x : Vd d, pgFun p x * u x
      = ∑ v ∈ p.support, MvPolynomial.coeff v p * (pgFun (monomial v (1 : ℂ)) x * u x) := by
    intro x
    rw [pgFun]
    nth_rewrite 1 [hsum]
    rw [map_sum, Finset.sum_mul, Finset.sum_mul]
    refine Finset.sum_congr rfl fun v _ => ?_
    rw [pgFun, MvPolynomial.eval_monomial, MvPolynomial.eval_monomial]
    ring
  simp_rw [hpt]
  rw [integral_finset_sum _ (fun v _ =>
    (integrable_pgFun_mul_of_gaussExpDecay hu (monomial v (1 : ℂ))).const_mul _)]
  simp [integral_const_mul, hmon]

/-- `(W − z)w` has Gaussian exponential decay, for `W` continuous and exponentially bounded
and `w ∈ L²` — the growth statement replacing square integrability of `(W − z)w`, which fails
for an unbounded `W`. -/
theorem gaussExpDecay_potential_sub {W : Vd d → ℝ} (hWc : Continuous W) (hWb : ExpBounded W)
    (z : ℂ) (w : L2d d) :
    GaussExpDecay (fun x : Vd d => (((W x : ℝ) : ℂ) - z) * (w : Vd d → ℂ) x) := by
  obtain ⟨CW, cW, hcW, hWbd⟩ := hWb
  have hWm : AEStronglyMeasurable (fun x : Vd d => ((W x : ℝ) : ℂ))
      (volume : Measure (Vd d)) :=
    (Complex.continuous_ofReal.comp hWc).aestronglyMeasurable
  refine gaussExpDecay_of_memLp_mul (C := CW + ‖z‖) (c := cW)
    ((hWm.sub aestronglyMeasurable_const).mul (Lp.memLp w).1) (Lp.memLp w) fun x => ?_
  have h1 : ‖((W x : ℝ) : ℂ) - z‖ ≤ CW * Real.exp (cW * ‖x‖) + ‖z‖ := by
    refine (norm_sub_le _ _).trans ?_
    have hWx : ‖((W x : ℝ) : ℂ)‖ ≤ CW * Real.exp (cW * ‖x‖) := by
      rw [Complex.norm_real, Real.norm_eq_abs]; exact hWbd x
    linarith
  have h2 : CW * Real.exp (cW * ‖x‖) + ‖z‖ ≤ (CW + ‖z‖) * Real.exp (cW * ‖x‖) := by
    have hge : (1 : ℝ) ≤ Real.exp (cW * ‖x‖) := Real.one_le_exp (by positivity)
    nlinarith [norm_nonneg z]
  rw [norm_mul]
  exact mul_le_mul_of_nonneg_right (h1.trans h2) (norm_nonneg _)

/-- The moment identity satisfied by a deficiency vector of the multiplication operator. -/
theorem moments_of_deficiency {W : Vd d → ℝ} (hWc : Continuous W) (hWb : ExpBounded W)
    {z : ℂ} {w : L2d d}
    (hw : ∀ v : polyGaussCore (d := d),
      (inner ℂ (potCore W hWc hWb v) (w : L2d d) : ℂ) = z * inner ℂ (v : L2d d) (w : L2d d))
    (p : MvPolynomial (Fin d) ℂ) :
    ∫ x : Vd d, pgFun p x * ((((W x : ℝ) : ℂ) - z) * (w : Vd d → ℂ) x) = 0 := by
  obtain ⟨CW, cW, hcW, hWbd⟩ := id hWb
  have hWm : AEStronglyMeasurable (fun x : Vd d => ((W x : ℝ) : ℂ))
      (volume : Measure (Vd d)) :=
    (Complex.continuous_ofReal.comp hWc).aestronglyMeasurable
  have hA : GaussExpDecay (fun x : Vd d => ((W x : ℝ) : ℂ) * (w : Vd d → ℂ) x) :=
    gaussExpDecay_mul_lp hWm (fun x => by
      rw [Complex.norm_real, Real.norm_eq_abs]; exact hWbd x) w
  have hB : GaussExpDecay (fun x : Vd d => (-z) * (w : Vd d → ℂ) x) :=
    gaussExpDecay_mul_lp (C := ‖z‖) (c := 0) aestronglyMeasurable_const
      (fun x => by simp) w
  have hu := gaussExpDecay_potential_sub hWc hWb z w
  refine moments_of_monomial_moments hu (fun a => ?_) p
  -- the monomial case: read off the moment identity from the deficiency equation
  set q : MvPolynomial (Fin d) ℂ := monomial a (1 : ℂ) with hq
  have hdef := hw ⟨pgLp q, pgLp_mem_core q⟩
  rw [potCore_pgLp] at hdef
  have hlhs : (inner ℂ (potLp W hWc hWb q) (w : L2d d) : ℂ)
      = ∫ x : Vd d, pgFun q x * (((W x : ℝ) : ℂ) * (w : Vd d → ℂ) x) := by
    rw [inner_L2_eq]
    refine integral_congr_ae ?_
    filter_upwards [potLp_coeFn W hWc hWb q] with x hx
    rw [hx, map_mul, Complex.conj_ofReal, conj_pgFun_monomial_one]
    ring
  have hrhs : (inner ℂ ((⟨pgLp q, pgLp_mem_core q⟩ : polyGaussCore (d := d)) : L2d d)
      (w : L2d d) : ℂ) = ∫ x : Vd d, pgFun q x * (w : Vd d → ℂ) x := by
    rw [inner_pgLp]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only [hq, conj_pgFun_monomial_one]
  rw [hlhs, hrhs] at hdef
  have hsplit : ∀ x : Vd d, pgFun q x * ((((W x : ℝ) : ℂ) - z) * (w : Vd d → ℂ) x)
      = pgFun q x * (((W x : ℝ) : ℂ) * (w : Vd d → ℂ) x)
        + pgFun q x * ((-z) * (w : Vd d → ℂ) x) := by
    intro x; ring
  simp_rw [hsplit]
  rw [integral_add (integrable_pgFun_mul_of_gaussExpDecay hA q)
    (integrable_pgFun_mul_of_gaussExpDecay hB q)]
  have hlast : ∫ x : Vd d, pgFun q x * ((-z) * (w : Vd d → ℂ) x)
      = -z * ∫ x : Vd d, pgFun q x * (w : Vd d → ℂ) x := by
    rw [← integral_const_mul]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    ring
  rw [hlast, hdef]
  ring

/-- **The deficiency spaces are trivial at every non-real point.** -/
theorem potCore_deficiencyTrivialAt {W : Vd d → ℝ} (hWc : Continuous W) (hWb : ExpBounded W)
    {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (polyGaussCore (d := d)) (potCore W hWc hWb) z := by
  intro w hw
  have hu := gaussExpDecay_potential_sub hWc hWb z w
  have hzero := ae_eq_zero_of_moments_of_gaussExpDecay hu
    (moments_of_deficiency hWc hWb hw)
  refine Lp.eq_zero_iff_ae_eq_zero.mpr ?_
  filter_upwards [hzero] with x hx
  have hne : ((W x : ℝ) : ℂ) - z ≠ 0 := by
    intro h
    apply hz
    have : (((W x : ℝ) : ℂ) - z).im = 0 := by rw [h]; simp
    simpa using this
  exact (mul_eq_zero.mp hx).resolve_left hne

/-- **Multiplication by a continuous, exponentially bounded real potential is essentially
self-adjoint on the Gauss–polynomial (Hermite) core of `L²(ℝᵈ)`.**  No temperate growth and
no boundedness hypothesis: the potential may grow exponentially. -/
theorem potCore_essentiallySelfAdjoint {W : Vd d → ℝ} (hWc : Continuous W)
    (hWb : ExpBounded W) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (potCore W hWc hWb) :=
  ⟨potCore_deficiencyTrivialAt hWc hWb (by simp),
    potCore_deficiencyTrivialAt hWc hWb (by simp)⟩

/-! ## 4. The scalaron instances -/

/-- The scalaron potential as a potential on `ℝ¹`. -/
def scalaronPot (M alpha : ℝ) (x : Vd 1) : ℝ := starobinskyV M alpha (x 0)

theorem continuous_scalaronPot (M alpha : ℝ) : Continuous (scalaronPot M alpha) :=
  (continuous_starobinskyV M alpha).comp (by fun_prop)

theorem expBounded_scalaronPot (M alpha : ℝ) (hM : 0 < M) : ExpBounded (scalaronPot M alpha) :=
  (expBounded_starobinskyV M alpha hM).comp_coord 0

/-- **The exponentially growing scalaron potential is essentially self-adjoint on the
Gauss–polynomial core.** -/
theorem scalaronPot_essentiallySelfAdjoint (M alpha : ℝ) (hM : 0 < M) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 1))
      (potCore (scalaronPot M alpha) (continuous_scalaronPot M alpha)
        (expBounded_scalaronPot M alpha hM)) :=
  potCore_essentiallySelfAdjoint _ _

/-- **The unitary group of an exponentially bounded potential on the Hermite core**: the
self-adjoint realization is forced by essential self-adjointness, not chosen. -/
theorem potCore_stone_flow {W : Vd d → ℝ} (hWc : Continuous W) (hWb : ExpBounded W) :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (potCore W hWc hWb) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ polyGaussCore_dense
    (potCore_symmetricOn _ _ _) (potCore_essentiallySelfAdjoint hWc hWb)

/-- The unitary group generated by the scalaron potential itself. -/
theorem scalaronPot_stone_flow (M alpha : ℝ) (hM : 0 < M) :
    ∃ (T : UnboundedSelfAdjoint (L2d 1)) (U : ℝ → (L2d 1 →L[ℂ] L2d 1)),
      IsSelfAdjointExtension
        (potCore (scalaronPot M alpha) (continuous_scalaronPot M alpha)
          (expBounded_scalaronPot M alpha hM)) T.op ∧ IsStoneFlow T U :=
  potCore_stone_flow _ _

/-- **The reduced `(R_c, φ)` sector**: the full potential `V₃(R_c) + V(φ)` of the gauge-fixed
`R + αR²` Hamiltonian is essentially self-adjoint on the Gauss–polynomial core of `L²(ℝ²)`. -/
theorem scalaronSector_essentiallySelfAdjoint (M alpha : ℝ) (hM : 0 < M) (V3 : Polynomial ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 2))
      (potCore (scalaronSectorPotential M alpha V3)
        (continuous_scalaronSectorPotential M alpha V3)
        (expBounded_scalaronSectorPotential M alpha hM V3)) :=
  potCore_essentiallySelfAdjoint _ _

/-- The unitary group generated by the sector potential, obtained from essential
self-adjointness on the Hermite core. -/
theorem scalaronSector_stone_flow (M alpha : ℝ) (hM : 0 < M) (V3 : Polynomial ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2d 2)) (U : ℝ → (L2d 2 →L[ℂ] L2d 2)),
      IsSelfAdjointExtension
        (potCore (scalaronSectorPotential M alpha V3)
          (continuous_scalaronSectorPotential M alpha V3)
          (expBounded_scalaronSectorPotential M alpha hM V3)) T.op ∧ IsStoneFlow T U :=
  potCore_stone_flow _ _

end

end BookProof.ScalaronHermiteEsa
