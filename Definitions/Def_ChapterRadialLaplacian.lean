import Definitions.Def_ChapterSphericalBesselODE
import Definitions.Def_ChapterSphericalBessel
import Mathlib


/-!
# The Laplacian of a radial function, and the `s`-wave form of Note 68

Source: `book.tex`, §A.5, subsection *"Hankel–Majorana Transform"*, **Note 68**
(`book.tex` line ~5860), which asserts for the inverse spherical transform

`−∂⃗² 𝓗_P⁻¹{ψ}(x⃗) = 𝓗_P⁻¹{p²ψ}(x⃗)`.

`BookProof.ChapterSphericalBesselODE` proved the *radial* half of this identity
(the spherical Bessel equation, for every angular momentum `l`).  What was still
missing to state the identity in space, rather than in the radial variable, is
the classical formula for the Laplacian of a radial function.  Mathlib has the
Laplacian `Δ` on a real inner product space but no formula for radial functions,
so this module develops it.

## Contents

* `innerCLM` — the real inner product as a continuous linear map
  `E →L[ℝ] (E →L[ℝ] ℝ)` (Mathlib's `innerSL` is conjugate-linear in its first
  slot, which makes it unusable as the derivative of `y ↦ ⟪y, ·⟫`);
* `laplacian_comp_normSq` — for `G` twice continuously differentiable at `‖x‖²`,
  `Δ (fun y ↦ G ‖y‖²) x = 4‖x‖² G''(‖x‖²) + 2n G'(‖x‖²)`, `n = dim E`;
* `deriv_sqrt_comp` — the one-variable chain rule that converts the squared-norm
  parametrization into the radial one;
* `laplacian_radial` — **the classical formula**: for `x ≠ 0` and `g` twice
  continuously differentiable at `‖x‖`,
  `Δ (fun y ↦ g ‖y‖) x = g''(‖x‖) + ((n−1)/‖x‖) · g'(‖x‖)`;
* `laplacian_sbessel_zero`, `helmholtz_sbessel_zero` — **Note 68 in the `s`-wave
  sector**: on a three-dimensional real inner product space, away from the
  origin, `u(x⃗) = j₀(p‖x⃗‖) = sin(p‖x⃗‖)/(p‖x⃗‖)` satisfies `−∂⃗²u = p²u`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ChapterRadialLaplacian

open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-- The real inner product as a continuous linear map `E →L[ℝ] (E →L[ℝ] ℝ)`.
This is `innerSL` with both slots linear, which is what is needed to
differentiate `y ↦ ⟪y, ·⟫`. -/
noncomputable def innerCLM (E : Type*) [NormedAddCommGroup E] [InnerProductSpace ℝ E] :
    E →L[ℝ] (E →L[ℝ] ℝ) :=
  (innerₗ E).mkContinuous₂ 1 (fun x y => by simpa using abs_real_inner_le_norm x y)

@[simp] theorem innerCLM_apply (x y : E) : innerCLM E x y = ⟪x, y⟫_ℝ := rfl

 radial function, and the `s`-wave form of Note 68

Source: `book.tex`, §A.5, subsection *"Hankel–Majorana Transform"*, **Note 68**
(`book.tex` line ~5860), which asserts for the inverse spherical transform

`−∂⃗² 𝓗_P⁻¹{ψ}(x⃗) = 𝓗_P⁻¹{p²ψ}(x⃗)`.

`BookProof.ChapterSphericalBesselODE` proved the *radial* half of this identity
(the spherical Bessel equation, for every angular momentum `l`).  What was still
missing to state the identity in space, rather than in the radial variable, is
the classical formula for the Laplacian of a radial function.  Mathlib has the
Laplacian `Δ` on a real inner product space but no formula for radial functions,
so this module develops it.

## Contents

* `innerCLM` — the real inner product as a continuous linear map
  `E →L[ℝ] (E →L[ℝ] ℝ)` (Mathlib's `innerSL` is conjugate-linear in its first
  slot, which makes it unusable as the derivative of `y ↦ ⟪y, ·⟫`);
* `laplacian_comp_normSq` — for `G` twice continuously differentiable at `‖x‖²`,
  `Δ (fun y ↦ G ‖y‖²) x = 4‖x‖² G''(‖x‖²) + 2n G'(‖x‖²)`, `n = dim E`;
* `deriv_sqrt_comp` — the one-variable chain rule that converts the squared-norm
  parametrization into the radial one;
* `laplacian_radial` — **the classical formula**: for `x ≠ 0` and `g` twice
  continuously differentiable at `‖x‖`,
  `Δ (fun y ↦ g ‖y‖) x = g''(‖x‖) + ((n−1)/‖x‖) · g'(‖x‖)`;
* `laplacian_sbessel_zero`, `helmholtz_sbessel_zero` — **Note 68 in the `s`-wave
  sector**: on a three-dimensional real inner product space, away from the
  origin, `u(x⃗) = j₀(p‖x⃗‖) = sin(p‖x⃗‖)/(p‖x⃗‖)` satisfies `−∂⃗²u = p²u`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ChapterRadialLaplacian

open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-- The real inner product as a continuous linear map `E →L[ℝ] (E →L[ℝ] ℝ)`.
This is `innerSL` with both slots linear, which is what is needed to
differentiate `y ↦ ⟪y, ·⟫`. -/
noncomputable def innerCLM (E : Type*) [NormedAddCommGroup E] [InnerProductSpace ℝ E] :
    E →L[ℝ] (E →L[ℝ] ℝ) :=
  (innerₗ E).mkContinuous₂ 1 (fun x y => by simpa using abs_real_inner_le_norm x y)

@[simp] theorem innerCLM_apply (x y : E) : innerCLM E x y = ⟪x, y⟫_ℝ := rfl

theorem hasFDerivAt_normSq (x : E) :
    HasFDerivAt (fun z : E => ‖z‖ ^ 2) ((2 : ℝ) • innerCLM E x) x := by
  have h := (hasStrictFDerivAt_norm_sq x).hasFDerivAt
  convert h using 1
  ext y
  simp [two_smul]

/-- A function that is twice continuously differentiable at a point has a
differentiable derivative there. -/
theorem diffAt_deriv_of_contDiffAt_two {G : ℝ → ℝ} {q : ℝ} (h : ContDiffAt ℝ 2 G q) :
    DifferentiableAt ℝ (deriv G) q := by
  obtain ⟨u, hu, hGu⟩ := h.contDiffOn (m := 2) le_rfl (by simp)
  obtain ⟨v, hvu, hvo, hqv⟩ := mem_nhds_iff.1 hu
  have h2 : ContDiffOn ℝ 1 (deriv G) v := (hGu.mono hvu).deriv_of_isOpen hvo (by norm_num)
  exact (h2.differentiableOn (by norm_num)).differentiableAt (hvo.mem_nhds hqv)











/-! ## Note 68 in the `s`-wave sector -/

open BookProof.ChapterSphericalBessel BookProof.ChapterSphericalBesselODE



rse spherical transform

`−∂⃗² 𝓗_P⁻¹{ψ}(x⃗) = 𝓗_P⁻¹{p²ψ}(x⃗)`.

`BookProof.ChapterSphericalBesselODE` proved the *radial* half of this identity
(the spherical Bessel equation, for every angular momentum `l`).  What was still
missing to state the identity in space, rather than in the radial variable, is
the classical formula for the Laplacian of a radial function.  Mathlib has the
Laplacian `Δ` on a real inner product space but no formula for radial functions,
so this module develops it.

## Contents

* `innerCLM` — the real inner product as a continuous linear map
  `E →L[ℝ] (E →L[ℝ] ℝ)` (Mathlib's `innerSL` is conjugate-linear in its first
  slot, which makes it unusable as the derivative of `y ↦ ⟪y, ·⟫`);
* `laplacian_comp_normSq` — for `G` twice continuously differentiable at `‖x‖²`,
  `Δ (fun y ↦ G ‖y‖²) x = 4‖x‖² G''(‖x‖²) + 2n G'(‖x‖²)`, `n = dim E`;
* `deriv_sqrt_comp` — the one-variable chain rule that converts the squared-norm
  parametrization into the radial one;
* `laplacian_radial` — **the classical formula**: for `x ≠ 0` and `g` twice
  continuously differentiable at `‖x‖`,
  `Δ (fun y ↦ g ‖y‖) x = g''(‖x‖) + ((n−1)/‖x‖) · g'(‖x‖)`;
* `laplacian_sbessel_zero`, `helmholtz_sbessel_zero` — **Note 68 in the `s`-wave
  sector**: on a three-dimensional real inner product space, away from the
  origin, `u(x⃗) = j₀(p‖x⃗‖) = sin(p‖x⃗‖)/(p‖x⃗‖)` satisfies `−∂⃗²u = p²u`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ChapterRadialLaplacian

open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-- The real inner product as a continuous linear map `E →L[ℝ] (E →L[ℝ] ℝ)`.
This is `innerSL` with both slots linear, which is what is needed to
differentiate `y ↦ ⟪y, ·⟫`. -/
noncomputable def innerCLM (E : Type*) [NormedAddCommGroup E] [InnerProductSpace ℝ E] :
    E →L[ℝ] (E →L[ℝ] ℝ) :=
  (innerₗ E).mkContinuous₂ 1 (fun x y => by simpa using abs_real_inner_le_norm x y)

@[simp] theorem innerCLM_apply (x y : E) : innerCLM E x y = ⟪x, y⟫_ℝ := rfl

theorem hasFDerivAt_normSq (x : E) :
    HasFDerivAt (fun z : E => ‖z‖ ^ 2) ((2 : ℝ) • innerCLM E x) x := by
  have h := (hasStrictFDerivAt_norm_sq x).hasFDerivAt
  convert h using 1
  ext y
  simp [two_smul]

/-- A function that is twice continuously differentiable at a point has a
differentiable derivative there. -/
theorem diffAt_deriv_of_contDiffAt_two {G : ℝ → ℝ} {q : ℝ} (h : ContDiffAt ℝ 2 G q) :
    DifferentiableAt ℝ (deriv G) q := by
  obtain ⟨u, hu, hGu⟩ := h.contDiffOn (m := 2) le_rfl (by simp)
  obtain ⟨v, hvu, hvo, hqv⟩ := mem_nhds_iff.1 hu
  have h2 : ContDiffOn ℝ 1 (deriv G) v := (hGu.mono hvu).deriv_of_isOpen hvo (by norm_num)
  exact (h2.differentiableOn (by norm_num)).differentiableAt (hvo.mem_nhds hqv)

theorem fderiv_comp_normSq {G : ℝ → ℝ} {x : E} (hG : ContDiffAt ℝ 2 G (‖x‖ ^ 2)) :
    (fderiv ℝ fun z : E => G (‖z‖ ^ 2)) =ᶠ[nhds x]
      fun y => (2 * deriv G (‖y‖ ^ 2)) • (innerCLM E y) := by
  have hcont : Continuous fun y : E => ‖y‖ ^ 2 := continuous_norm.pow 2
  have hev : ∀ᶠ q in nhds (‖x‖ ^ 2), DifferentiableAt ℝ G q := by
    filter_upwards [hG.eventually (by simp)] with q hq using hq.differentiableAt (by norm_num)
  have hevx : ∀ᶠ y in nhds x, DifferentiableAt ℝ G (‖y‖ ^ 2) :=
    (hcont.continuousAt (x := x)).eventually hev
  filter_upwards [hevx] with y hy
  have hcomp : HasFDerivAt (fun z : E => G (‖z‖ ^ 2))
      ((deriv G (‖y‖ ^ 2)) • ((2 : ℝ) • innerCLM E y)) y :=
    (hy.hasDerivAt).comp_hasFDerivAt y (hasFDerivAt_normSq y)
  rw [hcomp.fderiv, smul_smul]
  ring_nf

theorem fderiv_fderiv_comp_normSq [FiniteDimensional ℝ E] {G : ℝ → ℝ} {x : E}
    (hG : ContDiffAt ℝ 2 G (‖x‖ ^ 2)) :
    fderiv ℝ (fderiv ℝ fun y : E => G (‖y‖ ^ 2)) x
      = (2 * deriv G (‖x‖ ^ 2)) • (innerCLM E)
        + ((4 * deriv (deriv G) (‖x‖ ^ 2)) • innerCLM E x).smulRight (innerCLM E x) := by
  have hc : HasFDerivAt (fun y : E => 2 * deriv G (‖y‖ ^ 2))
      ((4 * deriv (deriv G) (‖x‖ ^ 2)) • innerCLM E x) x := by
    have hd0 : HasFDerivAt ((deriv G) ∘ fun z : E => ‖z‖ ^ 2)
        ((deriv (deriv G) (‖x‖ ^ 2)) • ((2 : ℝ) • innerCLM E x)) x :=
      ((diffAt_deriv_of_contDiffAt_two hG).hasDerivAt).comp_hasFDerivAt x (hasFDerivAt_normSq x)
    have hd : HasFDerivAt (fun y : E => deriv G (‖y‖ ^ 2))
        ((2 * deriv (deriv G) (‖x‖ ^ 2)) • innerCLM E x) x := by
      rw [smul_smul] at hd0
      convert hd0 using 2 <;> (first | rfl | ring)
    have h2 := hd.const_mul (2 : ℝ)
    convert h2 using 1 <;> (first | rfl | (rw [smul_smul]; ring_nf))
  have hF : HasFDerivAt (fun y : E => (2 * deriv G (‖y‖ ^ 2)) • innerCLM E y)
      ((2 * deriv G (‖x‖ ^ 2)) • (innerCLM E)
        + ((4 * deriv (deriv G) (‖x‖ ^ 2)) • innerCLM E x).smulRight (innerCLM E x)) x :=
    hc.smul (innerCLM E).hasFDerivAt
  rw [(fderiv_comp_normSq hG).fderiv_eq, hF.fderiv]

/-- **The Laplacian of a function of the squared norm.**  For `G` twice
continuously differentiable at `‖x‖²`,
`Δ (fun y ↦ G ‖y‖²) x = 4‖x‖² G''(‖x‖²) + 2n G'(‖x‖²)` with `n = dim E`. -/
theorem laplacian_comp_normSq [FiniteDimensional ℝ E] {G : ℝ → ℝ} {x : E}
    (hG : ContDiffAt ℝ 2 G (‖x‖ ^ 2)) :
    (Δ fun y : E => G (‖y‖ ^ 2)) x
      = 4 * ‖x‖ ^ 2 * deriv (deriv G) (‖x‖ ^ 2)
        + 2 * (Module.finrank ℝ E) * deriv G (‖x‖ ^ 2) := by
  have hsnd := fderiv_fderiv_comp_normSq hG
  rw [laplacian_eq_iteratedFDeriv_stdOrthonormalBasis]
  have hterm : ∀ i, iteratedFDeriv ℝ 2 (fun y : E => G (‖y‖ ^ 2)) x
      ![(stdOrthonormalBasis ℝ E) i, (stdOrthonormalBasis ℝ E) i]
      = 2 * deriv G (‖x‖ ^ 2) * ⟪(stdOrthonormalBasis ℝ E) i, (stdOrthonormalBasis ℝ E) i⟫_ℝ
        + 4 * deriv (deriv G) (‖x‖ ^ 2) * (⟪x, (stdOrthonormalBasis ℝ E) i⟫_ℝ
            * ⟪x, (stdOrthonormalBasis ℝ E) i⟫_ℝ) := by
    intro i
    rw [iteratedFDeriv_two_apply, hsnd]
    simp
    ring
  simp only [hterm]
  rw [Finset.sum_add_distrib]
  have h1 : ∑ i, 2 * deriv G (‖x‖ ^ 2)
      * ⟪(stdOrthonormalBasis ℝ E) i, (stdOrthonormalBasis ℝ E) i⟫_ℝ
      = 2 * (Module.finrank ℝ E) * deriv G (‖x‖ ^ 2) := by
    simp [(stdOrthonormalBasis ℝ E).orthonormal.1]
    ring
  have h2 : ∑ i, 4 * deriv (deriv G) (‖x‖ ^ 2) * (⟪x, (stdOrthonormalBasis ℝ E) i⟫_ℝ
      * ⟪x, (stdOrthonormalBasis ℝ E) i⟫_ℝ) = 4 * ‖x‖ ^ 2 * deriv (deriv G) (‖x‖ ^ 2) := by
    rw [← Finset.mul_sum]
    have hsum := (stdOrthonormalBasis ℝ E).sum_inner_mul_inner x x
    simp only [real_inner_comm x] at hsum ⊢
    rw [hsum, real_inner_self_eq_norm_sq]
    ring
  rw [h1, h2]
  ring

/-- The chain rule for `q ↦ g (√q)` at `q = r²`, `r > 0`, to second order. -/
theorem deriv_sqrt_comp {g : ℝ → ℝ} {r : ℝ} (hr : 0 < r) (hg : ContDiffAt ℝ 2 g r) :
    deriv (fun q => g (Real.sqrt q)) (r ^ 2) = deriv g r * (1 / (2 * r)) ∧
    deriv (deriv fun q => g (Real.sqrt q)) (r ^ 2)
      = deriv (deriv g) r * (1 / (2 * r)) * (1 / (2 * r)) + deriv g r * (-(1 / (4 * r ^ 3))) := by
  have hr' : r ≠ 0 := ne_of_gt hr
  have hsq : Real.sqrt (r ^ 2) = r := Real.sqrt_sq hr.le
  have hgev : ∀ᶠ s in nhds r, DifferentiableAt ℝ g s := by
    filter_upwards [hg.eventually (by simp)] with s hs using hs.differentiableAt (by norm_num)
  have hcont' : Tendsto Real.sqrt (nhds (r ^ 2)) (nhds r) := by
    have h := (Real.continuous_sqrt).continuousAt (x := r ^ 2)
    rwa [ContinuousAt, hsq] at h
  have hqev : ∀ᶠ q in nhds (r ^ 2), DifferentiableAt ℝ g (Real.sqrt q) := hcont'.eventually hgev
  have hpos : ∀ᶠ q in nhds (r ^ 2), q ≠ 0 := isOpen_ne.mem_nhds (pow_ne_zero 2 hr')
  have hderiv : (deriv fun q => g (Real.sqrt q)) =ᶠ[nhds (r ^ 2)]
      fun q => deriv g (Real.sqrt q) * (1 / (2 * Real.sqrt q)) := by
    filter_upwards [hqev, hpos] with q hq hq0
    exact (hq.hasDerivAt.comp q (Real.hasDerivAt_sqrt hq0)).deriv
  have hs : HasDerivAt (fun x : ℝ => Real.sqrt x) (1 / (2 * r)) (r ^ 2) := by
    have h := Real.hasDerivAt_sqrt (x := r ^ 2) (pow_ne_zero 2 hr')
    rwa [hsq] at h
  constructor
  · have h := hderiv.self_of_nhds
    simpa [hsq] using h
  · have h1 : HasDerivAt (fun q => deriv g (Real.sqrt q))
        (deriv (deriv g) r * (1 / (2 * r))) (r ^ 2) := by
      have hd : HasDerivAt (deriv g) (deriv (deriv g) r) (Real.sqrt (r ^ 2)) := by
        rw [hsq]; exact (diffAt_deriv_of_contDiffAt_two hg).hasDerivAt
      exact hd.comp (r ^ 2) hs
    have hsinv : HasDerivAt (fun q : ℝ => (Real.sqrt q)⁻¹) (-(1 / (2 * r)) / r ^ 2) (r ^ 2) := by
      have h := hs.inv (by rw [hsq]; exact hr')
      rwa [hsq] at h
    have h2 : HasDerivAt (fun q : ℝ => 1 / (2 * Real.sqrt q)) (-(1 / (4 * r ^ 3))) (r ^ 2) := by
      have h := hsinv.const_mul (1 / 2 : ℝ)
      have hfun : (fun q : ℝ => (1 / 2 : ℝ) * (Real.sqrt q)⁻¹)
          = fun q : ℝ => 1 / (2 * Real.sqrt q) := by
        funext q; rw [one_div, one_div, mul_inv]
      rw [hfun] at h
      convert h using 1 <;> (first | rfl | (field_simp; ring))
    have hprod : HasDerivAt (fun q : ℝ => deriv g (Real.sqrt q) * (1 / (2 * Real.sqrt q)))
        (deriv (deriv g) r * (1 / (2 * r)) * (1 / (2 * Real.sqrt (r ^ 2)))
          + deriv g (Real.sqrt (r ^ 2)) * (-(1 / (4 * r ^ 3)))) (r ^ 2) := h1.mul h2
    rw [hderiv.deriv_eq, hprod.deriv, hsq]

/-- **The Laplacian of a radial function.**  On an `n`-dimensional real inner
product space, for `x ≠ 0` and `g` twice continuously differentiable at `‖x‖`,
`Δ (fun y ↦ g ‖y‖) x = g''(‖x‖) + ((n − 1)/‖x‖) · g'(‖x‖)`. -/
theorem laplacian_radial [FiniteDimensional ℝ E] {g : ℝ → ℝ} {x : E} (hx : x ≠ 0)
    (hg : ContDiffAt ℝ 2 g ‖x‖) :
    (Δ fun y : E => g ‖y‖) x
      = deriv (deriv g) ‖x‖
        + (((Module.finrank ℝ E : ℝ) - 1) / ‖x‖) * deriv g ‖x‖ := by
  have hr : 0 < ‖x‖ := norm_pos_iff.mpr hx
  have hr' : ‖x‖ ≠ 0 := ne_of_gt hr
  have hsq : Real.sqrt (‖x‖ ^ 2) = ‖x‖ := Real.sqrt_sq (norm_nonneg x)
  have hfun : (fun y : E => g ‖y‖) = fun y : E => g (Real.sqrt (‖y‖ ^ 2)) := by
    funext y; rw [Real.sqrt_sq (norm_nonneg y)]
  have hG : ContDiffAt ℝ 2 (fun q => g (Real.sqrt q)) (‖x‖ ^ 2) := by
    have hsqrt : ContDiffAt ℝ 2 (fun q : ℝ => Real.sqrt q) (‖x‖ ^ 2) :=
      Real.contDiffAt_sqrt (pow_ne_zero 2 hr')
    have : ContDiffAt ℝ 2 g (Real.sqrt (‖x‖ ^ 2)) := by rw [hsq]; exact hg
    exact this.comp (‖x‖ ^ 2) hsqrt
  obtain ⟨hd1, hd2⟩ := deriv_sqrt_comp hr hg
  rw [hfun, laplacian_comp_normSq hG, hd1, hd2]
  field_simp
  ring

/-! ## Note 68 in the `s`-wave sector -/

open BookProof.ChapterSphericalBessel BookProof.ChapterSphericalBesselODE

theorem contDiffAt_sbessel_zero {r : ℝ} (hr : r ≠ 0) : ContDiffAt ℝ 2 (sbessel 0) r := by
  have h : ContDiffOn ℝ (⊤ : ℕ∞) (gIter 0) {s : ℝ | s ≠ 0} := contDiffOn_gIter 0
  have hfun : sbessel 0 = gIter 0 := by
    funext s; rw [sbessel_eq]; simp
  have hat : ContDiffAt ℝ (⊤ : ℕ∞) (gIter 0) r :=
    (h.contDiffAt (isOpen_ne.mem_nhds hr))
  rw [hfun]
  exact hat.of_le ENat.LEInfty.out

/-- **Note 68 in the `s`-wave sector.**  On a three-dimensional real inner
product space and away from the origin, the Laplacian of
`u(x⃗) = j₀(p‖x⃗‖) = sin(p‖x⃗‖)/(p‖x⃗‖)` is `−p² u`. -/
theorem laplacian_sbessel_zero [FiniteDimensional ℝ E] (h3 : Module.finrank ℝ E = 3)
    {p : ℝ} {x : E} (hp : p ≠ 0) (hx : x ≠ 0) :
    (Δ fun y : E => sbessel 0 (p * ‖y‖)) x = -(p ^ 2) * sbessel 0 (p * ‖x‖) := by
  have hr : 0 < ‖x‖ := norm_pos_iff.mpr hx
  have hr' : ‖x‖ ≠ 0 := ne_of_gt hr
  have hg : ContDiffAt ℝ 2 (fun s : ℝ => sbessel 0 (p * s)) ‖x‖ := by
    have hmul : ContDiffAt ℝ 2 (fun s : ℝ => p * s) ‖x‖ :=
      (contDiff_const.mul contDiff_id).contDiffAt
    exact (contDiffAt_sbessel_zero (mul_ne_zero hp hr')).comp ‖x‖ hmul
  have hlap := laplacian_radial (g := fun s : ℝ => sbessel 0 (p * s)) hx hg
  rw [h3] at hlap
  have herical transform

`−∂⃗² 𝓗_P⁻¹{ψ}(x⃗) = 𝓗_P⁻¹{p²ψ}(x⃗)`.

`BookProof.ChapterSphericalBesselODE` proved the *radial* half of this identity
(the spherical Bessel equation, for every angular momentum `l`).  What was still
missing to state the identity in space, rather than in the radial variable, is
the classical formula for the Laplacian of a radial function.  Mathlib has the
Laplacian `Δ` on a real inner product space but no formula for radial functions,
so this module develops it.

## Contents

* `innerCLM` — the real inner product as a continuous linear map
  `E →L[ℝ] (E →L[ℝ] ℝ)` (Mathlib's `innerSL` is conjugate-linear in its first
  slot, which makes it unusable as the derivative of `y ↦ ⟪y, ·⟫`);
* `laplacian_comp_normSq` — for `G` twice continuously differentiable at `‖x‖²`,
  `Δ (fun y ↦ G ‖y‖²) x = 4‖x‖² G''(‖x‖²) + 2n G'(‖x‖²)`, `n = dim E`;
* `deriv_sqrt_comp` — the one-variable chain rule that converts the squared-norm
  parametrization into the radial one;
* `laplacian_radial` — **the classical formula**: for `x ≠ 0` and `g` twice
  continuously differentiable at `‖x‖`,
  `Δ (fun y ↦ g ‖y‖) x = g''(‖x‖) + ((n−1)/‖x‖) · g'(‖x‖)`;
* `laplacian_sbessel_zero`, `helmholtz_sbessel_zero` — **Note 68 in the `s`-wave
  sector**: on a three-dimensional real inner product space, away from the
  origin, `u(x⃗) = j₀(p‖x⃗‖) = sin(p‖x⃗‖)/(p‖x⃗‖)` satisfies `−∂⃗²u = p²u`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ChapterRadialLaplacian

open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-- The real inner product as a continuous linear map `E →L[ℝ] (E →L[ℝ] ℝ)`.
This is `innerSL` with both slots linear, which is what is needed to
differentiate `y ↦ ⟪y, ·⟫`. -/
noncomputable def innerCLM (E : Type*) [NormedAddCommGroup E] [InnerProductSpace ℝ E] :
    E →L[ℝ] (E →L[ℝ] ℝ) :=
  (innerₗ E).mkContinuous₂ 1 (fun x y => by simpa using abs_real_inner_le_norm x y)

@[simp] theorem innerCLM_apply (x y : E) : innerCLM E x y = ⟪x, y⟫_ℝ := rfl

theorem hasFDerivAt_normSq (x : E) :
    HasFDerivAt (fun z : E => ‖z‖ ^ 2) ((2 : ℝ) • innerCLM E x) x := by
  have h := (hasStrictFDerivAt_norm_sq x).hasFDerivAt
  convert h using 1
  ext y
  simp [two_smul]

/-- A function that is twice continuously differentiable at a point has a
differentiable derivative there. -/
theorem diffAt_deriv_of_contDiffAt_two {G : ℝ → ℝ} {q : ℝ} (h : ContDiffAt ℝ 2 G q) :
    DifferentiableAt ℝ (deriv G) q := by
  obtain ⟨u, hu, hGu⟩ := h.contDiffOn (m := 2) le_rfl (by simp)
  obtain ⟨v, hvu, hvo, hqv⟩ := mem_nhds_iff.1 hu
  have h2 : ContDiffOn ℝ 1 (deriv G) v := (hGu.mono hvu).deriv_of_isOpen hvo (by norm_num)
  exact (h2.differentiableOn (by norm_num)).differentiableAt (hvo.mem_nhds hqv)

theorem fderiv_comp_normSq {G : ℝ → ℝ} {x : E} (hG : ContDiffAt ℝ 2 G (‖x‖ ^ 2)) :
    (fderiv ℝ fun z : E => G (‖z‖ ^ 2)) =ᶠ[nhds x]
      fun y => (2 * deriv G (‖y‖ ^ 2)) • (innerCLM E y) := by
  have hcont : Continuous fun y : E => ‖y‖ ^ 2 := continuous_norm.pow 2
  have hev : ∀ᶠ q in nhds (‖x‖ ^ 2), DifferentiableAt ℝ G q := by
    filter_upwards [hG.eventually (by simp)] with q hq using hq.differentiableAt (by norm_num)
  have hevx : ∀ᶠ y in nhds x, DifferentiableAt ℝ G (‖y‖ ^ 2) :=
    (hcont.continuousAt (x := x)).eventually hev
  filter_upwards [hevx] with y hy
  have hcomp : HasFDerivAt (fun z : E => G (‖z‖ ^ 2))
      ((deriv G (‖y‖ ^ 2)) • ((2 : ℝ) • innerCLM E y)) y :=
    (hy.hasDerivAt).comp_hasFDerivAt y (hasFDerivAt_normSq y)
  rw [hcomp.fderiv, smul_smul]
  ring_nf

theorem fderiv_fderiv_comp_normSq [FiniteDimensional ℝ E] {G : ℝ → ℝ} {x : E}
    (hG : ContDiffAt ℝ 2 G (‖x‖ ^ 2)) :
    fderiv ℝ (fderiv ℝ fun y : E => G (‖y‖ ^ 2)) x
      = (2 * deriv G (‖x‖ ^ 2)) • (innerCLM E)
        + ((4 * deriv (deriv G) (‖x‖ ^ 2)) • innerCLM E x).smulRight (innerCLM E x) := by
  have hc : HasFDerivAt (fun y : E => 2 * deriv G (‖y‖ ^ 2))
      ((4 * deriv (deriv G) (‖x‖ ^ 2)) • innerCLM E x) x := by
    have hd0 : HasFDerivAt ((deriv G) ∘ fun z : E => ‖z‖ ^ 2)
        ((deriv (deriv G) (‖x‖ ^ 2)) • ((2 : ℝ) • innerCLM E x)) x :=
      ((diffAt_deriv_of_contDiffAt_two hG).hasDerivAt).comp_hasFDerivAt x (hasFDerivAt_normSq x)
    have hd : HasFDerivAt (fun y : E => deriv G (‖y‖ ^ 2))
        ((2 * deriv (deriv G) (‖x‖ ^ 2)) • innerCLM E x) x := by
      rw [smul_smul] at hd0
      convert hd0 using 2 <;> (first | rfl | ring)
    have h2 := hd.const_mul (2 : ℝ)
    convert h2 using 1 <;> (first | rfl | (rw [smul_smul]; ring_nf))
  have hF : HasFDerivAt (fun y : E => (2 * deriv G (‖y‖ ^ 2)) • innerCLM E y)
      ((2 * deriv G (‖x‖ ^ 2)) • (innerCLM E)
        + ((4 * deriv (deriv G) (‖x‖ ^ 2)) • innerCLM E x).smulRight (innerCLM E x)) x :=
    hc.smul (innerCLM E).hasFDerivAt
  rw [(fderiv_comp_normSq hG).fderiv_eq, hF.fderiv]

/-- **The Laplacian of a function of the squared norm.**  For `G` twice
continuously differentiable at `‖x‖²`,
`Δ (fun y ↦ G ‖y‖²) x = 4‖x‖² G''(‖x‖²) + 2n G'(‖x‖²)` with `n = dim E`. -/
theorem laplacian_comp_normSq [FiniteDimensional ℝ E] {G : ℝ → ℝ} {x : E}
    (hG : ContDiffAt ℝ 2 G (‖x‖ ^ 2)) :
    (Δ fun y : E => G (‖y‖ ^ 2)) x
      = 4 * ‖x‖ ^ 2 * deriv (deriv G) (‖x‖ ^ 2)
        + 2 * (Module.finrank ℝ E) * deriv G (‖x‖ ^ 2) := by
  have hsnd := fderiv_fderiv_comp_normSq hG
  rw [laplacian_eq_iteratedFDeriv_stdOrthonormalBasis]
  have hterm : ∀ i, iteratedFDeriv ℝ 2 (fun y : E => G (‖y‖ ^ 2)) x
      ![(stdOrthonormalBasis ℝ E) i, (stdOrthonormalBasis ℝ E) i]
      = 2 * deriv G (‖x‖ ^ 2) * ⟪(stdOrthonormalBasis ℝ E) i, (stdOrthonormalBasis ℝ E) i⟫_ℝ
        + 4 * deriv (deriv G) (‖x‖ ^ 2) * (⟪x, (stdOrthonormalBasis ℝ E) i⟫_ℝ
            * ⟪x, (stdOrthonormalBasis ℝ E) i⟫_ℝ) := by
    intro i
    rw [iteratedFDeriv_two_apply, hsnd]
    simp
    ring
  simp only [hterm]
  rw [Finset.sum_add_distrib]
  have h1 : ∑ i, 2 * deriv G (‖x‖ ^ 2)
      * ⟪(stdOrthonormalBasis ℝ E) i, (stdOrthonormalBasis ℝ E) i⟫_ℝ
      = 2 * (Module.finrank ℝ E) * deriv G (‖x‖ ^ 2) := by
    simp [(stdOrthonormalBasis ℝ E).orthonormal.1]
    ring
  have h2 : ∑ i, 4 * deriv (deriv G) (‖x‖ ^ 2) * (⟪x, (stdOrthonormalBasis ℝ E) i⟫_ℝ
      * ⟪x, (stdOrthonormalBasis ℝ E) i⟫_ℝ) = 4 * ‖x‖ ^ 2 * deriv (deriv G) (‖x‖ ^ 2) := by
    rw [← Finset.mul_sum]
    have hsum := (stdOrthonormalBasis ℝ E).sum_inner_mul_inner x x
    simp only [real_inner_comm x] at hsum ⊢
    rw [hsum, real_inner_self_eq_norm_sq]
    ring
  rw [h1, h2]
  ring

/-- The chain rule for `q ↦ g (√q)` at `q = r²`, `r > 0`, to second order. -/
theorem deriv_sqrt_comp {g : ℝ → ℝ} {r : ℝ} (hr : 0 < r) (hg : ContDiffAt ℝ 2 g r) :
    deriv (fun q => g (Real.sqrt q)) (r ^ 2) = deriv g r * (1 / (2 * r)) ∧
    deriv (deriv fun q => g (Real.sqrt q)) (r ^ 2)
      = deriv (deriv g) r * (1 / (2 * r)) * (1 / (2 * r)) + deriv g r * (-(1 / (4 * r ^ 3))) := by
  have hr' : r ≠ 0 := ne_of_gt hr
  have hsq : Real.sqrt (r ^ 2) = r := Real.sqrt_sq hr.le
  have hgev : ∀ᶠ s in nhds r, DifferentiableAt ℝ g s := by
    filter_upwards [hg.eventually (by simp)] with s hs using hs.differentiableAt (by norm_num)
  have hcont' : Tendsto Real.sqrt (nhds (r ^ 2)) (nhds r) := by
    have h := (Real.continuous_sqrt).continuousAt (x := r ^ 2)
    rwa [ContinuousAt, hsq] at h
  have hqev : ∀ᶠ q in nhds (r ^ 2), DifferentiableAt ℝ g (Real.sqrt q) := hcont'.eventually hgev
  have hpos : ∀ᶠ q in nhds (r ^ 2), q ≠ 0 := isOpen_ne.mem_nhds (pow_ne_zero 2 hr')
  have hderiv : (deriv fun q => g (Real.sqrt q)) =ᶠ[nhds (r ^ 2)]
      fun q => deriv g (Real.sqrt q) * (1 / (2 * Real.sqrt q)) := by
    filter_upwards [hqev, hpos] with q hq hq0
    exact (hq.hasDerivAt.comp q (Real.hasDerivAt_sqrt hq0)).deriv
  have hs : HasDerivAt (fun x : ℝ => Real.sqrt x) (1 / (2 * r)) (r ^ 2) := by
    have h := Real.hasDerivAt_sqrt (x := r ^ 2) (pow_ne_zero 2 hr')
    rwa [hsq] at h
  constructor
  · have h := hderiv.self_of_nhds
    simpa [hsq] using h
  · have h1 : HasDerivAt (fun q => deriv g (Real.sqrt q))
        (deriv (deriv g) r * (1 / (2 * r))) (r ^ 2) := by
      have hd : HasDerivAt (deriv g) (deriv (deriv g) r) (Real.sqrt (r ^ 2)) := by
        rw [hsq]; exact (diffAt_deriv_of_contDiffAt_two hg).hasDerivAt
      exact hd.comp (r ^ 2) hs
    have hsinv : HasDerivAt (fun q : ℝ => (Real.sqrt q)⁻¹) (-(1 / (2 * r)) / r ^ 2) (r ^ 2) := by
      have h := hs.inv (by rw [hsq]; exact hr')
      rwa [hsq] at h
    have h2 : HasDerivAt (fun q : ℝ => 1 / (2 * Real.sqrt q)) (-(1 / (4 * r ^ 3))) (r ^ 2) := by
      have h := hsinv.const_mul (1 / 2 : ℝ)
      have hfun : (fun q : ℝ => (1 / 2 : ℝ) * (Real.sqrt q)⁻¹)
          = fun q : ℝ => 1 / (2 * Real.sqrt q) := by
        funext q; rw [one_div, one_div, mul_inv]
      rw [hfun] at h
      convert h using 1 <;> (first | rfl | (field_simp; ring))
    have hprod : HasDerivAt (fun q : ℝ => deriv g (Real.sqrt q) * (1 / (2 * Real.sqrt q)))
        (deriv (deriv g) r * (1 / (2 * r)) * (1 / (2 * Real.sqrt (r ^ 2)))
          + deriv g (Real.sqrt (r ^ 2)) * (-(1 / (4 * r ^ 3)))) (r ^ 2) := h1.mul h2
    rw [hderiv.deriv_eq, hprod.deriv, hsq]

/-- **The Laplacian of a radial function.**  On an `n`-dimensional real inner
product space, for `x ≠ 0` and `g` twice continuously differentiable at `‖x‖`,
`Δ (fun y ↦ g ‖y‖) x = g''(‖x‖) + ((n − 1)/‖x‖) · g'(‖x‖)`. -/
theorem laplacian_radial [FiniteDimensional ℝ E] {g : ℝ → ℝ} {x : E} (hx : x ≠ 0)
    (hg : ContDiffAt ℝ 2 g ‖x‖) :
    (Δ fun y : E => g ‖y‖) x
      = deriv (deriv g) ‖x‖
        + (((Module.finrank ℝ E : ℝ) - 1) / ‖x‖) * deriv g ‖x‖ := by
  have hr : 0 < ‖x‖ := norm_pos_iff.mpr hx
  have hr' : ‖x‖ ≠ 0 := ne_of_gt hr
  have hsq : Real.sqrt (‖x‖ ^ 2) = ‖x‖ := Real.sqrt_sq (norm_nonneg x)
  have hfun : (fun y : E => g ‖y‖) = fun y : E => g (Real.sqrt (‖y‖ ^ 2)) := by
    funext y; rw [Real.sqrt_sq (norm_nonneg y)]
  have hG : ContDiffAt ℝ 2 (fun q => g (Real.sqrt q)) (‖x‖ ^ 2) := by
    have hsqrt : ContDiffAt ℝ 2 (fun q : ℝ => Real.sqrt q) (‖x‖ ^ 2) :=
      Real.contDiffAt_sqrt (pow_ne_zero 2 hr')
    have : ContDiffAt ℝ 2 g (Real.sqrt (‖x‖ ^ 2)) := by rw [hsq]; exact hg
    exact this.comp (‖x‖ ^ 2) hsqrt
  obtain ⟨hd1, hd2⟩ := deriv_sqrt_comp hr hg
  rw [hfun, laplacian_comp_normSq hG, hd1, hd2]
  field_simp
  ring

/-! ## Note 68 in the `s`-wave sector -/

open BookProof.ChapterSphericalBessel BookProof.ChapterSphericalBesselODE

theorem contDiffAt_sbessel_zero {r : ℝ} (hr : r ≠ 0) : ContDiffAt ℝ 2 (sbessel 0) r := by
  have h : ContDiffOn ℝ (⊤ : ℕ∞) (gIter 0) {s : ℝ | s ≠ 0} := contDiffOn_gIter 0
  have hfun : sbessel 0 = gIter 0 := by
    funext s; rw [sbessel_eq]; simp
  have hat : ContDiffAt ℝ (⊤ : ℕ∞) (gIter 0) r :=
    (h.contDiffAt (isOpen_ne.mem_nhds hr))
  rw [hfun]
  exact hat.of_le ENat.LEInfty.out

/-- **Note 68 in the `s`-wave sector.**  On a three-dimensional real inner
product space and away from the origin, the Laplacian of
`u(x⃗) = j₀(p‖x⃗‖) = sin(p‖x⃗‖)/(p‖x⃗‖)` is `−p² u`. -/
theorem laplacian_sbessel_zero [FiniteDimensional ℝ E] (h3 : Module.finrank ℝ E = 3)
    {p : ℝ} {x : E} (hp : p ≠ 0) (hx : x ≠ 0) :
    (Δ fun y : E => sbessel 0 (p * ‖y‖)) x = -(p ^ 2) * sbessel 0 (p * ‖x‖) := by
  have hr : 0 < ‖x‖ := norm_pos_iff.mpr hx
  have hr' : ‖x‖ ≠ 0 := ne_of_gt hr
  have hg : ContDiffAt ℝ 2 (fun s : ℝ => sbessel 0 (p * s)) ‖x‖ := by
    have hmul : ContDiffAt ℝ 2 (fun s : ℝ => p * s) ‖x‖ :=
      (contDiff_const.mul contDiff_id).contDiffAt
    exact (contDiffAt_sbessel_zero (mul_ne_zero hp hr')).comp ‖x‖ hmul
  have hlap := laplacian_radial (g := fun s : ℝ => sbessel 0 (p * s)) hx hg
  rw [h3] at hlap
  have heigen := sbessel_radial_eigen 0 hp hr'
  push_cast at hlap heigen ⊢
  rw [hlap]
  have h2 : deriv (deriv fun s : ℝ => sbessel 0 (p * s)) ‖x‖
      + (2 / ‖x‖) * deriv (fun s : ℝ => sbessel 0 (p * s)) ‖x‖
      = -(p ^ 2) * sbessel 0 (p * ‖x‖) := by
    simp only [zero_add, zero_mul, zero_div, sub_zero, neg_add_rev] at heigen
    linarith [heigen]
  rw [← h2]
  field_simp
  ring

/-- The same statement in the book's form `−∂⃗²u = p²u`. -/
theorem helmholtz_sbessel_zero [FiniteDimensional ℝ E] (h3 : Module.finrank ℝ E = 3)
    {p : ℝ} {x : E} (hp : p ≠ 0) (hx : x ≠ 0) :
    -(Δ fun y : E => sbessel 0 (p * ‖y‖)) x = p ^ 2 * sbessel 0 (p * ‖x‖) := by
  rw [laplacian_sbessel_zero h3 hp hx]
  ring

/-- The same statement on the concrete space `ℝ³` of the book (so the hypothesis
on the dimension is not vacuous). -/
theorem helmholtz_sbessel_zero_euclidean {p : ℝ} {x : EuclideanSpace ℝ (Fin 3)}
    (hp : p ≠ 0) (hx : x ≠ 0) :
    -(Δ fun y : EuclideanSpace ℝ (Fin 3) => sbessel 0 (p * ‖y‖)) x
      = p ^ 2 * sbessel 0 (p * ‖x‖) :=
  helmholtz_sbessel_zero (by simp) hp hx

end BookProof.ChapterRadialLaplacian
