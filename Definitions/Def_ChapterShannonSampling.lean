import Mathlib


/-!
# The Whittaker–Shannon sampling theorem

Source: `book.tex`, chapter *"Resolution of the singularity of the ODE x'=x² when the
initial x has uncertainties"*, §*Resolution of the singularity using the uncertainties in x*:

> "Since the Hamiltonian differs from the translation in space by a change of variables
> `y → 1/x`, then using the Whittaker–Shannon interpolation (also called sinc
> interpolation) […] we can completely define the wave-function in coordinate space through
> its values at discrete points."

The book uses the classical sampling theorem as an external fact.  This file **proves** it.

## The statement

Fix a bandwidth parameter `T > 0`.  A *band-limited signal* is the inverse Fourier transform

```
bandSignal F x = ∫ ξ in -T/2..T/2, exp (2πi x ξ) · F ξ
```

of a spectrum `F` supported in the band `[-T/2, T/2]`, which we encode as a function on the
circle `AddCircle T` (a spectrum on the band and its `T`-periodic extension carry the same
information, and this is exactly what makes the Fourier *series* of the spectrum available).

* `bandSignal_sample` — the samples at the lattice `n/T` are the Fourier coefficients of the
  spectrum: `bandSignal F (-(n/T)) = T · fourierCoeff F n`;
* **`bandSignal_hasSum_sinc`** — the Whittaker–Shannon interpolation formula
  `bandSignal F x = ∑ₙ bandSignal F (n/T) · sinc (T x - n)`, an unconditionally convergent
  sum over `n : ℤ`, for every real `x`;
* **`hasSum_sq_samples`** — Parseval for the samples: their squared norms are summable and
  their sum is the energy of the spectrum;
* **`bandSignal_eq_of_samples_eq`** — the consequence the book uses: two band-limited signals
  with the same samples on the lattice `{n/T}` are the *same function*, so a band-limited
  wave-function is completely determined by its values at those discrete points;
* `continuous_bandSignal_lp` — a band-limited signal is a continuous function, so sampling it
  at the lattice points really is evaluation;
* `sinc_intCast` / `sinc_zero` — the interpolation property of the cardinal sine: the `n`-th
  term of the series is the only one that survives at `x = n/T`.

## The proof

Everything is the pairing of the spectrum with the exponential kernel, expanded in the
Fourier basis of `L²` of the circle:

* `integral_exp_mul_ofReal` — the elementary integral `∫_{-T/2}^{T/2} e^{2πiaξ} dξ =
  T · sinc (aT)`, which is where the cardinal sine comes from;
* `kern x` is the `T`-periodic extension of `ξ ↦ e^{2πixξ}` from the band (`AddCircle.liftIoc`),
  a bounded measurable function, hence an element `kernLp x` of `L²`;
* `bandSignal_eq_inner` identifies the signal with the inner product `T · ⟪kernLp x, F⟫`, and
  `inner_kernLp_fourierBasis` computes the inner products of the kernel with the Fourier basis
  as the cardinal sines `sinc (T x + n)`;
* Parseval for the Fourier basis (`HilbertBasis.hasSum_inner_mul_inner`) then gives the
  interpolation formula, and injectivity of `fourierBasis.repr` gives the uniqueness clause.

Everything is `sorry`-free and uses only the standard axioms.
-/

namespace BookProof.ChapterShannonSampling

open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

/-! ## The cardinal sine -/

/-- The normalized cardinal sine `sinc u = sin (π u) / (π u)`, with value `1` at `u = 0`. -/
noncomputable def sinc (u : ℝ) : ℝ := if u = 0 then 1 else Real.sin (π * u) / (π * u)

@[simp] theorem sinc_zero : sinc 0 = 1 := by simp [sinc]

/-- The interpolation property: the cardinal sine vanishes at every nonzero integer. -/
@[simp] theorem sinc_intCast (n : ℤ) (hn : n ≠ 0) : sinc (n : ℝ) = 0 := by
  have hn' : (n : ℝ) ≠ 0 := Int.cast_ne_zero.mpr hn
  rw [sinc, if_neg hn']
  have : Real.sin (π * n) = 0 := by
    rw [mul_comm]
    simp
  simp [this]



/-! ## The elementary integral -/



section Band

variable {T : ℝ} [hT : Fact (0 < T)]



/-! ## The band-limited signal -/

/-- The band-limited signal with spectrum `F`: the inverse Fourier transform of `F` over the
band `[-T/2, T/2]`. -/
noncomputable def bandSignal (F : AddCircle T → ℂ) (x : ℝ) : ℂ :=
  ∫ ξ in (-(T / 2))..(T / 2), Complex.exp (2 * π * I * x * ξ) * F ξ

/-- The `T`-periodic extension of the exponential kernel `ξ ↦ e^{-2πixξ}` from the band. -/
noncomputable def kern (x : ℝ) : AddCircle T → ℂ :=
  AddCircle.liftIoc T (-(T / 2)) fun ξ => Complex.exp (-(2 * π * I * x * ξ))

theorem kern_coe_apply (x : ℝ) {ξ : ℝ} (hξ : ξ ∈ Ioc (-(T / 2)) (-(T / 2) + T)) :
    kern (T := T) x ξ = Complex.exp (-(2 * π * I * x * ξ)) :=
  AddCircle.liftIoc_coe_apply hξ

theorem norm_kern (x : ℝ) (z : AddCircle T) : ‖kern (T := T) x z‖ = 1 := by
  obtain ⟨ξ, hξ, rfl⟩ : ∃ ξ : ℝ, ξ ∈ Ioc (-(T / 2)) (-(T / 2) + T) ∧ (ξ : AddCircle T) = z :=
    ⟨(equivIoc T (-(T / 2)) z : ℝ), (equivIoc T (-(T / 2)) z).2, by
      conv_rhs => rw [← (equivIoc T (-(T / 2))).symm_apply_apply z]
      rfl⟩
  rw [kern_coe_apply x hξ, Complex.norm_exp]
  have : (-(2 * π * I * x * ξ)).re = 0 := by simp
  simp [this]

theorem measurable_kern (x : ℝ) : Measurable (kern (T := T) x) := by
  have h₁ : Measurable (equivIoc T (-(T / 2))) :=
    (AddCircle.measurePreserving_equivIoc T (a := -(T / 2))).measurable
  have h₂ : Measurable fun ξ : Ioc (-(T / 2)) (-(T / 2) + T) =>
      Complex.exp (-(2 * π * I * x * (ξ : ℝ))) := by
    fun_prop
  exact h₂.comp h₁

theorem memLp_kern (x : ℝ) : MemLp (kern (T := T) x) 2 (haarAddCircle (T := T)) :=
  MemLp.of_bound (measurable_kern x).aestronglyMeasurable 1
    (Filter.Eventually.of_forall fun z => by rw [norm_kern]; )

/-- The kernel as an element of `L²` of the circle. -/
noncomputable def kernLp (x : ℝ) : Lp ℂ 2 (haarAddCircle (T := T)) := (memLp_kern x).toLp _

















/-! ## Band-limited signals are continuous -/









r–Shannon interpolation (also called sinc
> interpolation) […] we can completely define the wave-function in coordinate space through
> its values at discrete points."

The book uses the classical sampling theorem as an external fact.  This file **proves** it.

## The statement

Fix a bandwidth parameter `T > 0`.  A *band-limited signal* is the inverse Fourier transform

```
bandSignal F x = ∫ ξ in -T/2..T/2, exp (2πi x ξ) · F ξ
```

of a spectrum `F` supported in the band `[-T/2, T/2]`, which we encode as a function on the
circle `AddCircle T` (a spectrum on the band and its `T`-periodic extension carry the same
information, and this is exactly what makes the Fourier *series* of the spectrum available).

* `bandSignal_sample` — the samples at the lattice `n/T` are the Fourier coefficients of the
  spectrum: `bandSignal F (-(n/T)) = T · fourierCoeff F n`;
* **`bandSignal_hasSum_sinc`** — the Whittaker–Shannon interpolation formula
  `bandSignal F x = ∑ₙ bandSignal F (n/T) · sinc (T x - n)`, an unconditionally convergent
  sum over `n : ℤ`, for every real `x`;
* **`hasSum_sq_samples`** — Parseval for the samples: their squared norms are summable and
  their sum is the energy of the spectrum;
* **`bandSignal_eq_of_samples_eq`** — the consequence the book uses: two band-limited signals
  with the same samples on the lattice `{n/T}` are the *same function*, so a band-limited
  wave-function is completely determined by its values at those discrete points;
* `continuous_bandSignal_lp` — a band-limited signal is a continuous function, so sampling it
  at the lattice points really is evaluation;
* `sinc_intCast` / `sinc_zero` — the interpolation property of the cardinal sine: the `n`-th
  term of the series is the only one that survives at `x = n/T`.

## The proof

Everything is the pairing of the spectrum with the exponential kernel, expanded in the
Fourier basis of `L²` of the circle:

* `integral_exp_mul_ofReal` — the elementary integral `∫_{-T/2}^{T/2} e^{2πiaξ} dξ =
  T · sinc (aT)`, which is where the cardinal sine comes from;
* `kern x` is the `T`-periodic extension of `ξ ↦ e^{2πixξ}` from the band (`AddCircle.liftIoc`),
  a bounded measurable function, hence an element `kernLp x` of `L²`;
* `bandSignal_eq_inner` identifies the signal with the inner product `T · ⟪kernLp x, F⟫`, and
  `inner_kernLp_fourierBasis` computes the inner products of the kernel with the Fourier basis
  as the cardinal sines `sinc (T x + n)`;
* Parseval for the Fourier basis (`HilbertBasis.hasSum_inner_mul_inner`) then gives the
  interpolation formula, and injectivity of `fourierBasis.repr` gives the uniqueness clause.

Everything is `sorry`-free and uses only the standard axioms.
-/

namespace BookProof.ChapterShannonSampling

open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

/-! ## The cardinal sine -/

/-- The normalized cardinal sine `sinc u = sin (π u) / (π u)`, with value `1` at `u = 0`. -/
noncomputable def sinc (u : ℝ) : ℝ := if u = 0 then 1 else Real.sin (π * u) / (π * u)

@[simp] theorem sinc_zero : sinc 0 = 1 := by simp [sinc]

/-- The interpolation property: the cardinal sine vanishes at every nonzero integer. -/
@[simp] theorem sinc_intCast (n : ℤ) (hn : n ≠ 0) : sinc (n : ℝ) = 0 := by
  have hn' : (n : ℝ) ≠ 0 := Int.cast_ne_zero.mpr hn
  rw [sinc, if_neg hn']
  have : Real.sin (π * n) = 0 := by
    rw [mul_comm]
    simp
  simp [this]

/-- The cardinal sine is even. -/
theorem sinc_neg (u : ℝ) : sinc (-u) = sinc u := by
  rcases eq_or_ne u 0 with rfl | hu
  · simp
  · rw [sinc, sinc, if_neg (by simpa using hu), if_neg hu, mul_neg, Real.sin_neg]
    field_simp

/-! ## The elementary integral -/

/-- `∫_{-T/2}^{T/2} e^{2πi a ξ} dξ = T · sinc (a T)`. -/
theorem integral_exp_mul_ofReal (T a : ℝ) (hT : 0 < T) :
    (∫ ξ in (-(T / 2))..(T / 2), Complex.exp (2 * π * I * a * ξ))
      = (T : ℂ) * (sinc (a * T) : ℝ) := by
  rcases eq_or_ne a 0 with rfl | ha
  · simp [sinc]
  · have hc : (2 * π * I * a : ℂ) ≠ 0 := by simp [Complex.ext_iff, Real.pi_ne_zero, ha]
    rw [integral_exp_mul_complex hc]
    have haT : a * T ≠ 0 := mul_ne_zero ha hT.ne'
    have hsinc : (sinc (a * T) : ℂ) = (Real.sin (π * (a * T)) : ℂ) / ((π : ℂ) * (a * T)) := by
      rw [sinc, if_neg haT]; push_cast; ring
    rw [hsinc]
    have h1 : (2 * (π : ℂ) * I * a * ((T / 2 : ℝ) : ℂ)) = ((π * (a * T) : ℝ) : ℂ) * I := by
      push_cast; ring
    have h2 : (2 * (π : ℂ) * I * a * ((-(T / 2) : ℝ) : ℂ)) = -(((π * (a * T) : ℝ) : ℂ) * I) := by
      push_cast; ring
    rw [h1, h2]
    set z : ℂ := ((π * (a * T) : ℝ) : ℂ) with hz
    have hsin : Complex.exp (z * I) - Complex.exp (-(z * I)) = 2 * I * Complex.sin z := by
      rw [Complex.sin]; ring_nf; rw [Complex.I_sq]; ring
    rw [hsin, ← Complex.ofReal_sin]
    have hpi : (π : ℂ) ≠ 0 := by exact_mod_cast Real.pi_ne_zero
    have ha' : (a : ℂ) ≠ 0 := by exact_mod_cast ha
    have hT' : (T : ℂ) ≠ 0 := by exact_mod_cast hT.ne'
    field_simp

section Band

variable {T : ℝ} [hT : Fact (0 < T)]

omit hT in
theorem half_add_period : -(T / 2) + T = T / 2 := by ring

/-! ## The band-limited signal -/

/-- The band-limited signal with spectrum `F`: the inverse Fourier transform of `F` over the
band `[-T/2, T/2]`. -/
noncomputable def bandSignal (F : AddCircle T → ℂ) (x : ℝ) : ℂ :=
  ∫ ξ in (-(T / 2))..(T / 2), Complex.exp (2 * π * I * x * ξ) * F ξ

/-- The `T`-periodic extension of the exponential kernel `ξ ↦ e^{-2πixξ}` from the band. -/
noncomputable def kern (x : ℝ) : AddCircle T → ℂ :=
  AddCircle.liftIoc T (-(T / 2)) fun ξ => Complex.exp (-(2 * π * I * x * ξ))

theorem kern_coe_apply (x : ℝ) {ξ : ℝ} (hξ : ξ ∈ Ioc (-(T / 2)) (-(T / 2) + T)) :
    kern (T := T) x ξ = Complex.exp (-(2 * π * I * x * ξ)) :=
  AddCircle.liftIoc_coe_apply hξ

theorem norm_kern (x : ℝ) (z : AddCircle T) : ‖kern (T := T) x z‖ = 1 := by
  obtain ⟨ξ, hξ, rfl⟩ : ∃ ξ : ℝ, ξ ∈ Ioc (-(T / 2)) (-(T / 2) + T) ∧ (ξ : AddCircle T) = z :=
    ⟨(equivIoc T (-(T / 2)) z : ℝ), (equivIoc T (-(T / 2)) z).2, by
      conv_rhs => rw [← (equivIoc T (-(T / 2))).symm_apply_apply z]
      rfl⟩
  rw [kern_coe_apply x hξ, Complex.norm_exp]
  have : (-(2 * π * I * x * ξ)).re = 0 := by simp
  simp [this]

theorem measurable_kern (x : ℝ) : Measurable (kern (T := T) x) := by
  have h₁ : Measurable (equivIoc T (-(T / 2))) :=
    (AddCircle.measurePreserving_equivIoc T (a := -(T / 2))).measurable
  have h₂ : Measurable fun ξ : Ioc (-(T / 2)) (-(T / 2) + T) =>
      Complex.exp (-(2 * π * I * x * (ξ : ℝ))) := by
    fun_prop
  exact h₂.comp h₁

theorem memLp_kern (x : ℝ) : MemLp (kern (T := T) x) 2 (haarAddCircle (T := T)) :=
  MemLp.of_bound (measurable_kern x).aestronglyMeasurable 1
    (Filter.Eventually.of_forall fun z => by rw [norm_kern]; )

/-- The kernel as an element of `L²` of the circle. -/
noncomputable def kernLp (x : ℝ) : Lp ℂ 2 (haarAddCircle (T := T)) := (memLp_kern x).toLp _

theorem exists_rep (z : AddCircle T) :
    ∃ ξ : ℝ, ξ ∈ Ioc (-(T / 2)) (-(T / 2) + T) ∧ (ξ : AddCircle T) = z :=
  ⟨(equivIoc T (-(T / 2)) z : ℝ), (equivIoc T (-(T / 2)) z).2, by
    conv_rhs => rw [← (equivIoc T (-(T / 2))).symm_apply_apply z]
    rfl⟩

theorem bandSignal_eq_circle_integral (F : AddCircle T → ℂ) (x : ℝ) :
    bandSignal (T := T) F x = ∫ z : AddCircle T, conj (kern (T := T) x z) * F z := by
  have key : (fun z : AddCircle T => conj (kern (T := T) x z) * F z)
      = AddCircle.liftIoc T (-(T / 2)) fun ξ => Complex.exp (2 * π * I * x * ξ) * F ξ := by
    funext z
    obtain ⟨ξ, hξ, rfl⟩ := exists_rep (T := T) z
    rw [kern_coe_apply x hξ, AddCircle.liftIoc_coe_apply hξ, ← Complex.exp_conj]
    congr 2
    simp [Complex.ext_iff]
  rw [key, AddCircle.integral_liftIoc_eq_intervalIntegral, bandSignal, half_add_period]

/-- The integral over the circle in terms of an interval integral of the lift. -/
theorem integral_haar_eq (g : AddCircle T → ℂ) :
    (T : ℂ) * ∫ z : AddCircle T, g z ∂haarAddCircle
      = ∫ ξ in (-(T / 2))..(-(T / 2) + T), g ξ := by
  rw [AddCircle.intervalIntegral_preimage, AddCircle.volume_eq_smul_haarAddCircle,
    MeasureTheory.integral_smul_measure, ENNReal.toReal_ofReal hT.out.le]
  simp [Complex.real_smul]

theorem inner_kernLp_apply (F : Lp ℂ 2 (haarAddCircle (T := T))) (x : ℝ) :
    inner ℂ (kernLp (T := T) x) F
      = ∫ z : AddCircle T, conj (kern (T := T) x z) * F z ∂haarAddCircle := by
  rw [MeasureTheory.L2.inner_def]
  refine integral_congr_ae ?_
  filter_upwards [(memLp_kern (T := T) x).coeFn_toLp] with z hz
  rw [RCLike.inner_apply, show ((kernLp (T := T) x : AddCircle T → ℂ) z) = kern (T := T) x z
    from hz]
  ring

theorem bandSignal_eq_inner (F : Lp ℂ 2 (haarAddCircle (T := T))) (x : ℝ) :
    bandSignal (T := T) (F : AddCircle T → ℂ) x
      = (T : ℂ) * inner ℂ (kernLp (T := T) x) F := by
  rw [inner_kernLp_apply, integral_haar_eq, bandSignal_eq_circle_integral,
    ← AddCircle.intervalIntegral_preimage T (-(T / 2))]

theorem inner_kernLp_fourierBasis (x : ℝ) (n : ℤ) :
    inner ℂ (kernLp (T := T) x) (fourierBasis (T := T) n) = (sinc (T * x + n) : ℝ) := by
  have hT0 : (0 : ℝ) < T := hT.out
  have hcoeff : fourierCoeff (kern (T := T) x) n = (sinc (T * x + n) : ℝ) := by
    rw [fourierCoeff_eq_intervalIntegral _ n (-(T / 2))]
    have hint : (∫ ξ in (-(T / 2))..(-(T / 2) + T),
          (fourier (-n) (ξ : AddCircle T)) • kern (T := T) x ξ)
        = ∫ ξ in (-(T / 2))..(-(T / 2) + T),
            Complex.exp (2 * π * I * (-(x + n / T)) * ξ) := by
      refine intervalIntegral.integral_congr_ae (Filter.Eventually.of_forall fun ξ hξ => ?_)
      have hξ' : ξ ∈ Ioc (-(T / 2)) (-(T / 2) + T) := by
        rwa [Set.uIoc_of_le (by linarith)] at hξ
      rw [kern_coe_apply x hξ', fourier_coe_apply, smul_eq_mul, ← Complex.exp_add]
      congr 1
      have hTc : (T : ℂ) ≠ 0 := by exact_mod_cast hT0.ne'
      field_simp
      push_cast
      ring
    rw [hint]
    have hexp := integral_exp_mul_ofReal T (-(x + n / T)) hT0
    push_cast at hexp
    rw [show -(T / 2) + T = T / 2 by ring, hexp]
    have hsinc : sinc (-(x + n / T) * T) = sinc (T * x + n) := by
      rw [show -(x + (n : ℝ) / T) * T = -((x + (n : ℝ) / T) * T) by ring, sinc_neg]
      congr 1
      field_simp
    rw [hsinc]
    have hTc : (T : ℂ) ≠ 0 := by exact_mod_cast hT0.ne'
    simp only [Complex.real_smul, Complex.ofReal_div, Complex.ofReal_one]
    field_simp
  have h1 : inner ℂ (fourierBasis (T := T) n) (kernLp (T := T) x)
      = ((sinc (T * x + n) : ℝ) : ℂ) := by
    rw [← fourierBasis.repr_apply_apply, fourierBasis_repr]
    simp only [kernLp]
    rw [fourierCoeff_congr_ae (memLp_kern (T := T) x).coeFn_toLp, hcoeff]
  calc inner ℂ (kernLp (T := T) x) (fourierBasis (T := T) n)
      = conj (inner ℂ (fourierBasis (T := T) n) (kernLp (T := T) x)) := by
        rw [inner_conj_symm]
    _ = ((sinc (T * x + n) : ℝ) : ℂ) := by rw [h1]; simp

/-- **The samples of a band-limited signal are the Fourier coefficients of its spectrum.** -/
theorem bandSignal_sample (F : AddCircle T → ℂ) (n : ℤ) :
    bandSignal (T := T) F (-(n / T)) = (T : ℂ) * fourierCoeff F n := by
  have hT0 : (0 : ℝ) < T := hT.out
  have hTc : (T : ℂ) ≠ 0 := by exact_mod_cast hT0.ne'
  have hpt : ∀ ξ : ℝ, Complex.exp (2 * π * I * ((-((n : ℝ) / T) : ℝ) : ℂ) * ξ) * F ξ
      = (fourier (-n) (ξ : AddCircle T)) • F ξ := by
    intro ξ
    rw [fourier_coe_apply, smul_eq_mul]
    congr 2
    push_cast
    field_simp
  rw [fourierCoeff_eq_intervalIntegral _ n (-(T / 2)), bandSignal,
    show -(T / 2) + T = T / 2 from by ring]
  rw [intervalIntegral.integral_congr (fun ξ _ => hpt ξ)]
  simp only [Complex.real_smul, Complex.ofReal_div, Complex.ofReal_one]
  field_simp

/-- **The Whittaker–Shannon interpolation formula.** -/
theorem bandSignal_hasSum_sinc (F : Lp ℂ 2 (haarAddCircle (T := T))) (x : ℝ) :
    HasSum (fun n : ℤ =>
        bandSignal (T := T) (F : AddCircle T → ℂ) (n / T) * (sinc (T * x - n) : ℝ))
      (bandSignal (T := T) (F : AddCircle T → ℂ) x) := by
  have hbase := (fourierBasis (T := T)).hasSum_inner_mul_inner (kernLp (T := T) x) F
  have h2 := hbase.mul_left (T : ℂ)
  rw [← bandSignal_eq_inner] at h2
  have hterm : ∀ n : ℤ, (T : ℂ) * (inner ℂ (kernLp (T := T) x) (fourierBasis (T := T) n)
        * inner ℂ (fourierBasis (T := T) n) F)
      = bandSignal (T := T) (F : AddCircle T → ℂ) (-((n : ℝ) / T)) * (sinc (T * x + n) : ℝ) := by
    intro n
    rw [inner_kernLp_fourierBasis, ← (fourierBasis (T := T)).repr_apply_apply,
      fourierBasis_repr, bandSignal_sample]
    ring
  simp_rw [hterm] at h2
  have h3 := (Equiv.neg ℤ).hasSum_iff.mpr h2
  refine h3.congr_fun fun n => ?_
  simp only [Function.comp_apply, Equiv.neg_apply]
  push_cast
  rw [show -(-(n : ℝ) / T) = (n : ℝ) / T from by ring,
    show T * x + -(n : ℝ) = T * x - n from by ring]

/-! ## Band-limited signals are continuous -/

/-- The spectrum of a band-limited signal is integrable over the band. -/
theorem integrableOn_spectrum (F : Lp ℂ 2 (haarAddCircle (T := T))) :
    IntegrableOn (fun ξ : ℝ => (F : AddCircle T → ℂ) ξ)
      (Ioc (-(T / 2)) (-(T / 2) + T)) volume := by
  have h1 : Integrable (F : AddCircle T → ℂ) haarAddCircle :=
    (Lp.memLp F).integrable (by norm_num)
  have h2 : Integrable (F : AddCircle T → ℂ) (volume : Measure (AddCircle T)) := by
    rw [AddCircle.volume_eq_smul_haarAddCircle]
    exact h1.smul_measure (by simp)
  exact ((AddCircle.measurePreserving_mk T (-(T / 2))).integrable_comp
    h2.aestronglyMeasurable).mpr h2

/-- **A band-limited signal is continuous**, so its values at the sampling points are
genuinely the values of a function, not of an almost-everywhere class. -/
theorem continuous_bandSignal (F : AddCircle T → ℂ)
    (hF : IntegrableOn (fun ξ : ℝ => F ξ) (Ioc (-(T / 2)) (-(T / 2) + T)) volume) :
    Continuous (bandSignal (T := T) F) := by
  have hle : -(T / 2) ≤ -(T / 2) + T := by linarith [hT.out]
  have hrepr : (bandSignal (T := T) F)
      = fun x : ℝ => ∫ ξ in (-(T / 2))..(-(T / 2) + T), Complex.exp (2 * π * I * x * ξ) * F ξ := by
    funext x
    rw [bandSignal, half_add_period]
  rw [hrepr]
  simp_rw [intervalIntegral.integral_of_le hle]
  refine continuous_of_dominated
    (F := fun (x : ℝ) (ξ : ℝ) => Complex.exp (2 * π * I * x * ξ) * F ξ)
    (bound := fun ξ => ‖F ξ‖) ?_ ?_ ?_ ?_
  · intro x
    exact (Complex.continuous_exp.comp (by fun_prop)).aestronglyMeasurable.mul
      hF.aestronglyMeasurable
  · intro x
    filter_upwards with ξ
    rw [norm_mul]
    have hphase : ‖Complex.exp (2 * (π : ℂ) * I * (x : ℂ) * (ξ : ℂ))‖ = 1 := by
      rw [show (2 * (π : ℂ) * I * x * ξ) = ((2 * π * x * ξ : ℝ) : ℂ) * I by push_cast; ring,
        Complex.norm_exp_ofReal_mul_I]
    rw [hphase, one_mul]
  · exact hF.norm
  · filter_upwards with ξ
    exact (Complex.continuous_exp.comp (by fun_prop)).mul continuous_const

/-- The continuity of a band-limited signal whose spectrum is square-integrable. -/
theorem continuous_bandSignal_lp (F : Lp ℂ 2 (haarAddCircle (T := T))) :
    Continuous (bandSignal (T := T) (F : AddCircle T → ℂ)) :=
  continuous_bandSignal _ (integrableOn_spectrum F)

/-- The real-valued companion of `integral_haar_eq`. -/
theorem integral_haar_eq_real (g : AddCircle T → ℝ) :
    T * ∫ z : AddCircle T, g z ∂haarAddCircle
      = ∫ ξ in (-(T / 2))..(-(T / 2) + T), g ξ := by
  rw [AddCircle.intervalIntegral_preimage, AddCircle.volume_eq_smul_haarAddCircle,
    MeasureTheory.integral_smul_measure, ENNReal.toReal_ofReal hT.out.le]
  simp [smul_eq_mul]

/-- **Parseval for the samples**: the samples of a band-limited signal carry exactly the energy
of its spectrum — their squared norms are summable with sum `T ∫_{-T/2}^{T/2} ‖F‖²`. -/
theorem hasSum_sq_samples (F : Lp ℂ 2 (haarAddCircle (T := T))) :
    HasSum (fun n : ℤ => ‖bandSignal (T := T) (F : AddCircle T → ℂ) (n / T)‖ ^ 2)
      (T * ∫ ξ in (-(T / 2))..(-(T / 2) + T), ‖(F : AddCircle T → ℂ) ξ‖ ^ 2) := by
  have hT0 : (0 : ℝ) < T := hT.out
  have hpar := (hasSum_sq_fourierCoeff F).mul_left (T ^ 2)
  have hterm : ∀ n : ℤ, T ^ 2 * ‖fourierCoeff (F : AddCircle T → ℂ) n‖ ^ 2
      = ‖bandSignal (T := T) (F : AddCircle T → ℂ) (-((n : ℝ) / T))‖ ^ 2 := by
    intro n
    rw [bandSignal_sample, norm_mul, mul_pow]
    simp [Complex.norm_real, Real.norm_eq_abs, abs_of_pos hT0]
  simp_rw [hterm] at hpar
  have hsum := (Equiv.neg ℤ).hasSum_iff.mpr hpar
  have hrhs : T ^ 2 * ∫ z : AddCircle T, ‖(F : AddCircle T → ℂ) z‖ ^ 2 ∂haarAddCircle
      = T * ∫ ξ in (-(T / 2))..(-(T / 2) + T), ‖(F : AddCircle T → ℂ) ξ‖ ^ 2 := by
    rw [← integral_haar_eq_real (fun z => ‖(F : AddCircle T → ℂ) z‖ ^ 2)]
    ring
  rw [hrhs] at hsum
  refine hsum.congr_fun fun n => ?_
  simp only [Function.comp_apply, Equiv.neg_apply]
  push_cast
  rw [show -(-(n : ℝ) / T) = (n : ℝ) / T from by ring]

/-- **A band-limited signal is determined by its samples.** -/
theorem bandSignal_eq_of_samples_eq (F G : Lp ℂ 2 (haarAddCircle (T := T)))
    (h : ∀ n : ℤ, bandSignal (T := T) (F : AddCircle T → ℂ) (n / T)
      = bandSignal (T := T) (G : AddCircle T → ℂ) (n / T)) (x : ℝ) :
    bandSignal (T := T) (F : AddCircle T → ℂ) x
      = bandSignal (T := T) (G : AddCircle T → ℂ) x := by
  refine HasSum.unique (bandSignal_hasSum_sinc F x) ?_
  refine (bandSignal_hasSum_sinc G x).congr_fun fun n => ?_
  rw [h n]

end Band

end BookProof.ChapterShannonSampling
