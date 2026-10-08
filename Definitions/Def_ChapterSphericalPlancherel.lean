import Definitions.Def_ChapterSphericalBessel
import Mathlib


/-!
# Unitarity of the spherical transform (Fourier–Bessel / Hankel Plancherel, `l = 0`)

`book.tex` §A.5 introduces the *spherical transform*

`(𝓢f)(p) = √(2/π) ∫₀^∞ f(r) jₗ(p r) r² dr`

and uses it as a **unitary** map of `L²((0,∞), r² dr)` onto itself in every
angular-momentum sector.  `BookProof.ChapterBesselHarmonic` and
`BookProof.ChapterNote68AllModes` proved that the transform intertwines `−∂⃗²`
with multiplication by `p²` (Note 68); its *unitarity* was the remaining
recorded boundary.  This module proves it in the `s`-wave sector `l = 0`.

## Strategy

With `j₀(x) = sin x / x` the kernel collapses to a sine kernel: writing
`G(r) = r f(r)`,

`p · (𝓢f)(p) = √(2/π) ∫₀^∞ G(r) sin(p r) dr`,

so the spherical Plancherel theorem is exactly Plancherel for the **Fourier sine
transform** on `(0,∞)`.  That in turn is the Fourier–Plancherel theorem of
Mathlib applied to the *odd extension*: for an odd function `G` the Fourier
transform is `𝓕G(w) = −2i ∫₀^∞ sin(2πwx) G(x) dx`, and both `‖G‖²` and `‖𝓕G‖²`
are even, so the factors of two match up.

## Contents

* `integral_eq_zero_of_odd`, `integral_eq_two_smul_of_even`,
  `integral_eq_two_mul_of_even_real` — the elementary symmetry lemmas;
* `fourier_odd_eq` — the Fourier transform of an odd integrable function is
  `−2i` times its sine transform;
* `sine_plancherel` — **Plancherel for the sine transform** (`2π` convention);
* `sineKernel_plancherel` — the same in the analysts' `sin(pr)` convention:
  `∫₀^∞ |∫₀^∞ G(r) sin(pr) dr|² dp = (π/2) ∫₀^∞ |G(r)|² dr`;
* `spherical_plancherel` — **unitarity of the spherical transform for `l = 0`**:
  `∫₀^∞ |(𝓢f)(p)|² p² dp = ∫₀^∞ |f(r)|² r² dr`, for every radial profile `f`
  whose moment `r ↦ r f(r)` is (the restriction of) an odd Schwartz function.

The class of admissible profiles is a dense subspace of `L²((0,∞), r² dr)`; the
extension of `𝓢` to the whole space by continuity, and the sectors `l ≥ 1`, are
not treated here.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ChapterSphericalPlancherel

open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

/-! ## Elementary symmetry lemmas for integrals on the line -/









/-! ## The sine transform and the Fourier transform of an odd function -/

/-- The Fourier **sine transform** in the `2π` convention used by Mathlib's
Fourier transform. -/
noncomputable def sineTransform (G : ℝ → ℂ) (w : ℝ) : ℂ :=
  ∫ x in Ioi (0 : ℝ), (Real.sin (2 * π * (x * w)) : ℂ) * G x







/-! ## Plancherel for the sine transform -/



/-- The sine transform in the analysts' convention, with kernel `sin(p r)`. -/
noncomputable def sineKernelTransform (G : ℝ → ℂ) (p : ℝ) : ℂ :=
  ∫ x in Ioi (0 : ℝ), (Real.sin (p * x) : ℂ) * G x





/-! ## Unitarity of the spherical transform in the `s`-wave sector -/

/-- The **spherical transform** of a radial profile in the sector `l = 0`:
`(𝓢f)(p) = √(2/π) ∫₀^∞ f(r) j₀(p r) r² dr`. -/
noncomputable def sphericalTransform (f : ℝ → ℂ) (p : ℝ) : ℂ :=
  (Real.sqrt (2 / π) : ℂ) * ∫ r in Ioi (0 : ℝ), f r * (sbessel 0 (p * r) : ℂ) * (r : ℂ) ^ 2





/-! ## Non-vacuity: an explicit odd Schwartz function

The hypothesis of `spherical_plancherel` is satisfied by a nonzero function: the
antisymmetrization of a smooth bump supported away from the origin.  So the
theorem really does say something about a nontrivial class of radial profiles.
-/

/-- A smooth bump centred at `2`, equal to `1` on `[1, 3]` and supported in
`(0, 4)`. -/
noncomputable def bumpAtTwo : ContDiffBump (2 : ℝ) := ⟨1, 2, one_pos, by norm_num⟩

/-- Its antisymmetrization: a nonzero odd smooth compactly supported function. -/
noncomputable def oddBump (x : ℝ) : ℂ := (bumpAtTwo x : ℂ) - (bumpAtTwo (-x) : ℂ)



² dr)` onto itself in every
angular-momentum sector.  `BookProof.ChapterBesselHarmonic` and
`BookProof.ChapterNote68AllModes` proved that the transform intertwines `−∂⃗²`
with multiplication by `p²` (Note 68); its *unitarity* was the remaining
recorded boundary.  This module proves it in the `s`-wave sector `l = 0`.

## Strategy

With `j₀(x) = sin x / x` the kernel collapses to a sine kernel: writing
`G(r) = r f(r)`,

`p · (𝓢f)(p) = √(2/π) ∫₀^∞ G(r) sin(p r) dr`,

so the spherical Plancherel theorem is exactly Plancherel for the **Fourier sine
transform** on `(0,∞)`.  That in turn is the Fourier–Plancherel theorem of
Mathlib applied to the *odd extension*: for an odd function `G` the Fourier
transform is `𝓕G(w) = −2i ∫₀^∞ sin(2πwx) G(x) dx`, and both `‖G‖²` and `‖𝓕G‖²`
are even, so the factors of two match up.

## Contents

* `integral_eq_zero_of_odd`, `integral_eq_two_smul_of_even`,
  `integral_eq_two_mul_of_even_real` — the elementary symmetry lemmas;
* `fourier_odd_eq` — the Fourier transform of an odd integrable function is
  `−2i` times its sine transform;
* `sine_plancherel` — **Plancherel for the sine transform** (`2π` convention);
* `sineKernel_plancherel` — the same in the analysts' `sin(pr)` convention:
  `∫₀^∞ |∫₀^∞ G(r) sin(pr) dr|² dp = (π/2) ∫₀^∞ |G(r)|² dr`;
* `spherical_plancherel` — **unitarity of the spherical transform for `l = 0`**:
  `∫₀^∞ |(𝓢f)(p)|² p² dp = ∫₀^∞ |f(r)|² r² dr`, for every radial profile `f`
  whose moment `r ↦ r f(r)` is (the restriction of) an odd Schwartz function.

The class of admissible profiles is a dense subspace of `L²((0,∞), r² dr)`; the
extension of `𝓢` to the whole space by continuity, and the sectors `l ≥ 1`, are
not treated here.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ChapterSphericalPlancherel

open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

/-! ## Elementary symmetry lemmas for integrals on the line -/

/-- The integral of an odd function over the whole line vanishes.  No
integrability hypothesis is needed: the Bochner integral of a non-integrable
function is `0`. -/
theorem integral_eq_zero_of_odd {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : ℝ → E) (h : ∀ x, f (-x) = -f x) : ∫ x : ℝ, f x = 0 := by
  have h1 : ∫ x : ℝ, f (-x) = ∫ x : ℝ, f x := integral_neg_eq_self f volume
  simp_rw [h, integral_neg] at h1
  have h2 : (2 : ℝ) • (∫ x : ℝ, f x) = 0 := by
    rw [two_smul]; nth_rewrite 1 [← h1]; abel
  simpa using h2

/-- The integral of an even integrable function is twice its integral over
`(0, ∞)`. -/
theorem integral_eq_two_smul_of_even {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : ℝ → E) (h : ∀ x, f (-x) = f x) (hf : Integrable f) :
    ∫ x : ℝ, f x = (2 : ℝ) • ∫ x in Ioi (0 : ℝ), f x := by
  have hsplit := intervalIntegral.integral_Iic_add_Ioi
    (hf.integrableOn (s := Iic 0)) (hf.integrableOn (s := Ioi 0))
  have key : ∫ x in Iic (0 : ℝ), f x = ∫ x in Ioi (0 : ℝ), f x := by
    rw [← neg_zero, ← integral_comp_neg_Ioi]
    simp_rw [h]; simp
  rw [← hsplit, key, two_smul]

/-- The real-valued version, which needs no integrability hypothesis. -/
theorem integral_eq_two_mul_of_even_real (h : ℝ → ℝ) (he : ∀ x, h (-x) = h x) :
    ∫ x : ℝ, h x = 2 * ∫ x in Ioi (0 : ℝ), h x := by
  rw [← integral_comp_abs (f := h)]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only
  rcases abs_cases x with ⟨h1, _⟩ | ⟨h1, _⟩
  · rw [h1]
  · rw [h1, he]

theorem integrable_bdd_mul (G : ℝ → ℂ) (hG : Integrable G) (u : ℝ → ℝ) (hu : Continuous u)
    (hb : ∀ x, |u x| ≤ 1) : Integrable (fun x : ℝ => (u x : ℂ) * G x) := by
  refine Integrable.bdd_mul (c := 1) hG
    ((Complex.continuous_ofReal.comp hu).aestronglyMeasurable) ?_
  filter_upwards with x
  rw [Complex.norm_real]
  exact hb x

/-! ## The sine transform and the Fourier transform of an odd function -/

/-- The Fourier **sine transform** in the `2π` convention used by Mathlib's
Fourier transform. -/
noncomputable def sineTransform (G : ℝ → ℂ) (w : ℝ) : ℂ :=
  ∫ x in Ioi (0 : ℝ), (Real.sin (2 * π * (x * w)) : ℂ) * G x

theorem sineTransform_odd (G : ℝ → ℂ) (w : ℝ) :
    sineTransform G (-w) = -sineTransform G w := by
  rw [sineTransform, sineTransform, ← integral_neg]
  refine setIntegral_congr_fun measurableSet_Ioi fun x _ => ?_
  rw [show 2 * π * (x * -w) = -(2 * π * (x * w)) by ring, Real.sin_neg]
  push_cast; ring

/-- Mathlib's Fourier transform written out with real cosine and sine. -/
theorem fourier_eq_cos_sub_sin (f : ℝ → ℂ) (w : ℝ) :
    𝓕 f w = ∫ x : ℝ, ((Real.cos (2 * π * (x * w)) : ℂ)
      - (Real.sin (2 * π * (x * w)) : ℂ) * Complex.I) * f x := by
  rw [Real.fourier_eq]
  refine integral_congr_ae (Filter.Eventually.of_forall fun v => ?_)
  simp only [RCLike.inner_apply, conj_trivial]
  rw [show ((𝐞 (-(w * v))) • f v) = (𝐞 (-(w * v)) : ℂ) * f v from rfl, Real.fourierChar_apply,
    show ((2 * π * -(w * v) : ℝ) : ℂ) * Complex.I
        = ((-(2 * π * (v * w)) : ℝ) : ℂ) * Complex.I by push_cast; ring,
    Complex.exp_mul_I]
  push_cast
  rw [Complex.cos_neg, Complex.sin_neg]
  ring

/-- **The Fourier transform of an odd function is `−2i` times its sine
transform.**  The cosine part integrates an odd function and vanishes; the sine
part integrates an even function and doubles. -/
theorem fourier_odd_eq (G : ℝ → ℂ) (hG : Integrable G) (hodd : ∀ x, G (-x) = -G x) (w : ℝ) :
    𝓕 G w = -(2 * Complex.I) * sineTransform G w := by
  have hA : Integrable (fun x : ℝ => (Real.cos (2 * π * (x * w)) : ℂ) * G x) :=
    integrable_bdd_mul G hG _ (by fun_prop) fun x => Real.abs_cos_le_one _
  have hB : Integrable (fun x : ℝ => (Real.sin (2 * π * (x * w)) : ℂ) * G x) :=
    integrable_bdd_mul G hG _ (by fun_prop) fun x => Real.abs_sin_le_one _
  rw [fourier_eq_cos_sub_sin]
  have hrw : (fun x : ℝ => ((Real.cos (2 * π * (x * w)) : ℂ)
      - (Real.sin (2 * π * (x * w)) : ℂ) * Complex.I) * G x)
      = fun x : ℝ => ((Real.cos (2 * π * (x * w)) : ℂ) * G x)
        + (-Complex.I) * ((Real.sin (2 * π * (x * w)) : ℂ) * G x) := by
    funext x; ring
  rw [hrw, integral_add hA (hB.const_mul _), integral_const_mul]
  have h0 : ∫ x : ℝ, (Real.cos (2 * π * (x * w)) : ℂ) * G x = 0 := by
    refine integral_eq_zero_of_odd _ fun x => ?_
    rw [hodd, show 2 * π * (-x * w) = -(2 * π * (x * w)) by ring, Real.cos_neg]
    ring
  have h2 : ∫ x : ℝ, (Real.sin (2 * π * (x * w)) : ℂ) * G x = (2 : ℝ) • sineTransform G w := by
    refine integral_eq_two_smul_of_even _ (fun x => ?_) hB
    rw [hodd, show 2 * π * (-x * w) = -(2 * π * (x * w)) by ring, Real.sin_neg]
    push_cast; ring
  rw [h0, h2, Complex.real_smul]
  push_cast
  ring

/-! ## Plancherel for the sine transform -/

/-- **Plancherel's theorem for the Fourier sine transform** (`2π` convention):
for an odd Schwartz function `G`,
`∫₀^∞ |∫₀^∞ sin(2πwx) G(x) dx|² dw = ¼ ∫₀^∞ |G(x)|² dx`. -/
theorem sine_plancherel (G : 𝓢(ℝ, ℂ)) (hodd : ∀ x, G (-x) = -G x) :
    ∫ w in Ioi (0 : ℝ), ‖sineTransform (⇑G) w‖ ^ 2
      = (1 / 4) * ∫ x in Ioi (0 : ℝ), ‖G x‖ ^ 2 := by
  have hP : ∫ w : ℝ, ‖𝓕 (⇑G) w‖ ^ 2 = ∫ x : ℝ, ‖G x‖ ^ 2 :=
    SchwartzMap.integral_norm_sq_fourier G
  have hFl : ∀ w : ℝ, ‖𝓕 (⇑G) w‖ ^ 2 = 4 * ‖sineTransform (⇑G) w‖ ^ 2 := by
    intro w
    rw [fourier_odd_eq _ G.integrable hodd, norm_mul]
    simp [mul_pow]
    norm_num
  have hL : ∫ w : ℝ, ‖𝓕 (⇑G) w‖ ^ 2
      = 2 * (4 * ∫ w in Ioi (0 : ℝ), ‖sineTransform (⇑G) w‖ ^ 2) := by
    rw [integral_eq_two_mul_of_even_real _
      fun w => by rw [hFl, hFl, sineTransform_odd, norm_neg]]
    simp_rw [hFl]
    rw [integral_const_mul]
  have hR : ∫ x : ℝ, ‖G x‖ ^ 2 = 2 * ∫ x in Ioi (0 : ℝ), ‖G x‖ ^ 2 :=
    integral_eq_two_mul_of_even_real _ fun x => by rw [hodd, norm_neg]
  rw [hL, hR] at hP
  linarith

/-- The sine transform in the analysts' convention, with kernel `sin(p r)`. -/
noncomputable def sineKernelTransform (G : ℝ → ℂ) (p : ℝ) : ℂ :=
  ∫ x in Ioi (0 : ℝ), (Real.sin (p * x) : ℂ) * G x

theorem sineKernelTransform_eq (G : ℝ → ℂ) (p : ℝ) :
    sineKernelTransform G p = sineTransform G ((2 * π)⁻¹ * p) := by
  rw [sineKernelTransform, sineTransform]
  refine setIntegral_congr_fun measurableSet_Ioi fun x _ => ?_
  congr 3
  field_simp

/-- **Plancherel for the sine transform**, analysts' convention:
`∫₀^∞ |∫₀^∞ G(r) sin(pr) dr|² dp = (π/2) ∫₀^∞ |G(r)|² dr`. -/
theorem sineKernel_plancherel (G : 𝓢(ℝ, ℂ)) (hodd : ∀ x, G (-x) = -G x) :
    ∫ p in Ioi (0 : ℝ), ‖sineKernelTransform (⇑G) p‖ ^ 2
      = (π / 2) * ∫ x in Ioi (0 : ℝ), ‖G x‖ ^ 2 := by
  have hpi : (0 : ℝ) < (2 * π)⁻¹ := by positivity
  have hsub : ∫ p in Ioi (0 : ℝ), ‖sineTransform (⇑G) ((2 * π)⁻¹ * p)‖ ^ 2
      = (2 * π) * ∫ w in Ioi (0 : ℝ), ‖sineTransform (⇑G) w‖ ^ 2 := by
    have hcv := integral_comp_mul_left_Ioi
      (fun w : ℝ => ‖sineTransform (⇑G) w‖ ^ 2) (0 : ℝ) hpi
    rw [hcv]
    simp only [mul_zero, smul_eq_mul, inv_inv]
  simp_rw [sineKernelTransform_eq]
  rw [hsub, sine_plancherel G hodd]
  ring

/-! ## Unitarity of the spherical transform in the `s`-wave sector -/

/-- The **spherical transform** of a radial profile in the sector `l = 0`:
`(𝓢f)(p) = √(2/π) ∫₀^∞ f(r) j₀(p r) r² dr`. -/
noncomputable def sphericalTransform (f : ℝ → ℂ) (p : ℝ) : ℂ :=
  (Real.sqrt (2 / π) : ℂ) * ∫ r in Ioi (0 : ℝ), f r * (sbessel 0 (p * r) : ℂ) * (r : ℂ) ^ 2

theorem sphericalTransform_eq {f : ℝ → ℂ} {G : ℝ → ℂ}
    (hf : ∀ r ∈ Ioi (0 : ℝ), (r : ℂ) * f r = G r) {p : ℝ} (hp : 0 < p) :
    sphericalTransform f p
      = (Real.sqrt (2 / π) : ℂ) * ((p : ℂ)⁻¹ * sineKernelTransform G p) := by
  have hint : (∫ r in Ioi (0 : ℝ), f r * (sbessel 0 (p * r) : ℂ) * (r : ℂ) ^ 2)
      = (p : ℂ)⁻¹ * sineKernelTransform G p := by
    rw [sineKernelTransform, ← MeasureTheory.integral_const_mul]
    refine setIntegral_congr_fun measurableSet_Ioi fun r hr => ?_
    have hrpos : (0 : ℝ) < r := mem_Ioi.mp hr
    have hrC : (r : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hrpos.ne'
    have hpC : (p : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hp.ne'
    have hb : (sbessel 0 (p * r) : ℂ) = (Real.sin (p * r) : ℂ) / ((p : ℂ) * (r : ℂ)) := by
      rw [sbessel_zero]
      simp only [sj0]
      push_cast
      ring
    rw [hb, ← hf r hr]
    field_simp
  rw [sphericalTransform, hint]

/-- **Unitarity of the spherical transform in the sector `l = 0`.**  For every
radial profile `f` on `(0, ∞)` whose moment `r ↦ r f(r)` is the restriction of an
odd Schwartz function,
`∫₀^∞ |(𝓢f)(p)|² p² dp = ∫₀^∞ |f(r)|² r² dr`,
i.e. the spherical transform preserves the norm of `L²((0,∞), r² dr)`. -/
theorem spherical_plancherel (G : 𝓢(ℝ, ℂ)) (hodd : ∀ x, G (-x) = -G x)
    (f : ℝ → ℂ) (hf : ∀ r ∈ Ioi (0 : ℝ), (r : ℂ) * f r = G r) :
    ∫ p in Ioi (0 : ℝ), ‖sphericalTransform f p‖ ^ 2 * p ^ 2
      = ∫ r in Ioi (0 : ℝ), ‖f r‖ ^ 2 * r ^ 2 := by
  have hpi : (0 : ℝ) < π := Real.pi_pos
  -- the right-hand side is the `L²(dr)` norm of `G`
  have hR : ∫ r in Ioi (0 : ℝ), ‖f r‖ ^ 2 * r ^ 2 = ∫ r in Ioi (0 : ℝ), ‖G r‖ ^ 2 := by
    refine setIntegral_congr_fun measurableSet_Ioi fun r hr => ?_
    have : ‖G r‖ = ‖(r : ℂ) * f r‖ := by rw [hf r hr]
    rw [this, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hr]
    ring
  -- the left-hand side is `(2/π)` times the sine-transform energy
  have hL : ∫ p in Ioi (0 : ℝ), ‖sphericalTransform f p‖ ^ 2 * p ^ 2
      = (2 / π) * ∫ p in Ioi (0 : ℝ), ‖sineKernelTransform (⇑G) p‖ ^ 2 := by
    rw [← MeasureTheory.integral_const_mul]
    refine setIntegral_congr_fun measurableSet_Ioi fun p hp => ?_
    have hp0 : (0 : ℝ) < p := hp
    have hval : ‖sphericalTransform f p‖
        = Real.sqrt (2 / π) * (p⁻¹ * ‖sineKernelTransform (⇑G) p‖) := by
      rw [sphericalTransform_eq hf hp0, norm_mul, norm_mul, Complex.norm_real,
        Real.norm_eq_abs, abs_of_nonneg (Real.sqrt_nonneg _), norm_inv,
        Complex.norm_real, Real.norm_eq_abs, abs_of_pos hp0]
    rw [hval, mul_pow, mul_pow, Real.sq_sqrt (by positivity : (0:ℝ) ≤ 2 / π), inv_pow]
    field_simp
  rw [hL, hR, sineKernel_plancherel G hodd]
  field_simp

/-! ## Non-vacuity: an explicit odd Schwartz function

The hypothesis of `spherical_plancherel` is satisfied by a nonzero function: the
antisymmetrization of a smooth bump supported away from the origin.  So the
theorem really does say something about a nontrivial class of radial profiles.
-/

/-- A smooth bump centred at `2`, equal to `1` on `[1, 3]` and supported in
`(0, 4)`. -/
noncomputable def bumpAtTwo : ContDiffBump (2 : ℝ) := ⟨1, 2, one_pos, by norm_num⟩

/-- Its antisymmetrization: a nonzero odd smooth compactly supported function. -/
noncomputable def oddBump (x : ℝ) : ℂ := (bumpAtTwo x : ℂ) - (bumpAtTwo (-x) : ℂ)

theorem oddBump_odd (x : ℝ) : oddBump (-x) = -oddBump x := by
  simp only [oddBump, neg_neg]
  ring

theorem oddBump_two : oddBump 2 = 1 := by
  have h1 : bumpAtTwo (2 : ℝ) = 1 := bumpAtTwo.one_of_mem_closedBall (by simp [bumpAtTwo])
  have h2 : bumpAtTwo (-2 : ℝ) = 0 := by
    apply ContDiffBump.zero_of_le_dist
    simp [bumpAtTwo, Real.dist_eq]
    norm_num
  simdr)` onto itself in every
angular-momentum sector.  `BookProof.ChapterBesselHarmonic` and
`BookProof.ChapterNote68AllModes` proved that the transform intertwines `−∂⃗²`
with multiplication by `p²` (Note 68); its *unitarity* was the remaining
recorded boundary.  This module proves it in the `s`-wave sector `l = 0`.

## Strategy

With `j₀(x) = sin x / x` the kernel collapses to a sine kernel: writing
`G(r) = r f(r)`,

`p · (𝓢f)(p) = √(2/π) ∫₀^∞ G(r) sin(p r) dr`,

so the spherical Plancherel theorem is exactly Plancherel for the **Fourier sine
transform** on `(0,∞)`.  That in turn is the Fourier–Plancherel theorem of
Mathlib applied to the *odd extension*: for an odd function `G` the Fourier
transform is `𝓕G(w) = −2i ∫₀^∞ sin(2πwx) G(x) dx`, and both `‖G‖²` and `‖𝓕G‖²`
are even, so the factors of two match up.

## Contents

* `integral_eq_zero_of_odd`, `integral_eq_two_smul_of_even`,
  `integral_eq_two_mul_of_even_real` — the elementary symmetry lemmas;
* `fourier_odd_eq` — the Fourier transform of an odd integrable function is
  `−2i` times its sine transform;
* `sine_plancherel` — **Plancherel for the sine transform** (`2π` convention);
* `sineKernel_plancherel` — the same in the analysts' `sin(pr)` convention:
  `∫₀^∞ |∫₀^∞ G(r) sin(pr) dr|² dp = (π/2) ∫₀^∞ |G(r)|² dr`;
* `spherical_plancherel` — **unitarity of the spherical transform for `l = 0`**:
  `∫₀^∞ |(𝓢f)(p)|² p² dp = ∫₀^∞ |f(r)|² r² dr`, for every radial profile `f`
  whose moment `r ↦ r f(r)` is (the restriction of) an odd Schwartz function.

The class of admissible profiles is a dense subspace of `L²((0,∞), r² dr)`; the
extension of `𝓢` to the whole space by continuity, and the sectors `l ≥ 1`, are
not treated here.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ChapterSphericalPlancherel

open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

/-! ## Elementary symmetry lemmas for integrals on the line -/

/-- The integral of an odd function over the whole line vanishes.  No
integrability hypothesis is needed: the Bochner integral of a non-integrable
function is `0`. -/
theorem integral_eq_zero_of_odd {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : ℝ → E) (h : ∀ x, f (-x) = -f x) : ∫ x : ℝ, f x = 0 := by
  have h1 : ∫ x : ℝ, f (-x) = ∫ x : ℝ, f x := integral_neg_eq_self f volume
  simp_rw [h, integral_neg] at h1
  have h2 : (2 : ℝ) • (∫ x : ℝ, f x) = 0 := by
    rw [two_smul]; nth_rewrite 1 [← h1]; abel
  simpa using h2

/-- The integral of an even integrable function is twice its integral over
`(0, ∞)`. -/
theorem integral_eq_two_smul_of_even {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : ℝ → E) (h : ∀ x, f (-x) = f x) (hf : Integrable f) :
    ∫ x : ℝ, f x = (2 : ℝ) • ∫ x in Ioi (0 : ℝ), f x := by
  have hsplit := intervalIntegral.integral_Iic_add_Ioi
    (hf.integrableOn (s := Iic 0)) (hf.integrableOn (s := Ioi 0))
  have key : ∫ x in Iic (0 : ℝ), f x = ∫ x in Ioi (0 : ℝ), f x := by
    rw [← neg_zero, ← integral_comp_neg_Ioi]
    simp_rw [h]; simp
  rw [← hsplit, key, two_smul]

/-- The real-valued version, which needs no integrability hypothesis. -/
theorem integral_eq_two_mul_of_even_real (h : ℝ → ℝ) (he : ∀ x, h (-x) = h x) :
    ∫ x : ℝ, h x = 2 * ∫ x in Ioi (0 : ℝ), h x := by
  rw [← integral_comp_abs (f := h)]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only
  rcases abs_cases x with ⟨h1, _⟩ | ⟨h1, _⟩
  · rw [h1]
  · rw [h1, he]

theorem integrable_bdd_mul (G : ℝ → ℂ) (hG : Integrable G) (u : ℝ → ℝ) (hu : Continuous u)
    (hb : ∀ x, |u x| ≤ 1) : Integrable (fun x : ℝ => (u x : ℂ) * G x) := by
  refine Integrable.bdd_mul (c := 1) hG
    ((Complex.continuous_ofReal.comp hu).aestronglyMeasurable) ?_
  filter_upwards with x
  rw [Complex.norm_real]
  exact hb x

/-! ## The sine transform and the Fourier transform of an odd function -/

/-- The Fourier **sine transform** in the `2π` convention used by Mathlib's
Fourier transform. -/
noncomputable def sineTransform (G : ℝ → ℂ) (w : ℝ) : ℂ :=
  ∫ x in Ioi (0 : ℝ), (Real.sin (2 * π * (x * w)) : ℂ) * G x

theorem sineTransform_odd (G : ℝ → ℂ) (w : ℝ) :
    sineTransform G (-w) = -sineTransform G w := by
  rw [sineTransform, sineTransform, ← integral_neg]
  refine setIntegral_congr_fun measurableSet_Ioi fun x _ => ?_
  rw [show 2 * π * (x * -w) = -(2 * π * (x * w)) by ring, Real.sin_neg]
  push_cast; ring

/-- Mathlib's Fourier transform written out with real cosine and sine. -/
theorem fourier_eq_cos_sub_sin (f : ℝ → ℂ) (w : ℝ) :
    𝓕 f w = ∫ x : ℝ, ((Real.cos (2 * π * (x * w)) : ℂ)
      - (Real.sin (2 * π * (x * w)) : ℂ) * Complex.I) * f x := by
  rw [Real.fourier_eq]
  refine integral_congr_ae (Filter.Eventually.of_forall fun v => ?_)
  simp only [RCLike.inner_apply, conj_trivial]
  rw [show ((𝐞 (-(w * v))) • f v) = (𝐞 (-(w * v)) : ℂ) * f v from rfl, Real.fourierChar_apply,
    show ((2 * π * -(w * v) : ℝ) : ℂ) * Complex.I
        = ((-(2 * π * (v * w)) : ℝ) : ℂ) * Complex.I by push_cast; ring,
    Complex.exp_mul_I]
  push_cast
  rw [Complex.cos_neg, Complex.sin_neg]
  ring

/-- **The Fourier transform of an odd function is `−2i` times its sine
transform.**  The cosine part integrates an odd function and vanishes; the sine
part integrates an even function and doubles. -/
theorem fourier_odd_eq (G : ℝ → ℂ) (hG : Integrable G) (hodd : ∀ x, G (-x) = -G x) (w : ℝ) :
    𝓕 G w = -(2 * Complex.I) * sineTransform G w := by
  have hA : Integrable (fun x : ℝ => (Real.cos (2 * π * (x * w)) : ℂ) * G x) :=
    integrable_bdd_mul G hG _ (by fun_prop) fun x => Real.abs_cos_le_one _
  have hB : Integrable (fun x : ℝ => (Real.sin (2 * π * (x * w)) : ℂ) * G x) :=
    integrable_bdd_mul G hG _ (by fun_prop) fun x => Real.abs_sin_le_one _
  rw [fourier_eq_cos_sub_sin]
  have hrw : (fun x : ℝ => ((Real.cos (2 * π * (x * w)) : ℂ)
      - (Real.sin (2 * π * (x * w)) : ℂ) * Complex.I) * G x)
      = fun x : ℝ => ((Real.cos (2 * π * (x * w)) : ℂ) * G x)
        + (-Complex.I) * ((Real.sin (2 * π * (x * w)) : ℂ) * G x) := by
    funext x; ring
  rw [hrw, integral_add hA (hB.const_mul _), integral_const_mul]
  have h0 : ∫ x : ℝ, (Real.cos (2 * π * (x * w)) : ℂ) * G x = 0 := by
    refine integral_eq_zero_of_odd _ fun x => ?_
    rw [hodd, show 2 * π * (-x * w) = -(2 * π * (x * w)) by ring, Real.cos_neg]
    ring
  have h2 : ∫ x : ℝ, (Real.sin (2 * π * (x * w)) : ℂ) * G x = (2 : ℝ) • sineTransform G w := by
    refine integral_eq_two_smul_of_even _ (fun x => ?_) hB
    rw [hodd, show 2 * π * (-x * w) = -(2 * π * (x * w)) by ring, Real.sin_neg]
    push_cast; ring
  rw [h0, h2, Complex.real_smul]
  push_cast
  ring

/-! ## Plancherel for the sine transform -/

/-- **Plancherel's theorem for the Fourier sine transform** (`2π` convention):
for an odd Schwartz function `G`,
`∫₀^∞ |∫₀^∞ sin(2πwx) G(x) dx|² dw = ¼ ∫₀^∞ |G(x)|² dx`. -/
theorem sine_plancherel (G : 𝓢(ℝ, ℂ)) (hodd : ∀ x, G (-x) = -G x) :
    ∫ w in Ioi (0 : ℝ), ‖sineTransform (⇑G) w‖ ^ 2
      = (1 / 4) * ∫ x in Ioi (0 : ℝ), ‖G x‖ ^ 2 := by
  have hP : ∫ w : ℝ, ‖𝓕 (⇑G) w‖ ^ 2 = ∫ x : ℝ, ‖G x‖ ^ 2 :=
    SchwartzMap.integral_norm_sq_fourier G
  have hFl : ∀ w : ℝ, ‖𝓕 (⇑G) w‖ ^ 2 = 4 * ‖sineTransform (⇑G) w‖ ^ 2 := by
    intro w
    rw [fourier_odd_eq _ G.integrable hodd, norm_mul]
    simp [mul_pow]
    norm_num
  have hL : ∫ w : ℝ, ‖𝓕 (⇑G) w‖ ^ 2
      = 2 * (4 * ∫ w in Ioi (0 : ℝ), ‖sineTransform (⇑G) w‖ ^ 2) := by
    rw [integral_eq_two_mul_of_even_real _
      fun w => by rw [hFl, hFl, sineTransform_odd, norm_neg]]
    simp_rw [hFl]
    rw [integral_const_mul]
  have hR : ∫ x : ℝ, ‖G x‖ ^ 2 = 2 * ∫ x in Ioi (0 : ℝ), ‖G x‖ ^ 2 :=
    integral_eq_two_mul_of_even_real _ fun x => by rw [hodd, norm_neg]
  rw [hL, hR] at hP
  linarith

/-- The sine transform in the analysts' convention, with kernel `sin(p r)`. -/
noncomputable def sineKernelTransform (G : ℝ → ℂ) (p : ℝ) : ℂ :=
  ∫ x in Ioi (0 : ℝ), (Real.sin (p * x) : ℂ) * G x

theorem sineKernelTransform_eq (G : ℝ → ℂ) (p : ℝ) :
    sineKernelTransform G p = sineTransform G ((2 * π)⁻¹ * p) := by
  rw [sineKernelTransform, sineTransform]
  refine setIntegral_congr_fun measurableSet_Ioi fun x _ => ?_
  congr 3
  field_simp

/-- **Plancherel for the sine transform**, analysts' convention:
`∫₀^∞ |∫₀^∞ G(r) sin(pr) dr|² dp = (π/2) ∫₀^∞ |G(r)|² dr`. -/
theorem sineKernel_plancherel (G : 𝓢(ℝ, ℂ)) (hodd : ∀ x, G (-x) = -G x) :
    ∫ p in Ioi (0 : ℝ), ‖sineKernelTransform (⇑G) p‖ ^ 2
      = (π / 2) * ∫ x in Ioi (0 : ℝ), ‖G x‖ ^ 2 := by
  have hpi : (0 : ℝ) < (2 * π)⁻¹ := by positivity
  have hsub : ∫ p in Ioi (0 : ℝ), ‖sineTransform (⇑G) ((2 * π)⁻¹ * p)‖ ^ 2
      = (2 * π) * ∫ w in Ioi (0 : ℝ), ‖sineTransform (⇑G) w‖ ^ 2 := by
    have hcv := integral_comp_mul_left_Ioi
      (fun w : ℝ => ‖sineTransform (⇑G) w‖ ^ 2) (0 : ℝ) hpi
    rw [hcv]
    simp only [mul_zero, smul_eq_mul, inv_inv]
  simp_rw [sineKernelTransform_eq]
  rw [hsub, sine_plancherel G hodd]
  ring

/-! ## Unitarity of the spherical transform in the `s`-wave sector -/

/-- The **spherical transform** of a radial profile in the sector `l = 0`:
`(𝓢f)(p) = √(2/π) ∫₀^∞ f(r) j₀(p r) r² dr`. -/
noncomputable def sphericalTransform (f : ℝ → ℂ) (p : ℝ) : ℂ :=
  (Real.sqrt (2 / π) : ℂ) * ∫ r in Ioi (0 : ℝ), f r * (sbessel 0 (p * r) : ℂ) * (r : ℂ) ^ 2

theorem sphericalTransform_eq {f : ℝ → ℂ} {G : ℝ → ℂ}
    (hf : ∀ r ∈ Ioi (0 : ℝ), (r : ℂ) * f r = G r) {p : ℝ} (hp : 0 < p) :
    sphericalTransform f p
      = (Real.sqrt (2 / π) : ℂ) * ((p : ℂ)⁻¹ * sineKernelTransform G p) := by
  have hint : (∫ r in Ioi (0 : ℝ), f r * (sbessel 0 (p * r) : ℂ) * (r : ℂ) ^ 2)
      = (p : ℂ)⁻¹ * sineKernelTransform G p := by
    rw [sineKernelTransform, ← MeasureTheory.integral_const_mul]
    refine setIntegral_congr_fun measurableSet_Ioi fun r hr => ?_
    have hrpos : (0 : ℝ) < r := mem_Ioi.mp hr
    have hrC : (r : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hrpos.ne'
    have hpC : (p : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hp.ne'
    have hb : (sbessel 0 (p * r) : ℂ) = (Real.sin (p * r) : ℂ) / ((p : ℂ) * (r : ℂ)) := by
      rw [sbessel_zero]
      simp only [sj0]
      push_cast
      ring
    rw [hb, ← hf r hr]
    field_simp
  rw [sphericalTransform, hint]

/-- **Unitarity of the spherical transform in the sector `l = 0`.**  For every
radial profile `f` on `(0, ∞)` whose moment `r ↦ r f(r)` is the restriction of an
odd Schwartz function,
`∫₀^∞ |(𝓢f)(p)|² p² dp = ∫₀^∞ |f(r)|² r² dr`,
i.e. the spherical transform preserves the norm of `L²((0,∞), r² dr)`. -/
theorem spherical_plancherel (G : 𝓢(ℝ, ℂ)) (hodd : ∀ x, G (-x) = -G x)
    (f : ℝ → ℂ) (hf : ∀ r ∈ Ioi (0 : ℝ), (r : ℂ) * f r = G r) :
    ∫ p in Ioi (0 : ℝ), ‖sphericalTransform f p‖ ^ 2 * p ^ 2
      = ∫ r in Ioi (0 : ℝ), ‖f r‖ ^ 2 * r ^ 2 := by
  have hpi : (0 : ℝ) < π := Real.pi_pos
  -- the right-hand side is the `L²(dr)` norm of `G`
  have hR : ∫ r in Ioi (0 : ℝ), ‖f r‖ ^ 2 * r ^ 2 = ∫ r in Ioi (0 : ℝ), ‖G r‖ ^ 2 := by
    refine setIntegral_congr_fun measurableSet_Ioi fun r hr => ?_
    have : ‖G r‖ = ‖(r : ℂ) * f r‖ := by rw [hf r hr]
    rw [this, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hr]
    ring
  -- the left-hand side is `(2/π)` times the sine-transform energy
  have hL : ∫ p in Ioi (0 : ℝ), ‖sphericalTransform f p‖ ^ 2 * p ^ 2
      = (2 / π) * ∫ p in Ioi (0 : ℝ), ‖sineKernelTransform (⇑G) p‖ ^ 2 := by
    rw [← MeasureTheory.integral_const_mul]
    refine setIntegral_congr_fun measurableSet_Ioi fun p hp => ?_
    have hp0 : (0 : ℝ) < p := hp
    have hval : ‖sphericalTransform f p‖
        = Real.sqrt (2 / π) * (p⁻¹ * ‖sineKernelTransform (⇑G) p‖) := by
      rw [sphericalTransform_eq hf hp0, norm_mul, norm_mul, Complex.norm_real,
        Real.norm_eq_abs, abs_of_nonneg (Real.sqrt_nonneg _), norm_inv,
        Complex.norm_real, Real.norm_eq_abs, abs_of_pos hp0]
    rw [hval, mul_pow, mul_pow, Real.sq_sqrt (by positivity : (0:ℝ) ≤ 2 / π), inv_pow]
    field_simp
  rw [hL, hR, sineKernel_plancherel G hodd]
  field_simp

/-! ## Non-vacuity: an explicit odd Schwartz function

The hypothesis of `spherical_plancherel` is satisfied by a nonzero function: the
antisymmetrization of a smooth bump supported away from the origin.  So the
theorem really does say something about a nontrivial class of radial profiles.
-/

/-- A smooth bump centred at `2`, equal to `1` on `[1, 3]` and supported in
`(0, 4)`. -/
noncomputable def bumpAtTwo : ContDiffBump (2 : ℝ) := ⟨1, 2, one_pos, by norm_num⟩

/-- Its antisymmetrization: a nonzero odd smooth compactly supported function. -/
noncomputable def oddBump (x : ℝ) : ℂ := (bumpAtTwo x : ℂ) - (bumpAtTwo (-x) : ℂ)

theorem oddBump_odd (x : ℝ) : oddBump (-x) = -oddBump x := by
  simp only [oddBump, neg_neg]
  ring

theorem oddBump_two : oddBump 2 = 1 := by
  have h1 : bumpAtTwo (2 : ℝ) = 1 := bumpAtTwo.one_of_mem_closedBall (by simp [bumpAtTwo])
  have h2 : bumpAtTwo (-2 : ℝ) = 0 := by
    apply ContDiffBump.zero_of_le_dist
    simp [bumpAtTwo, Real.dist_eq]
    norm_num
  simp [oddBump, h1, h2]

theorem contDiff_oddBump : ContDiff ℝ ∞ oddBump := by
  have h1 : ContDiff ℝ ∞ (fun x : ℝ => (bumpAtTwo x : ℂ)) :=
    Complex.ofRealCLM.contDiff.comp bumpAtTwo.contDiff
  have h2 : ContDiff ℝ ∞ (fun x : ℝ => (bumpAtTwo (-x) : ℂ)) := h1.comp contDiff_neg
  exact h1.sub h2nto itself in every
angular-momentum sector.  `BookProof.ChapterBesselHarmonic` and
`BookProof.ChapterNote68AllModes` proved that the transform intertwines `−∂⃗²`
with multiplication by `p²` (Note 68); its *unitarity* was the remaining
recorded boundary.  This module proves it in the `s`-wave sector `l = 0`.

## Strategy

With `j₀(x) = sin x / x` the kernel collapses to a sine kernel: writing
`G(r) = r f(r)`,

`p · (𝓢f)(p) = √(2/π) ∫₀^∞ G(r) sin(p r) dr`,

so the spherical Plancherel theorem is exactly Plancherel for the **Fourier sine
transform** on `(0,∞)`.  That in turn is the Fourier–Plancherel theorem of
Mathlib applied to the *odd extension*: for an odd function `G` the Fourier
transform is `𝓕G(w) = −2i ∫₀^∞ sin(2πwx) G(x) dx`, and both `‖G‖²` and `‖𝓕G‖²`
are even, so the factors of two match up.

## Contents

* `integral_eq_zero_of_odd`, `integral_eq_two_smul_of_even`,
  `integral_eq_two_mul_of_even_real` — the elementary symmetry lemmas;
* `fourier_odd_eq` — the Fourier transform of an odd integrable function is
  `−2i` times its sine transform;
* `sine_plancherel` — **Plancherel for the sine transform** (`2π` convention);
* `sineKernel_plancherel` — the same in the analysts' `sin(pr)` convention:
  `∫₀^∞ |∫₀^∞ G(r) sin(pr) dr|² dp = (π/2) ∫₀^∞ |G(r)|² dr`;
* `spherical_plancherel` — **unitarity of the spherical transform for `l = 0`**:
  `∫₀^∞ |(𝓢f)(p)|² p² dp = ∫₀^∞ |f(r)|² r² dr`, for every radial profile `f`
  whose moment `r ↦ r f(r)` is (the restriction of) an odd Schwartz function.

The class of admissible profiles is a dense subspace of `L²((0,∞), r² dr)`; the
extension of `𝓢` to the whole space by continuity, and the sectors `l ≥ 1`, are
not treated here.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ChapterSphericalPlancherel

open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

/-! ## Elementary symmetry lemmas for integrals on the line -/

/-- The integral of an odd function over the whole line vanishes.  No
integrability hypothesis is needed: the Bochner integral of a non-integrable
function is `0`. -/
theorem integral_eq_zero_of_odd {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : ℝ → E) (h : ∀ x, f (-x) = -f x) : ∫ x : ℝ, f x = 0 := by
  have h1 : ∫ x : ℝ, f (-x) = ∫ x : ℝ, f x := integral_neg_eq_self f volume
  simp_rw [h, integral_neg] at h1
  have h2 : (2 : ℝ) • (∫ x : ℝ, f x) = 0 := by
    rw [two_smul]; nth_rewrite 1 [← h1]; abel
  simpa using h2

/-- The integral of an even integrable function is twice its integral over
`(0, ∞)`. -/
theorem integral_eq_two_smul_of_even {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : ℝ → E) (h : ∀ x, f (-x) = f x) (hf : Integrable f) :
    ∫ x : ℝ, f x = (2 : ℝ) • ∫ x in Ioi (0 : ℝ), f x := by
  have hsplit := intervalIntegral.integral_Iic_add_Ioi
    (hf.integrableOn (s := Iic 0)) (hf.integrableOn (s := Ioi 0))
  have key : ∫ x in Iic (0 : ℝ), f x = ∫ x in Ioi (0 : ℝ), f x := by
    rw [← neg_zero, ← integral_comp_neg_Ioi]
    simp_rw [h]; simp
  rw [← hsplit, key, two_smul]

/-- The real-valued version, which needs no integrability hypothesis. -/
theorem integral_eq_two_mul_of_even_real (h : ℝ → ℝ) (he : ∀ x, h (-x) = h x) :
    ∫ x : ℝ, h x = 2 * ∫ x in Ioi (0 : ℝ), h x := by
  rw [← integral_comp_abs (f := h)]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only
  rcases abs_cases x with ⟨h1, _⟩ | ⟨h1, _⟩
  · rw [h1]
  · rw [h1, he]

theorem integrable_bdd_mul (G : ℝ → ℂ) (hG : Integrable G) (u : ℝ → ℝ) (hu : Continuous u)
    (hb : ∀ x, |u x| ≤ 1) : Integrable (fun x : ℝ => (u x : ℂ) * G x) := by
  refine Integrable.bdd_mul (c := 1) hG
    ((Complex.continuous_ofReal.comp hu).aestronglyMeasurable) ?_
  filter_upwards with x
  rw [Complex.norm_real]
  exact hb x

/-! ## The sine transform and the Fourier transform of an odd function -/

/-- The Fourier **sine transform** in the `2π` convention used by Mathlib's
Fourier transform. -/
noncomputable def sineTransform (G : ℝ → ℂ) (w : ℝ) : ℂ :=
  ∫ x in Ioi (0 : ℝ), (Real.sin (2 * π * (x * w)) : ℂ) * G x

theorem sineTransform_odd (G : ℝ → ℂ) (w : ℝ) :
    sineTransform G (-w) = -sineTransform G w := by
  rw [sineTransform, sineTransform, ← integral_neg]
  refine setIntegral_congr_fun measurableSet_Ioi fun x _ => ?_
  rw [show 2 * π * (x * -w) = -(2 * π * (x * w)) by ring, Real.sin_neg]
  push_cast; ring

/-- Mathlib's Fourier transform written out with real cosine and sine. -/
theorem fourier_eq_cos_sub_sin (f : ℝ → ℂ) (w : ℝ) :
    𝓕 f w = ∫ x : ℝ, ((Real.cos (2 * π * (x * w)) : ℂ)
      - (Real.sin (2 * π * (x * w)) : ℂ) * Complex.I) * f x := by
  rw [Real.fourier_eq]
  refine integral_congr_ae (Filter.Eventually.of_forall fun v => ?_)
  simp only [RCLike.inner_apply, conj_trivial]
  rw [show ((𝐞 (-(w * v))) • f v) = (𝐞 (-(w * v)) : ℂ) * f v from rfl, Real.fourierChar_apply,
    show ((2 * π * -(w * v) : ℝ) : ℂ) * Complex.I
        = ((-(2 * π * (v * w)) : ℝ) : ℂ) * Complex.I by push_cast; ring,
    Complex.exp_mul_I]
  push_cast
  rw [Complex.cos_neg, Complex.sin_neg]
  ring

/-- **The Fourier transform of an odd function is `−2i` times its sine
transform.**  The cosine part integrates an odd function and vanishes; the sine
part integrates an even function and doubles. -/
theorem fourier_odd_eq (G : ℝ → ℂ) (hG : Integrable G) (hodd : ∀ x, G (-x) = -G x) (w : ℝ) :
    𝓕 G w = -(2 * Complex.I) * sineTransform G w := by
  have hA : Integrable (fun x : ℝ => (Real.cos (2 * π * (x * w)) : ℂ) * G x) :=
    integrable_bdd_mul G hG _ (by fun_prop) fun x => Real.abs_cos_le_one _
  have hB : Integrable (fun x : ℝ => (Real.sin (2 * π * (x * w)) : ℂ) * G x) :=
    integrable_bdd_mul G hG _ (by fun_prop) fun x => Real.abs_sin_le_one _
  rw [fourier_eq_cos_sub_sin]
  have hrw : (fun x : ℝ => ((Real.cos (2 * π * (x * w)) : ℂ)
      - (Real.sin (2 * π * (x * w)) : ℂ) * Complex.I) * G x)
      = fun x : ℝ => ((Real.cos (2 * π * (x * w)) : ℂ) * G x)
        + (-Complex.I) * ((Real.sin (2 * π * (x * w)) : ℂ) * G x) := by
    funext x; ring
  rw [hrw, integral_add hA (hB.const_mul _), integral_const_mul]
  have h0 : ∫ x : ℝ, (Real.cos (2 * π * (x * w)) : ℂ) * G x = 0 := by
    refine integral_eq_zero_of_odd _ fun x => ?_
    rw [hodd, show 2 * π * (-x * w) = -(2 * π * (x * w)) by ring, Real.cos_neg]
    ring
  have h2 : ∫ x : ℝ, (Real.sin (2 * π * (x * w)) : ℂ) * G x = (2 : ℝ) • sineTransform G w := by
    refine integral_eq_two_smul_of_even _ (fun x => ?_) hB
    rw [hodd, show 2 * π * (-x * w) = -(2 * π * (x * w)) by ring, Real.sin_neg]
    push_cast; ring
  rw [h0, h2, Complex.real_smul]
  push_cast
  ring

/-! ## Plancherel for the sine transform -/

/-- **Plancherel's theorem for the Fourier sine transform** (`2π` convention):
for an odd Schwartz function `G`,
`∫₀^∞ |∫₀^∞ sin(2πwx) G(x) dx|² dw = ¼ ∫₀^∞ |G(x)|² dx`. -/
theorem sine_plancherel (G : 𝓢(ℝ, ℂ)) (hodd : ∀ x, G (-x) = -G x) :
    ∫ w in Ioi (0 : ℝ), ‖sineTransform (⇑G) w‖ ^ 2
      = (1 / 4) * ∫ x in Ioi (0 : ℝ), ‖G x‖ ^ 2 := by
  have hP : ∫ w : ℝ, ‖𝓕 (⇑G) w‖ ^ 2 = ∫ x : ℝ, ‖G x‖ ^ 2 :=
    SchwartzMap.integral_norm_sq_fourier G
  have hFl : ∀ w : ℝ, ‖𝓕 (⇑G) w‖ ^ 2 = 4 * ‖sineTransform (⇑G) w‖ ^ 2 := by
    intro w
    rw [fourier_odd_eq _ G.integrable hodd, norm_mul]
    simp [mul_pow]
    norm_num
  have hL : ∫ w : ℝ, ‖𝓕 (⇑G) w‖ ^ 2
      = 2 * (4 * ∫ w in Ioi (0 : ℝ), ‖sineTransform (⇑G) w‖ ^ 2) := by
    rw [integral_eq_two_mul_of_even_real _
      fun w => by rw [hFl, hFl, sineTransform_odd, norm_neg]]
    simp_rw [hFl]
    rw [integral_const_mul]
  have hR : ∫ x : ℝ, ‖G x‖ ^ 2 = 2 * ∫ x in Ioi (0 : ℝ), ‖G x‖ ^ 2 :=
    integral_eq_two_mul_of_even_real _ fun x => by rw [hodd, norm_neg]
  rw [hL, hR] at hP
  linarith

/-- The sine transform in the analysts' convention, with kernel `sin(p r)`. -/
noncomputable def sineKernelTransform (G : ℝ → ℂ) (p : ℝ) : ℂ :=
  ∫ x in Ioi (0 : ℝ), (Real.sin (p * x) : ℂ) * G x

theorem sineKernelTransform_eq (G : ℝ → ℂ) (p : ℝ) :
    sineKernelTransform G p = sineTransform G ((2 * π)⁻¹ * p) := by
  rw [sineKernelTransform, sineTransform]
  refine setIntegral_congr_fun measurableSet_Ioi fun x _ => ?_
  congr 3
  field_simp

/-- **Plancherel for the sine transform**, analysts' convention:
`∫₀^∞ |∫₀^∞ G(r) sin(pr) dr|² dp = (π/2) ∫₀^∞ |G(r)|² dr`. -/
theorem sineKernel_plancherel (G : 𝓢(ℝ, ℂ)) (hodd : ∀ x, G (-x) = -G x) :
    ∫ p in Ioi (0 : ℝ), ‖sineKernelTransform (⇑G) p‖ ^ 2
      = (π / 2) * ∫ x in Ioi (0 : ℝ), ‖G x‖ ^ 2 := by
  have hpi : (0 : ℝ) < (2 * π)⁻¹ := by positivity
  have hsub : ∫ p in Ioi (0 : ℝ), ‖sineTransform (⇑G) ((2 * π)⁻¹ * p)‖ ^ 2
      = (2 * π) * ∫ w in Ioi (0 : ℝ), ‖sineTransform (⇑G) w‖ ^ 2 := by
    have hcv := integral_comp_mul_left_Ioi
      (fun w : ℝ => ‖sineTransform (⇑G) w‖ ^ 2) (0 : ℝ) hpi
    rw [hcv]
    simp only [mul_zero, smul_eq_mul, inv_inv]
  simp_rw [sineKernelTransform_eq]
  rw [hsub, sine_plancherel G hodd]
  ring

/-! ## Unitarity of the spherical transform in the `s`-wave sector -/

/-- The **spherical transform** of a radial profile in the sector `l = 0`:
`(𝓢f)(p) = √(2/π) ∫₀^∞ f(r) j₀(p r) r² dr`. -/
noncomputable def sphericalTransform (f : ℝ → ℂ) (p : ℝ) : ℂ :=
  (Real.sqrt (2 / π) : ℂ) * ∫ r in Ioi (0 : ℝ), f r * (sbessel 0 (p * r) : ℂ) * (r : ℂ) ^ 2

theorem sphericalTransform_eq {f : ℝ → ℂ} {G : ℝ → ℂ}
    (hf : ∀ r ∈ Ioi (0 : ℝ), (r : ℂ) * f r = G r) {p : ℝ} (hp : 0 < p) :
    sphericalTransform f p
      = (Real.sqrt (2 / π) : ℂ) * ((p : ℂ)⁻¹ * sineKernelTransform G p) := by
  have hint : (∫ r in Ioi (0 : ℝ), f r * (sbessel 0 (p * r) : ℂ) * (r : ℂ) ^ 2)
      = (p : ℂ)⁻¹ * sineKernelTransform G p := by
    rw [sineKernelTransform, ← MeasureTheory.integral_const_mul]
    refine setIntegral_congr_fun measurableSet_Ioi fun r hr => ?_
    have hrpos : (0 : ℝ) < r := mem_Ioi.mp hr
    have hrC : (r : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hrpos.ne'
    have hpC : (p : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hp.ne'
    have hb : (sbessel 0 (p * r) : ℂ) = (Real.sin (p * r) : ℂ) / ((p : ℂ) * (r : ℂ)) := by
      rw [sbessel_zero]
      simp only [sj0]
      push_cast
      ring
    rw [hb, ← hf r hr]
    field_simp
  rw [sphericalTransform, hint]

/-- **Unitarity of the spherical transform in the sector `l = 0`.**  For every
radial profile `f` on `(0, ∞)` whose moment `r ↦ r f(r)` is the restriction of an
odd Schwartz function,
`∫₀^∞ |(𝓢f)(p)|² p² dp = ∫₀^∞ |f(r)|² r² dr`,
i.e. the spherical transform preserves the norm of `L²((0,∞), r² dr)`. -/
theorem spherical_plancherel (G : 𝓢(ℝ, ℂ)) (hodd : ∀ x, G (-x) = -G x)
    (f : ℝ → ℂ) (hf : ∀ r ∈ Ioi (0 : ℝ), (r : ℂ) * f r = G r) :
    ∫ p in Ioi (0 : ℝ), ‖sphericalTransform f p‖ ^ 2 * p ^ 2
      = ∫ r in Ioi (0 : ℝ), ‖f r‖ ^ 2 * r ^ 2 := by
  have hpi : (0 : ℝ) < π := Real.pi_pos
  -- the right-hand side is the `L²(dr)` norm of `G`
  have hR : ∫ r in Ioi (0 : ℝ), ‖f r‖ ^ 2 * r ^ 2 = ∫ r in Ioi (0 : ℝ), ‖G r‖ ^ 2 := by
    refine setIntegral_congr_fun measurableSet_Ioi fun r hr => ?_
    have : ‖G r‖ = ‖(r : ℂ) * f r‖ := by rw [hf r hr]
    rw [this, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hr]
    ring
  -- the left-hand side is `(2/π)` times the sine-transform energy
  have hL : ∫ p in Ioi (0 : ℝ), ‖sphericalTransform f p‖ ^ 2 * p ^ 2
      = (2 / π) * ∫ p in Ioi (0 : ℝ), ‖sineKernelTransform (⇑G) p‖ ^ 2 := by
    rw [← MeasureTheory.integral_const_mul]
    refine setIntegral_congr_fun measurableSet_Ioi fun p hp => ?_
    have hp0 : (0 : ℝ) < p := hp
    have hval : ‖sphericalTransform f p‖
        = Real.sqrt (2 / π) * (p⁻¹ * ‖sineKernelTransform (⇑G) p‖) := by
      rw [sphericalTransform_eq hf hp0, norm_mul, norm_mul, Complex.norm_real,
        Real.norm_eq_abs, abs_of_nonneg (Real.sqrt_nonneg _), norm_inv,
        Complex.norm_real, Real.norm_eq_abs, abs_of_pos hp0]
    rw [hval, mul_pow, mul_pow, Real.sq_sqrt (by positivity : (0:ℝ) ≤ 2 / π), inv_pow]
    field_simp
  rw [hL, hR, sineKernel_plancherel G hodd]
  field_simp

/-! ## Non-vacuity: an explicit odd Schwartz function

The hypothesis of `spherical_plancherel` is satisfied by a nonzero function: the
antisymmetrization of a smooth bump supported away from the origin.  So the
theorem really does say something about a nontrivial class of radial profiles.
-/

/-- A smooth bump centred at `2`, equal to `1` on `[1, 3]` and supported in
`(0, 4)`. -/
noncomputable def bumpAtTwo : ContDiffBump (2 : ℝ) := ⟨1, 2, one_pos, by norm_num⟩

/-- Its antisymmetrization: a nonzero odd smooth compactly supported function. -/
noncomputable def oddBump (x : ℝ) : ℂ := (bumpAtTwo x : ℂ) - (bumpAtTwo (-x) : ℂ)

theorem oddBump_odd (x : ℝ) : oddBump (-x) = -oddBump x := by
  simp only [oddBump, neg_neg]
  ring

theorem oddBump_two : oddBump 2 = 1 := by
  have h1 : bumpAtTwo (2 : ℝ) = 1 := bumpAtTwo.one_of_mem_closedBall (by simp [bumpAtTwo])
  have h2 : bumpAtTwo (-2 : ℝ) = 0 := by
    apply ContDiffBump.zero_of_le_dist
    simp [bumpAtTwo, Real.dist_eq]
    norm_num
  simp [oddBump, h1, h2]

theorem contDiff_oddBump : ContDiff ℝ ∞ oddBump := by
  have h1 : ContDiff ℝ ∞ (fun x : ℝ => (bumpAtTwo x : ℂ)) :=
    Complex.ofRealCLM.contDiff.comp bumpAtTwo.contDiff
  have h2 : ContDiff ℝ ∞ (fun x : ℝ => (bumpAtTwo (-x) : ℂ)) := h1.comp contDiff_neg
  exact h1.sub h2

theorem hasCompactSupport_oddBump : HasCompactSupport oddBump := by
  have h1 : HasCompactSupport (fun x : ℝ => (bumpAtTwo x : ℂ)) := by
    apply HasCompactSupport.comp_left (g := fun t : ℝ => (t : ℂ))
    · exact bumpAtTwo.hasCompactSupport
    · simp
  have h2 : HasCompactSupport (fun x : ℝ => (bumpAtTwo (-x) : ℂ)) :=
    h1.comp_homeomorph (Homeomorph.neg ℝ)
  exact h1.sub h2in every
angular-momentum sector.  `BookProof.ChapterBesselHarmonic` and
`BookProof.ChapterNote68AllModes` proved that the transform intertwines `−∂⃗²`
with multiplication by `p²` (Note 68); its *unitarity* was the remaining
recorded boundary.  This module proves it in the `s`-wave sector `l = 0`.

## Strategy

With `j₀(x) = sin x / x` the kernel collapses to a sine kernel: writing
`G(r) = r f(r)`,

`p · (𝓢f)(p) = √(2/π) ∫₀^∞ G(r) sin(p r) dr`,

so the spherical Plancherel theorem is exactly Plancherel for the **Fourier sine
transform** on `(0,∞)`.  That in turn is the Fourier–Plancherel theorem of
Mathlib applied to the *odd extension*: for an odd function `G` the Fourier
transform is `𝓕G(w) = −2i ∫₀^∞ sin(2πwx) G(x) dx`, and both `‖G‖²` and `‖𝓕G‖²`
are even, so the factors of two match up.

## Contents

* `integral_eq_zero_of_odd`, `integral_eq_two_smul_of_even`,
  `integral_eq_two_mul_of_even_real` — the elementary symmetry lemmas;
* `fourier_odd_eq` — the Fourier transform of an odd integrable function is
  `−2i` times its sine transform;
* `sine_plancherel` — **Plancherel for the sine transform** (`2π` convention);
* `sineKernel_plancherel` — the same in the analysts' `sin(pr)` convention:
  `∫₀^∞ |∫₀^∞ G(r) sin(pr) dr|² dp = (π/2) ∫₀^∞ |G(r)|² dr`;
* `spherical_plancherel` — **unitarity of the spherical transform for `l = 0`**:
  `∫₀^∞ |(𝓢f)(p)|² p² dp = ∫₀^∞ |f(r)|² r² dr`, for every radial profile `f`
  whose moment `r ↦ r f(r)` is (the restriction of) an odd Schwartz function.

The class of admissible profiles is a dense subspace of `L²((0,∞), r² dr)`; the
extension of `𝓢` to the whole space by continuity, and the sectors `l ≥ 1`, are
not treated here.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ChapterSphericalPlancherel

open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

/-! ## Elementary symmetry lemmas for integrals on the line -/

/-- The integral of an odd function over the whole line vanishes.  No
integrability hypothesis is needed: the Bochner integral of a non-integrable
function is `0`. -/
theorem integral_eq_zero_of_odd {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : ℝ → E) (h : ∀ x, f (-x) = -f x) : ∫ x : ℝ, f x = 0 := by
  have h1 : ∫ x : ℝ, f (-x) = ∫ x : ℝ, f x := integral_neg_eq_self f volume
  simp_rw [h, integral_neg] at h1
  have h2 : (2 : ℝ) • (∫ x : ℝ, f x) = 0 := by
    rw [two_smul]; nth_rewrite 1 [← h1]; abel
  simpa using h2

/-- The integral of an even integrable function is twice its integral over
`(0, ∞)`. -/
theorem integral_eq_two_smul_of_even {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : ℝ → E) (h : ∀ x, f (-x) = f x) (hf : Integrable f) :
    ∫ x : ℝ, f x = (2 : ℝ) • ∫ x in Ioi (0 : ℝ), f x := by
  have hsplit := intervalIntegral.integral_Iic_add_Ioi
    (hf.integrableOn (s := Iic 0)) (hf.integrableOn (s := Ioi 0))
  have key : ∫ x in Iic (0 : ℝ), f x = ∫ x in Ioi (0 : ℝ), f x := by
    rw [← neg_zero, ← integral_comp_neg_Ioi]
    simp_rw [h]; simp
  rw [← hsplit, key, two_smul]

/-- The real-valued version, which needs no integrability hypothesis. -/
theorem integral_eq_two_mul_of_even_real (h : ℝ → ℝ) (he : ∀ x, h (-x) = h x) :
    ∫ x : ℝ, h x = 2 * ∫ x in Ioi (0 : ℝ), h x := by
  rw [← integral_comp_abs (f := h)]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only
  rcases abs_cases x with ⟨h1, _⟩ | ⟨h1, _⟩
  · rw [h1]
  · rw [h1, he]

theorem integrable_bdd_mul (G : ℝ → ℂ) (hG : Integrable G) (u : ℝ → ℝ) (hu : Continuous u)
    (hb : ∀ x, |u x| ≤ 1) : Integrable (fun x : ℝ => (u x : ℂ) * G x) := by
  refine Integrable.bdd_mul (c := 1) hG
    ((Complex.continuous_ofReal.comp hu).aestronglyMeasurable) ?_
  filter_upwards with x
  rw [Complex.norm_real]
  exact hb x

/-! ## The sine transform and the Fourier transform of an odd function -/

/-- The Fourier **sine transform** in the `2π` convention used by Mathlib's
Fourier transform. -/
noncomputable def sineTransform (G : ℝ → ℂ) (w : ℝ) : ℂ :=
  ∫ x in Ioi (0 : ℝ), (Real.sin (2 * π * (x * w)) : ℂ) * G x

theorem sineTransform_odd (G : ℝ → ℂ) (w : ℝ) :
    sineTransform G (-w) = -sineTransform G w := by
  rw [sineTransform, sineTransform, ← integral_neg]
  refine setIntegral_congr_fun measurableSet_Ioi fun x _ => ?_
  rw [show 2 * π * (x * -w) = -(2 * π * (x * w)) by ring, Real.sin_neg]
  push_cast; ring

/-- Mathlib's Fourier transform written out with real cosine and sine. -/
theorem fourier_eq_cos_sub_sin (f : ℝ → ℂ) (w : ℝ) :
    𝓕 f w = ∫ x : ℝ, ((Real.cos (2 * π * (x * w)) : ℂ)
      - (Real.sin (2 * π * (x * w)) : ℂ) * Complex.I) * f x := by
  rw [Real.fourier_eq]
  refine integral_congr_ae (Filter.Eventually.of_forall fun v => ?_)
  simp only [RCLike.inner_apply, conj_trivial]
  rw [show ((𝐞 (-(w * v))) • f v) = (𝐞 (-(w * v)) : ℂ) * f v from rfl, Real.fourierChar_apply,
    show ((2 * π * -(w * v) : ℝ) : ℂ) * Complex.I
        = ((-(2 * π * (v * w)) : ℝ) : ℂ) * Complex.I by push_cast; ring,
    Complex.exp_mul_I]
  push_cast
  rw [Complex.cos_neg, Complex.sin_neg]
  ring

/-- **The Fourier transform of an odd function is `−2i` times its sine
transform.**  The cosine part integrates an odd function and vanishes; the sine
part integrates an even function and doubles. -/
theorem fourier_odd_eq (G : ℝ → ℂ) (hG : Integrable G) (hodd : ∀ x, G (-x) = -G x) (w : ℝ) :
    𝓕 G w = -(2 * Complex.I) * sineTransform G w := by
  have hA : Integrable (fun x : ℝ => (Real.cos (2 * π * (x * w)) : ℂ) * G x) :=
    integrable_bdd_mul G hG _ (by fun_prop) fun x => Real.abs_cos_le_one _
  have hB : Integrable (fun x : ℝ => (Real.sin (2 * π * (x * w)) : ℂ) * G x) :=
    integrable_bdd_mul G hG _ (by fun_prop) fun x => Real.abs_sin_le_one _
  rw [fourier_eq_cos_sub_sin]
  have hrw : (fun x : ℝ => ((Real.cos (2 * π * (x * w)) : ℂ)
      - (Real.sin (2 * π * (x * w)) : ℂ) * Complex.I) * G x)
      = fun x : ℝ => ((Real.cos (2 * π * (x * w)) : ℂ) * G x)
        + (-Complex.I) * ((Real.sin (2 * π * (x * w)) : ℂ) * G x) := by
    funext x; ring
  rw [hrw, integral_add hA (hB.const_mul _), integral_const_mul]
  have h0 : ∫ x : ℝ, (Real.cos (2 * π * (x * w)) : ℂ) * G x = 0 := by
    refine integral_eq_zero_of_odd _ fun x => ?_
    rw [hodd, show 2 * π * (-x * w) = -(2 * π * (x * w)) by ring, Real.cos_neg]
    ring
  have h2 : ∫ x : ℝ, (Real.sin (2 * π * (x * w)) : ℂ) * G x = (2 : ℝ) • sineTransform G w := by
    refine integral_eq_two_smul_of_even _ (fun x => ?_) hB
    rw [hodd, show 2 * π * (-x * w) = -(2 * π * (x * w)) by ring, Real.sin_neg]
    push_cast; ring
  rw [h0, h2, Complex.real_smul]
  push_cast
  ring

/-! ## Plancherel for the sine transform -/

/-- **Plancherel's theorem for the Fourier sine transform** (`2π` convention):
for an odd Schwartz function `G`,
`∫₀^∞ |∫₀^∞ sin(2πwx) G(x) dx|² dw = ¼ ∫₀^∞ |G(x)|² dx`. -/
theorem sine_plancherel (G : 𝓢(ℝ, ℂ)) (hodd : ∀ x, G (-x) = -G x) :
    ∫ w in Ioi (0 : ℝ), ‖sineTransform (⇑G) w‖ ^ 2
      = (1 / 4) * ∫ x in Ioi (0 : ℝ), ‖G x‖ ^ 2 := by
  have hP : ∫ w : ℝ, ‖𝓕 (⇑G) w‖ ^ 2 = ∫ x : ℝ, ‖G x‖ ^ 2 :=
    SchwartzMap.integral_norm_sq_fourier G
  have hFl : ∀ w : ℝ, ‖𝓕 (⇑G) w‖ ^ 2 = 4 * ‖sineTransform (⇑G) w‖ ^ 2 := by
    intro w
    rw [fourier_odd_eq _ G.integrable hodd, norm_mul]
    simp [mul_pow]
    norm_num
  have hL : ∫ w : ℝ, ‖𝓕 (⇑G) w‖ ^ 2
      = 2 * (4 * ∫ w in Ioi (0 : ℝ), ‖sineTransform (⇑G) w‖ ^ 2) := by
    rw [integral_eq_two_mul_of_even_real _
      fun w => by rw [hFl, hFl, sineTransform_odd, norm_neg]]
    simp_rw [hFl]
    rw [integral_const_mul]
  have hR : ∫ x : ℝ, ‖G x‖ ^ 2 = 2 * ∫ x in Ioi (0 : ℝ), ‖G x‖ ^ 2 :=
    integral_eq_two_mul_of_even_real _ fun x => by rw [hodd, norm_neg]
  rw [hL, hR] at hP
  linarith

/-- The sine transform in the analysts' convention, with kernel `sin(p r)`. -/
noncomputable def sineKernelTransform (G : ℝ → ℂ) (p : ℝ) : ℂ :=
  ∫ x in Ioi (0 : ℝ), (Real.sin (p * x) : ℂ) * G x

theorem sineKernelTransform_eq (G : ℝ → ℂ) (p : ℝ) :
    sineKernelTransform G p = sineTransform G ((2 * π)⁻¹ * p) := by
  rw [sineKernelTransform, sineTransform]
  refine setIntegral_congr_fun measurableSet_Ioi fun x _ => ?_
  congr 3
  field_simp

/-- **Plancherel for the sine transform**, analysts' convention:
`∫₀^∞ |∫₀^∞ G(r) sin(pr) dr|² dp = (π/2) ∫₀^∞ |G(r)|² dr`. -/
theorem sineKernel_plancherel (G : 𝓢(ℝ, ℂ)) (hodd : ∀ x, G (-x) = -G x) :
    ∫ p in Ioi (0 : ℝ), ‖sineKernelTransform (⇑G) p‖ ^ 2
      = (π / 2) * ∫ x in Ioi (0 : ℝ), ‖G x‖ ^ 2 := by
  have hpi : (0 : ℝ) < (2 * π)⁻¹ := by positivity
  have hsub : ∫ p in Ioi (0 : ℝ), ‖sineTransform (⇑G) ((2 * π)⁻¹ * p)‖ ^ 2
      = (2 * π) * ∫ w in Ioi (0 : ℝ), ‖sineTransform (⇑G) w‖ ^ 2 := by
    have hcv := integral_comp_mul_left_Ioi
      (fun w : ℝ => ‖sineTransform (⇑G) w‖ ^ 2) (0 : ℝ) hpi
    rw [hcv]
    simp only [mul_zero, smul_eq_mul, inv_inv]
  simp_rw [sineKernelTransform_eq]
  rw [hsub, sine_plancherel G hodd]
  ring

/-! ## Unitarity of the spherical transform in the `s`-wave sector -/

/-- The **spherical transform** of a radial profile in the sector `l = 0`:
`(𝓢f)(p) = √(2/π) ∫₀^∞ f(r) j₀(p r) r² dr`. -/
noncomputable def sphericalTransform (f : ℝ → ℂ) (p : ℝ) : ℂ :=
  (Real.sqrt (2 / π) : ℂ) * ∫ r in Ioi (0 : ℝ), f r * (sbessel 0 (p * r) : ℂ) * (r : ℂ) ^ 2

theorem sphericalTransform_eq {f : ℝ → ℂ} {G : ℝ → ℂ}
    (hf : ∀ r ∈ Ioi (0 : ℝ), (r : ℂ) * f r = G r) {p : ℝ} (hp : 0 < p) :
    sphericalTransform f p
      = (Real.sqrt (2 / π) : ℂ) * ((p : ℂ)⁻¹ * sineKernelTransform G p) := by
  have hint : (∫ r in Ioi (0 : ℝ), f r * (sbessel 0 (p * r) : ℂ) * (r : ℂ) ^ 2)
      = (p : ℂ)⁻¹ * sineKernelTransform G p := by
    rw [sineKernelTransform, ← MeasureTheory.integral_const_mul]
    refine setIntegral_congr_fun measurableSet_Ioi fun r hr => ?_
    have hrpos : (0 : ℝ) < r := mem_Ioi.mp hr
    have hrC : (r : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hrpos.ne'
    have hpC : (p : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hp.ne'
    have hb : (sbessel 0 (p * r) : ℂ) = (Real.sin (p * r) : ℂ) / ((p : ℂ) * (r : ℂ)) := by
      rw [sbessel_zero]
      simp only [sj0]
      push_cast
      ring
    rw [hb, ← hf r hr]
    field_simp
  rw [sphericalTransform, hint]

/-- **Unitarity of the spherical transform in the sector `l = 0`.**  For every
radial profile `f` on `(0, ∞)` whose moment `r ↦ r f(r)` is the restriction of an
odd Schwartz function,
`∫₀^∞ |(𝓢f)(p)|² p² dp = ∫₀^∞ |f(r)|² r² dr`,
i.e. the spherical transform preserves the norm of `L²((0,∞), r² dr)`. -/
theorem spherical_plancherel (G : 𝓢(ℝ, ℂ)) (hodd : ∀ x, G (-x) = -G x)
    (f : ℝ → ℂ) (hf : ∀ r ∈ Ioi (0 : ℝ), (r : ℂ) * f r = G r) :
    ∫ p in Ioi (0 : ℝ), ‖sphericalTransform f p‖ ^ 2 * p ^ 2
      = ∫ r in Ioi (0 : ℝ), ‖f r‖ ^ 2 * r ^ 2 := by
  have hpi : (0 : ℝ) < π := Real.pi_pos
  -- the right-hand side is the `L²(dr)` norm of `G`
  have hR : ∫ r in Ioi (0 : ℝ), ‖f r‖ ^ 2 * r ^ 2 = ∫ r in Ioi (0 : ℝ), ‖G r‖ ^ 2 := by
    refine setIntegral_congr_fun measurableSet_Ioi fun r hr => ?_
    have : ‖G r‖ = ‖(r : ℂ) * f r‖ := by rw [hf r hr]
    rw [this, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hr]
    ring
  -- the left-hand side is `(2/π)` times the sine-transform energy
  have hL : ∫ p in Ioi (0 : ℝ), ‖sphericalTransform f p‖ ^ 2 * p ^ 2
      = (2 / π) * ∫ p in Ioi (0 : ℝ), ‖sineKernelTransform (⇑G) p‖ ^ 2 := by
    rw [← MeasureTheory.integral_const_mul]
    refine setIntegral_congr_fun measurableSet_Ioi fun p hp => ?_
    have hp0 : (0 : ℝ) < p := hp
    have hval : ‖sphericalTransform f p‖
        = Real.sqrt (2 / π) * (p⁻¹ * ‖sineKernelTransform (⇑G) p‖) := by
      rw [sphericalTransform_eq hf hp0, norm_mul, norm_mul, Complex.norm_real,
        Real.norm_eq_abs, abs_of_nonneg (Real.sqrt_nonneg _), norm_inv,
        Complex.norm_real, Real.norm_eq_abs, abs_of_pos hp0]
    rw [hval, mul_pow, mul_pow, Real.sq_sqrt (by positivity : (0:ℝ) ≤ 2 / π), inv_pow]
    field_simp
  rw [hL, hR, sineKernel_plancherel G hodd]
  field_simp

/-! ## Non-vacuity: an explicit odd Schwartz function

The hypothesis of `spherical_plancherel` is satisfied by a nonzero function: the
antisymmetrization of a smooth bump supported away from the origin.  So the
theorem really does say something about a nontrivial class of radial profiles.
-/

/-- A smooth bump centred at `2`, equal to `1` on `[1, 3]` and supported in
`(0, 4)`. -/
noncomputable def bumpAtTwo : ContDiffBump (2 : ℝ) := ⟨1, 2, one_pos, by norm_num⟩

/-- Its antisymmetrization: a nonzero odd smooth compactly supported function. -/
noncomputable def oddBump (x : ℝ) : ℂ := (bumpAtTwo x : ℂ) - (bumpAtTwo (-x) : ℂ)

theorem oddBump_odd (x : ℝ) : oddBump (-x) = -oddBump x := by
  simp only [oddBump, neg_neg]
  ring

theorem oddBump_two : oddBump 2 = 1 := by
  have h1 : bumpAtTwo (2 : ℝ) = 1 := bumpAtTwo.one_of_mem_closedBall (by simp [bumpAtTwo])
  have h2 : bumpAtTwo (-2 : ℝ) = 0 := by
    apply ContDiffBump.zero_of_le_dist
    simp [bumpAtTwo, Real.dist_eq]
    norm_num
  simp [oddBump, h1, h2]

theorem contDiff_oddBump : ContDiff ℝ ∞ oddBump := by
  have h1 : ContDiff ℝ ∞ (fun x : ℝ => (bumpAtTwo x : ℂ)) :=
    Complex.ofRealCLM.contDiff.comp bumpAtTwo.contDiff
  have h2 : ContDiff ℝ ∞ (fun x : ℝ => (bumpAtTwo (-x) : ℂ)) := h1.comp contDiff_neg
  exact h1.sub h2

theorem hasCompactSupport_oddBump : HasCompactSupport oddBump := by
  have h1 : HasCompactSupport (fun x : ℝ => (bumpAtTwo x : ℂ)) := by
    apply HasCompactSupport.comp_left (g := fun t : ℝ => (t : ℂ))
    · exact bumpAtTwo.hasCompactSupport
    · simp
  have h2 : HasCompactSupport (fun x : ℝ => (bumpAtTwo (-x) : ℂ)) :=
    h1.comp_homeomorph (Homeomorph.neg ℝ)
  exact h1.sub h2

/-- `oddBump` as a Schwartz function. -/
noncomputable def oddSchwartz : 𝓢(ℝ, ℂ) :=
  hasCompactSupport_oddBump.toSchwartzMap contDiff_oddBump

theorem oddSchwartz_apply (x : ℝ) : oddSchwartz x = oddBump x := rfl

theorem oddSchwartz_odd (x : ℝ) : oddSchwartz (-x) = -oddSchwartz x := oddBump_odd x

theorem oddSchwartz_ne_zero : oddSchwartz ≠ 0 := by
  intro h
  have h2 : oddSchwartz 2 = 0 := by rw [h]; rfl
  rw [oddSchwartz_apply, oddBump_two] at h2
  exact one_ne_zero h2

/-- **The spherical Plancherel theorem applied to a concrete nonzero profile**,
`f(r) = oddBump(r)/r`, which vanishes near the origin and has compact support.
This witnesses that `spherical_plancherel` is not vacuous. -/
theorem spherical_plancherel_bump :
    ∫ p in Ioi (0 : ℝ), ‖sphericalTransform (fun r : ℝ => oddBump r / (r : ℂ)) p‖ ^ 2 * p ^ 2
      = ∫ r in Ioi (0 : ℝ), ‖oddBump r / (r : ℂ)‖ ^ 2 * r ^ 2 :=
  spherical_plancherel oddSchwartz oddSchwartz_odd _ fun r hr => by
    have hrC : (r : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr (mem_Ioi.mp hr).ne'
    rw [oddSchwartz_apply]
    field_simp

end BookProof.ChapterSphericalPlancherel
