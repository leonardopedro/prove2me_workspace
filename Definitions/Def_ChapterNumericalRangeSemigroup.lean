import Definitions.Def_ChapterH9
import Mathlib


/-!
# Crouzeix's inequality on a half-plane: the exponential of an operator whose numerical
range has bounded real part

`BookProof.ChapterCrouzeixSelfAdjoint` proves Crouzeix's inequality with constant `1` for
*normal* operators, and `BookProof.ChapterNumericalRangeCrouzeix` proves a Crouzeix-type
inequality for a general non-normal operator whose numerical range lies in a **disc**, with
an explicit (larger) constant.  The general theorem — an arbitrary convex spectral set
containing the numerical range — is still open here.  This file settles another convex
domain, the **half-plane**, for the functions the project actually applies to a generator,
namely the exponentials `f_t(z) = e^{t z}`, and with the optimal constant `1`.

## Results

* `NumReLE A ω` — the numerical range of `A` lies in the half-plane `{Re z ≤ ω}`, written as
  the form inequality `Re ⟪x, A x⟫ ≤ ω ‖x‖²`; `numReLE_iff_numRange_subset` identifies the
  two formulations.
* `hasDerivAt_expApply` — `t ↦ e^{tA} x` is differentiable with derivative `A e^{tA} x`, and
  `hasDerivAt_normSq` — the derivative of `t ↦ ‖e^{tA}x‖²` is `2 Re ⟪e^{tA}x, A e^{tA}x⟫`.
* **`norm_exp_apply_le`** and **`norm_exp_le`** — if `Re ⟪x, A x⟫ ≤ ω ‖x‖²` for all `x`, then
  for every `t ≥ 0` one has `‖e^{tA} x‖ ≤ e^{ωt} ‖x‖`, hence `‖e^{tA}‖ ≤ e^{ωt}`.  The proof
  is the differential inequality: `t ↦ ‖e^{tA}x‖² e^{-2ωt}` has nonpositive derivative.
* `norm_exp_le_one` — the contraction case `ω = 0`: an operator whose numerical range lies in
  the closed left half-plane generates a **contraction semigroup**.
* `norm_cexp_le_of_re_le` — on the half-plane `{Re z ≤ ω}` the supremum of `|e^{tz}|` is
  exactly `e^{ωt}`, so `norm_exp_le` *is* Crouzeix's inequality for these functions and this
  convex domain, with constant `1`.

Everything is `sorry`-free and uses only the standard axioms.
-/

open scoped InnerProductSpace

namespace BookProof.ChapterNumericalRangeSemigroup

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

/-! ## The numerical range in a half-plane -/

/-- The numerical range of `A` lies in the half-plane `{Re z ≤ ω}`. -/
def NumReLE (A : E →L[ℂ] E) (ω : ℝ) : Prop :=
  ∀ x : E, (inner ℂ x (A x) : ℂ).re ≤ ω * ‖x‖ ^ 2



/-! ## Differentiating the exponential -/





/-! ## The growth bound -/









/-! ## The resolvent bound -/

omit [CompleteSpace E] in
/-- A form lower bound `Re ⟪x, S x⟫ ≥ c‖x‖²` bounds `S` below: `c‖x‖ ≤ ‖S x‖`. -/
theorem norm_ge_of_re_inner_ge {S : E →L[ℂ] E} {c : ℝ}
    (h : ∀ x : E, c * ‖x‖ ^ 2 ≤ (inner ℂ x (S x) : ℂ).re) (x : E) : c * ‖x‖ ≤ ‖S x‖ := by
  rcases eq_or_ne x 0 with rfl | hx
  · simp
  · have hpos : 0 < ‖x‖ := norm_pos_iff.mpr hx
    have h1 : c * ‖x‖ ^ 2 ≤ ‖x‖ * ‖S x‖ := le_trans (h x) (by
      simpa using re_inner_le_norm (𝕜 := ℂ) x (S x))
    nlinarith [h1, hpos]

omit [CompleteSpace E] in
/-- Shifting by `z` moves the form bound: `Re ⟪x, (z - A) x⟫ ≥ (Re z - ω)‖x‖²`. -/
theorem re_inner_shift {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) (z : ℂ) (x : E) :
    (z.re - ω) * ‖x‖ ^ 2 ≤ (inner ℂ x ((z • (1 : E →L[ℂ] E) - A) x) : ℂ).re := by
  have hinner : (inner ℂ x ((z • (1 : E →L[ℂ] E) - A) x) : ℂ)
      = z * (inner ℂ x x : ℂ) - (inner ℂ x (A x) : ℂ) := by
    simp
  have hxx : (inner ℂ x x : ℂ) = ((‖x‖ ^ 2 : ℝ) : ℂ) := by
    simp [← Complex.ofReal_pow]
  rw [hinner, hxx]
  have hre : (z * ((‖x‖ ^ 2 : ℝ) : ℂ) - (inner ℂ x (A x) : ℂ)).re
      = z.re * ‖x‖ ^ 2 - (inner ℂ x (A x) : ℂ).re := by
    simp only [Complex.sub_re, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im,
      mul_zero, sub_zero]
  rw [hre]
  have := h x
  linarith

/-- The same bound for the adjoint, because the real part of the form is conjugation
invariant. -/
theorem re_inner_shift_adjoint {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) (z : ℂ) (x : E) :
    (z.re - ω) * ‖x‖ ^ 2
      ≤ (inner ℂ x (ContinuousLinearMap.adjoint (z • (1 : E →L[ℂ] E) - A) x) : ℂ).re := by
  have hadj : (inner ℂ x (ContinuousLinearMap.adjoint (z • (1 : E →L[ℂ] E) - A) x) : ℂ)
      = (inner ℂ ((z • (1 : E →L[ℂ] E) - A) x) x : ℂ) :=
    ContinuousLinearMap.adjoint_inner_right _ x x
  have hconj := inner_conj_symm (𝕜 := ℂ) x ((z • (1 : E →L[ℂ] E) - A) x)
  have hre : (inner ℂ ((z • (1 : E →L[ℂ] E) - A) x) x : ℂ).re
      = (inner ℂ x ((z • (1 : E →L[ℂ] E) - A) x) : ℂ).re := by
    rw [← hconj, Complex.conj_re]
  rw [hadj, hre]
  exact re_inner_shift h z x

omit [CompleteSpace E] in
/-- To the right of the half-plane the shift is injective. -/
theorem shift_ker_eq_bot {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) {z : ℂ} (hz : ω < z.re) :
    ((z • (1 : E →L[ℂ] E) - A) : E →ₗ[ℂ] E).ker = ⊥ := by
  have hlow : ∀ x : E, (z.re - ω) * ‖x‖ ≤ ‖(z • (1 : E →L[ℂ] E) - A) x‖ :=
    norm_ge_of_re_inner_ge (fun x => re_inner_shift h z x)
  rw [LinearMap.ker_eq_bot']
  intro x hx
  have hb := hlow x
  rw [show (z • (1 : E →L[ℂ] E) - A) x = 0 from hx, norm_zero] at hb
  have hx0 : ‖x‖ ≤ 0 := by nlinarith [norm_nonneg x]
  exact norm_eq_zero.mp (le_antisymm hx0 (norm_nonneg x))

/-- To the right of the half-plane the shift is surjective: its range is closed (the shift is
bounded below) and dense (the adjoint is injective). -/
theorem shift_range_eq_top {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) {z : ℂ} (hz : ω < z.re) :
    ((z • (1 : E →L[ℂ] E) - A) : E →ₗ[ℂ] E).range = ⊤ := by
  set T : E →L[ℂ] E := z • (1 : E →L[ℂ] E) - A with hT
  have hc : 0 < z.re - ω := by linarith
  have hlow : ∀ x : E, (z.re - ω) * ‖x‖ ≤ ‖T x‖ :=
    norm_ge_of_re_inner_ge (fun x => re_inner_shift h z x)
  have hlowadj : ∀ x : E, (z.re - ω) * ‖x‖ ≤ ‖ContinuousLinearMap.adjoint T x‖ :=
    norm_ge_of_re_inner_ge (fun x => re_inner_shift_adjoint h z x)
  have hkeradj : ((ContinuousLinearMap.adjoint T : E →L[ℂ] E) : E →ₗ[ℂ] E).ker = ⊥ := by
    rw [LinearMap.ker_eq_bot']
    intro x hx
    have hb := hlowadj x
    rw [show ContinuousLinearMap.adjoint T x = 0 from hx, norm_zero] at hb
    have hx0 : ‖x‖ ≤ 0 := by nlinarith [norm_nonneg x]
    exact norm_eq_zero.mp (le_antisymm hx0 (norm_nonneg x))
  have hanti : AntilipschitzWith ((z.re - ω)⁻¹).toNNReal (T : E → E) := by
    refine AddMonoidHomClass.antilipschitz_of_bound T ?_
    intro x
    have hb := hlow x
    rw [Real.coe_toNNReal _ (by positivity), inv_mul_eq_div, le_div_iff₀ hc]
    linarith [hb]
  have hclosed : IsClosed (Set.range (T : E → E)) :=
    hanti.isClosed_range T.uniformContinuous
  have hcl : IsClosed (((T : E →ₗ[ℂ] E).range : Submodule ℂ E) : Set E) := hclosed
  haveI : CompleteSpace ((T : E →ₗ[ℂ] E).range : Submodule ℂ E) := hcl.completeSpace_coe
  have hperp : ((T : E →ₗ[ℂ] E).range : Submodule ℂ E)ᗮ = ⊥ := by
    rw [T.orthogonal_range]
    exact hkeradj
  have hdd := Submodule.orthogonal_orthogonal ((T : E →ₗ[ℂ] E).range)
  rw [hperp] at hdd
  convert hdd.symm using 1 <;> (first | rfl | simp [hT])icalRangeCrouzeix` proves a Crouzeix-type
inequality for a general non-normal operator whose numerical range lies in a **disc**, with
an explicit (larger) constant.  The general theorem — an arbitrary convex spectral set
containing the numerical range — is still open here.  This file settles another convex
domain, the **half-plane**, for the functions the project actually applies to a generator,
namely the exponentials `f_t(z) = e^{t z}`, and with the optimal constant `1`.

## Results

* `NumReLE A ω` — the numerical range of `A` lies in the half-plane `{Re z ≤ ω}`, written as
  the form inequality `Re ⟪x, A x⟫ ≤ ω ‖x‖²`; `numReLE_iff_numRange_subset` identifies the
  two formulations.
* `hasDerivAt_expApply` — `t ↦ e^{tA} x` is differentiable with derivative `A e^{tA} x`, and
  `hasDerivAt_normSq` — the derivative of `t ↦ ‖e^{tA}x‖²` is `2 Re ⟪e^{tA}x, A e^{tA}x⟫`.
* **`norm_exp_apply_le`** and **`norm_exp_le`** — if `Re ⟪x, A x⟫ ≤ ω ‖x‖²` for all `x`, then
  for every `t ≥ 0` one has `‖e^{tA} x‖ ≤ e^{ωt} ‖x‖`, hence `‖e^{tA}‖ ≤ e^{ωt}`.  The proof
  is the differential inequality: `t ↦ ‖e^{tA}x‖² e^{-2ωt}` has nonpositive derivative.
* `norm_exp_le_one` — the contraction case `ω = 0`: an operator whose numerical range lies in
  the closed left half-plane generates a **contraction semigroup**.
* `norm_cexp_le_of_re_le` — on the half-plane `{Re z ≤ ω}` the supremum of `|e^{tz}|` is
  exactly `e^{ωt}`, so `norm_exp_le` *is* Crouzeix's inequality for these functions and this
  convex domain, with constant `1`.

Everything is `sorry`-free and uses only the standard axioms.
-/

open scoped InnerProductSpace

namespace BookProof.ChapterNumericalRangeSemigroup

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

/-! ## The numerical range in a half-plane -/

/-- The numerical range of `A` lies in the half-plane `{Re z ≤ ω}`. -/
def NumReLE (A : E →L[ℂ] E) (ω : ℝ) : Prop :=
  ∀ x : E, (inner ℂ x (A x) : ℂ).re ≤ ω * ‖x‖ ^ 2

omit [CompleteSpace E] in
theorem numReLE_iff_numRange_subset (A : E →L[ℂ] E) {ω : ℝ} :
    NumReLE A ω ↔ BookProof.ChapterH9.numRange A ⊆ {z : ℂ | z.re ≤ ω} := by
  constructor
  · rintro h z ⟨x, hx, rfl⟩
    have := h x
    rw [hx] at this
    simpa using this
  · intro h x
    rcases eq_or_ne x 0 with rfl | hx
    · simp
    · have hxnorm : ‖x‖ ≠ 0 := norm_ne_zero_iff.mpr hx
      set y : E := (‖x‖ : ℂ)⁻¹ • x with hy
      have hynorm : ‖y‖ = 1 := by
        rw [hy, norm_smul, norm_inv, Complex.norm_real, Real.norm_eq_abs, abs_norm,
          inv_mul_cancel₀ hxnorm]
      have hmem : (inner ℂ y (A y) : ℂ) ∈ BookProof.ChapterH9.numRange A :=
        BookProof.ChapterH9.mem_numRange y hynorm
      have hbound : (inner ℂ y (A y) : ℂ).re ≤ ω := h hmem
      have hexp : (inner ℂ y (A y) : ℂ) = ((‖x‖ : ℂ)⁻¹ * (‖x‖ : ℂ)⁻¹) * inner ℂ x (A x) := by
        rw [hy]
        rw [inner_smul_left, map_smul, inner_smul_right]
        simp [Complex.conj_ofReal]
        ring
      have hpos : (0 : ℝ) < ‖x‖ := norm_pos_iff.mpr hx
      have hre : (inner ℂ y (A y) : ℂ).re = (inner ℂ x (A x) : ℂ).re / ‖x‖ ^ 2 := by
        rw [hexp]
        have : ((‖x‖ : ℂ)⁻¹ * (‖x‖ : ℂ)⁻¹) = (((‖x‖ ^ 2)⁻¹ : ℝ) : ℂ) := by
          push_cast
          rw [sq]
          field_simp
        rw [this, Complex.re_ofReal_mul]
        field_simp
      rw [hre] at hbound
      rw [div_le_iff₀ (by positivity)] at hbound
      linarith [hbound]

/-! ## Differentiating the exponential -/

/-- `t ↦ e^{tA} x` is differentiable with derivative `A e^{tA} x`. -/
theorem hasDerivAt_expApply (A : E →L[ℂ] E) (x : E) (t : ℝ) :
    HasDerivAt (fun s : ℝ => (NormedSpace.exp (s • A)) x) (A (NormedSpace.exp (t • A) x)) t := by
  have h1 : HasDerivAt (fun s : ℝ => NormedSpace.exp (s • A))
      (NormedSpace.exp (t • A) * A) t := hasDerivAt_exp_smul_const A t
  set Φ : (E →L[ℂ] E) →L[ℝ] E :=
    (ContinuousLinearMap.apply ℂ E x).restrictScalars ℝ with hΦ
  have h2 := Φ.hasFDerivAt.comp_hasDerivAt t h1
  have hcomm : NormedSpace.exp (t • A) * A = A * NormedSpace.exp (t • A) := by
    have hc : Commute (t • A) A := (Commute.refl A).smul_left t
    exact hc.exp_left.eq
  convert h2 using 1 <;> (first | rfl | simp [hΦ, hcomm, Function.comp])

/-- The derivative of `t ↦ ‖e^{tA} x‖²` is `2 Re ⟪e^{tA} x, A e^{tA} x⟫`. -/
theorem hasDerivAt_normSq (A : E →L[ℂ] E) (x : E) (t : ℝ) :
    HasDerivAt (fun s : ℝ => ‖(NormedSpace.exp (s • A)) x‖ ^ 2)
      (2 * (inner ℂ (NormedSpace.exp (t • A) x) (A (NormedSpace.exp (t • A) x))).re) t := by
  have hu := hasDerivAt_expApply A x t
  have hinner := hu.inner ℂ hu
  have hre := Complex.reCLM.hasFDerivAt.comp_hasDerivAt t hinner
  have hfun : (fun s : ℝ => (inner ℂ ((NormedSpace.exp (s • A)) x)
      ((NormedSpace.exp (s • A)) x) : ℂ).re)
      = fun s : ℝ => ‖(NormedSpace.exp (s • A)) x‖ ^ 2 := by
    funext s
    simp [← Complex.ofReal_pow]
  have hsym : (inner ℂ (A (NormedSpace.exp (t • A) x)) (NormedSpace.exp (t • A) x) : ℂ).re
      = (inner ℂ (NormedSpace.exp (t • A) x) (A (NormedSpace.exp (t • A) x)) : ℂ).re := by
    have hc := inner_conj_symm (𝕜 := ℂ) (NormedSpace.exp (t • A) x) (A (NormedSpace.exp (t • A) x))
    rw [← hc, Complex.conj_re]
  have hval : (Complex.reCLM ((inner ℂ (NormedSpace.exp (t • A) x)
        (A (NormedSpace.exp (t • A) x)) : ℂ)
      + (inner ℂ (A (NormedSpace.exp (t • A) x)) (NormedSpace.exp (t • A) x) : ℂ)))
      = 2 * (inner ℂ (NormedSpace.exp (t • A) x) (A (NormedSpace.exp (t • A) x)) : ℂ).re := by
    simp only [Complex.reCLM_apply, Complex.add_re, hsym]
    ring
  rw [← hfun]
  convert hre using 1 <;> (first | rfl | simp [hval, Function.comp])

/-! ## The growth bound -/

/-- **Crouzeix's inequality on a half-plane, with constant `1`, for the exponentials.**  If
the numerical range of `A` lies in `{Re z ≤ ω}`, then `‖e^{tA} x‖ ≤ e^{ωt} ‖x‖` for `t ≥ 0`. -/
theorem norm_exp_apply_le {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) (x : E) {t : ℝ}
    (ht : 0 ≤ t) : ‖NormedSpace.exp (t • A) x‖ ≤ Real.exp (ω * t) * ‖x‖ := by
  set g : ℝ → ℝ := fun s => ‖(NormedSpace.exp (s • A)) x‖ ^ 2 * Real.exp (-(2 * ω) * s) with hg
  have hderiv : ∀ s : ℝ, HasDerivAt g
      (2 * (inner ℂ (NormedSpace.exp (s • A) x) (A (NormedSpace.exp (s • A) x))).re
          * Real.exp (-(2 * ω) * s)
        + ‖(NormedSpace.exp (s • A)) x‖ ^ 2 * (Real.exp (-(2 * ω) * s) * -(2 * ω))) s := by
    intro s
    have h1 := hasDerivAt_normSq A x s
    have h2 : HasDerivAt (fun s : ℝ => Real.exp (-(2 * ω) * s))
        (Real.exp (-(2 * ω) * s) * -(2 * ω)) s := by
      simpa using ((hasDerivAt_id s).const_mul (-(2 * ω))).exp
    exact h1.mul h2
  have hnonpos : ∀ s : ℝ, deriv g s ≤ 0 := by
    intro s
    rw [(hderiv s).deriv]
    have hb := h (NormedSpace.exp (s • A) x)
    have hpos : 0 < Real.exp (-(2 * ω) * s) := Real.exp_pos _
    nlinarith [hb, hpos]
  have hdiff : Differentiable ℝ g := fun s => (hderiv s).differentiableAt
  have hanti : Antitone g := antitone_of_deriv_nonpos hdiff hnonpos
  have hle := hanti ht
  simp only [hg] at hle
  have h0 : ‖(NormedSpace.exp ((0 : ℝ) • A)) x‖ ^ 2 * Real.exp (-(2 * ω) * 0) = ‖x‖ ^ 2 := by
    simp
  rw [h0] at hle
  have hexp : 0 < Real.exp (-(2 * ω) * t) := Real.exp_pos _
  have hsq : ‖(NormedSpace.exp (t • A)) x‖ ^ 2 ≤ (Real.exp (ω * t) * ‖x‖) ^ 2 := by
    have hdiv : ‖(NormedSpace.exp (t • A)) x‖ ^ 2 ≤ ‖x‖ ^ 2 / Real.exp (-(2 * ω) * t) := by
      rw [le_div_iff₀ hexp]
      exact hle
    have hone : Real.exp (ω * t) ^ 2 * Real.exp (-(2 * ω) * t) = 1 := by
      rw [sq, ← Real.exp_add, ← Real.exp_add,
        show ω * t + ω * t + -(2 * ω) * t = 0 by ring, Real.exp_zero]
    have hrw : ‖x‖ ^ 2 / Real.exp (-(2 * ω) * t) = (Real.exp (ω * t) * ‖x‖) ^ 2 := by
      rw [div_eq_iff (ne_of_gt hexp), mul_pow]
      nlinarith [hone]
    rw [hrw] at hdiv
    exact hdiv
  have hb : 0 ≤ Real.exp (ω * t) * ‖x‖ := by positivity
  calc ‖(NormedSpace.exp (t • A)) x‖
      = Real.sqrt (‖(NormedSpace.exp (t • A)) x‖ ^ 2) :=
        (Real.sqrt_sq (norm_nonneg _)).symm
    _ ≤ Real.sqrt ((Real.exp (ω * t) * ‖x‖) ^ 2) := Real.sqrt_le_sqrt hsq
    _ = Real.exp (ω * t) * ‖x‖ := Real.sqrt_sq hb

/-- The operator-norm form of the growth bound. -/
theorem norm_exp_le {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) {t : ℝ} (ht : 0 ≤ t) :
    ‖NormedSpace.exp (t • A)‖ ≤ Real.exp (ω * t) :=
  ContinuousLinearMap.opNorm_le_bound _ (Real.exp_pos _).le
    (fun x => norm_exp_apply_le h x ht)

/-- A numerical range in the closed left half-plane generates a **contraction semigroup**. -/
theorem norm_exp_le_one {A : E →L[ℂ] E} (h : NumReLE A 0) {t : ℝ} (ht : 0 ≤ t) :
    ‖NormedSpace.exp (t • A)‖ ≤ 1 := by
  have := norm_exp_le h ht
  simpa using this

/-- On the half-plane `{Re z ≤ ω}` the modulus of `e^{tz}` is at most `e^{ωt}` for `t ≥ 0`:
the bound of `norm_exp_le` is exactly the supremum of the function over the convex domain,
so the constant `1` there is optimal. -/
theorem norm_cexp_le_of_re_le {ω t : ℝ} (ht : 0 ≤ t) {z : ℂ} (hz : z.re ≤ ω) :
    ‖Complex.exp ((t : ℂ) * z)‖ ≤ Real.exp (ω * t) := by
  rw [Complex.norm_exp]
  have : ((t : ℂ) * z).re = t * z.re := by simp
  rw [this]
  exact Real.exp_le_exp.mpr (by nlinarith)

/-! ## The resolvent bound -/

omit [CompleteSpace E] in
/-- A form lower bound `Re ⟪x, S x⟫ ≥ c‖x‖²` bounds `S` below: `c‖x‖ ≤ ‖S x‖`. -/
theorem norm_ge_of_re_inner_ge {S : E →L[ℂ] E} {c : ℝ}
    (h : ∀ x : E, c * ‖x‖ ^ 2 ≤ (inner ℂ x (S x) : ℂ).re) (x : E) : c * ‖x‖ ≤ ‖S x‖ := by
  rcases eq_or_ne x 0 with rfl | hx
  · simp
  · have hpos : 0 < ‖x‖ := norm_pos_iff.mpr hx
    have h1 : c * ‖x‖ ^ 2 ≤ ‖x‖ * ‖S x‖ := le_trans (h x) (by
      simpa using re_inner_le_norm (𝕜 := ℂ) x (S x))
    nlinarith [h1, hpos]

omit [CompleteSpace E] in
/-- Shifting by `z` moves the form bound: `Re ⟪x, (z - A) x⟫ ≥ (Re z - ω)‖x‖²`. -/
theorem re_inner_shift {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) (z : ℂ) (x : E) :
    (z.re - ω) * ‖x‖ ^ 2 ≤ (inner ℂ x ((z • (1 : E →L[ℂ] E) - A) x) : ℂ).re := by
  have hinner : (inner ℂ x ((z • (1 : E →L[ℂ] E) - A) x) : ℂ)
      = z * (inner ℂ x x : ℂ) - (inner ℂ x (A x) : ℂ) := by
    simp
  have hxx : (inner ℂ x x : ℂ) = ((‖x‖ ^ 2 : ℝ) : ℂ) := by
    simp [← Complex.ofReal_pow]
  rw [hinner, hxx]
  have hre : (z * ((‖x‖ ^ 2 : ℝ) : ℂ) - (inner ℂ x (A x) : ℂ)).re
      = z.re * ‖x‖ ^ 2 - (inner ℂ x (A x) : ℂ).re := by
    simp only [Complex.sub_re, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im,
      mul_zero, sub_zero]
  rw [hre]
  have := h x
  linarith

/-- The same bound for the adjoint, because the real part of the form is conjugation
invariant. -/
theorem re_inner_shift_adjoint {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) (z : ℂ) (x : E) :
    (z.re - ω) * ‖x‖ ^ 2
      ≤ (inner ℂ x (ContinuousLinearMap.adjoint (z • (1 : E →L[ℂ] E) - A) x) : ℂ).re := by
  have hadj : (inner ℂ x (ContinuousLinearMap.adjoint (z • (1 : E →L[ℂ] E) - A) x) : ℂ)
      = (inner ℂ ((z • (1 : E →L[ℂ] E) - A) x) x : ℂ) :=
    ContinuousLinearMap.adjoint_inner_right _ x x
  have hconj := inner_conj_symm (𝕜 := ℂ) x ((z • (1 : E →L[ℂ] E) - A) x)
  have hre : (inner ℂ ((z • (1 : E →L[ℂ] E) - A) x) x : ℂ).re
      = (inner ℂ x ((z • (1 : E →L[ℂ] E) - A) x) : ℂ).re := by
    rw [← hconj, Complex.conj_re]
  rw [hadj, hre]
  exact re_inner_shift h z x

omit [CompleteSpace E] in
/-- To the right of the half-plane the shift is injective. -/
theorem shift_ker_eq_bot {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) {z : ℂ} (hz : ω < z.re) :
    ((z • (1 : E →L[ℂ] E) - A) : E →ₗ[ℂ] E).ker = ⊥ := by
  have hlow : ∀ x : E, (z.re - ω) * ‖x‖ ≤ ‖(z • (1 : E →L[ℂ] E) - A) x‖ :=
    norm_ge_of_re_inner_ge (fun x => re_inner_shift h z x)
  rw [LinearMap.ker_eq_bot']
  intro x hx
  have hb := hlow x
  rw [show (z • (1 : E →L[ℂ] E) - A) x = 0 from hx, norm_zero] at hb
  have hx0 : ‖x‖ ≤ 0 := by nlinarith [norm_nonneg x]
  exact norm_eq_zero.mp (le_antisymm hx0 (norm_nonneg x))

/-- To the right of the half-plane the shift is surjective: its range is closed (the shift is
bounded below) and dense (the adjoint is injective). -/
theorem shift_range_eq_top {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) {z : ℂ} (hz : ω < z.re) :
    ((z • (1 : E →L[ℂ] E) - A) : E →ₗ[ℂ] E).range = ⊤ := by
  set T : E →L[ℂ] E := z • (1 : E →L[ℂ] E) - A with hT
  have hc : 0 < z.re - ω := by linarith
  have hlow : ∀ x : E, (z.re - ω) * ‖x‖ ≤ ‖T x‖ :=
    norm_ge_of_re_inner_ge (fun x => re_inner_shift h z x)
  have hlowadj : ∀ x : E, (z.re - ω) * ‖x‖ ≤ ‖ContinuousLinearMap.adjoint T x‖ :=
    norm_ge_of_re_inner_ge (fun x => re_inner_shift_adjoint h z x)
  have hkeradj : ((ContinuousLinearMap.adjoint T : E →L[ℂ] E) : E →ₗ[ℂ] E).ker = ⊥ := by
    rw [LinearMap.ker_eq_bot']
    intro x hx
    have hb := hlowadj x
    rw [show ContinuousLinearMap.adjoint T x = 0 from hx, norm_zero] at hb
    have hx0 : ‖x‖ ≤ 0 := by nlinarith [norm_nonneg x]
    exact norm_eq_zero.mp (le_antisymm hx0 (norm_nonneg x))
  have hanti : AntilipschitzWith ((z.re - ω)⁻¹).toNNReal (T : E → E) := by
    refine AddMonoidHomClass.antilipschitz_of_bound T ?_
    intro x
    have hb := hlow x
    rw [Real.coe_toNNReal _ (by positivity), inv_mul_eq_div, le_div_iff₀ hc]
    linarith [hb]
  have hclosed : IsClosed (Set.range (T : E → E)) :=
    hanti.isClosed_range T.uniformContinuous
  have hcl : IsClosed (((T : E →ₗ[ℂ] E).range : Submodule ℂ E) : Set E) := hclosed
  haveI : CompleteSpace ((T : E →ₗ[ℂ] E).range : Submodule ℂ E) := hcl.completeSpace_coe
  have hperp : ((T : E →ₗ[ℂ] E).range : Submodule ℂ E)ᗮ = ⊥ := by
    rw [T.orthogonal_range]
    exact hkeradj
  have hdd := Submodule.orthogonal_orx` proves a Crouzeix-type
inequality for a general non-normal operator whose numerical range lies in a **disc**, with
an explicit (larger) constant.  The general theorem — an arbitrary convex spectral set
containing the numerical range — is still open here.  This file settles another convex
domain, the **half-plane**, for the functions the project actually applies to a generator,
namely the exponentials `f_t(z) = e^{t z}`, and with the optimal constant `1`.

## Results

* `NumReLE A ω` — the numerical range of `A` lies in the half-plane `{Re z ≤ ω}`, written as
  the form inequality `Re ⟪x, A x⟫ ≤ ω ‖x‖²`; `numReLE_iff_numRange_subset` identifies the
  two formulations.
* `hasDerivAt_expApply` — `t ↦ e^{tA} x` is differentiable with derivative `A e^{tA} x`, and
  `hasDerivAt_normSq` — the derivative of `t ↦ ‖e^{tA}x‖²` is `2 Re ⟪e^{tA}x, A e^{tA}x⟫`.
* **`norm_exp_apply_le`** and **`norm_exp_le`** — if `Re ⟪x, A x⟫ ≤ ω ‖x‖²` for all `x`, then
  for every `t ≥ 0` one has `‖e^{tA} x‖ ≤ e^{ωt} ‖x‖`, hence `‖e^{tA}‖ ≤ e^{ωt}`.  The proof
  is the differential inequality: `t ↦ ‖e^{tA}x‖² e^{-2ωt}` has nonpositive derivative.
* `norm_exp_le_one` — the contraction case `ω = 0`: an operator whose numerical range lies in
  the closed left half-plane generates a **contraction semigroup**.
* `norm_cexp_le_of_re_le` — on the half-plane `{Re z ≤ ω}` the supremum of `|e^{tz}|` is
  exactly `e^{ωt}`, so `norm_exp_le` *is* Crouzeix's inequality for these functions and this
  convex domain, with constant `1`.

Everything is `sorry`-free and uses only the standard axioms.
-/

open scoped InnerProductSpace

namespace BookProof.ChapterNumericalRangeSemigroup

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

/-! ## The numerical range in a half-plane -/

/-- The numerical range of `A` lies in the half-plane `{Re z ≤ ω}`. -/
def NumReLE (A : E →L[ℂ] E) (ω : ℝ) : Prop :=
  ∀ x : E, (inner ℂ x (A x) : ℂ).re ≤ ω * ‖x‖ ^ 2

omit [CompleteSpace E] in
theorem numReLE_iff_numRange_subset (A : E →L[ℂ] E) {ω : ℝ} :
    NumReLE A ω ↔ BookProof.ChapterH9.numRange A ⊆ {z : ℂ | z.re ≤ ω} := by
  constructor
  · rintro h z ⟨x, hx, rfl⟩
    have := h x
    rw [hx] at this
    simpa using this
  · intro h x
    rcases eq_or_ne x 0 with rfl | hx
    · simp
    · have hxnorm : ‖x‖ ≠ 0 := norm_ne_zero_iff.mpr hx
      set y : E := (‖x‖ : ℂ)⁻¹ • x with hy
      have hynorm : ‖y‖ = 1 := by
        rw [hy, norm_smul, norm_inv, Complex.norm_real, Real.norm_eq_abs, abs_norm,
          inv_mul_cancel₀ hxnorm]
      have hmem : (inner ℂ y (A y) : ℂ) ∈ BookProof.ChapterH9.numRange A :=
        BookProof.ChapterH9.mem_numRange y hynorm
      have hbound : (inner ℂ y (A y) : ℂ).re ≤ ω := h hmem
      have hexp : (inner ℂ y (A y) : ℂ) = ((‖x‖ : ℂ)⁻¹ * (‖x‖ : ℂ)⁻¹) * inner ℂ x (A x) := by
        rw [hy]
        rw [inner_smul_left, map_smul, inner_smul_right]
        simp [Complex.conj_ofReal]
        ring
      have hpos : (0 : ℝ) < ‖x‖ := norm_pos_iff.mpr hx
      have hre : (inner ℂ y (A y) : ℂ).re = (inner ℂ x (A x) : ℂ).re / ‖x‖ ^ 2 := by
        rw [hexp]
        have : ((‖x‖ : ℂ)⁻¹ * (‖x‖ : ℂ)⁻¹) = (((‖x‖ ^ 2)⁻¹ : ℝ) : ℂ) := by
          push_cast
          rw [sq]
          field_simp
        rw [this, Complex.re_ofReal_mul]
        field_simp
      rw [hre] at hbound
      rw [div_le_iff₀ (by positivity)] at hbound
      linarith [hbound]

/-! ## Differentiating the exponential -/

/-- `t ↦ e^{tA} x` is differentiable with derivative `A e^{tA} x`. -/
theorem hasDerivAt_expApply (A : E →L[ℂ] E) (x : E) (t : ℝ) :
    HasDerivAt (fun s : ℝ => (NormedSpace.exp (s • A)) x) (A (NormedSpace.exp (t • A) x)) t := by
  have h1 : HasDerivAt (fun s : ℝ => NormedSpace.exp (s • A))
      (NormedSpace.exp (t • A) * A) t := hasDerivAt_exp_smul_const A t
  set Φ : (E →L[ℂ] E) →L[ℝ] E :=
    (ContinuousLinearMap.apply ℂ E x).restrictScalars ℝ with hΦ
  have h2 := Φ.hasFDerivAt.comp_hasDerivAt t h1
  have hcomm : NormedSpace.exp (t • A) * A = A * NormedSpace.exp (t • A) := by
    have hc : Commute (t • A) A := (Commute.refl A).smul_left t
    exact hc.exp_left.eq
  convert h2 using 1 <;> (first | rfl | simp [hΦ, hcomm, Function.comp])

/-- The derivative of `t ↦ ‖e^{tA} x‖²` is `2 Re ⟪e^{tA} x, A e^{tA} x⟫`. -/
theorem hasDerivAt_normSq (A : E →L[ℂ] E) (x : E) (t : ℝ) :
    HasDerivAt (fun s : ℝ => ‖(NormedSpace.exp (s • A)) x‖ ^ 2)
      (2 * (inner ℂ (NormedSpace.exp (t • A) x) (A (NormedSpace.exp (t • A) x))).re) t := by
  have hu := hasDerivAt_expApply A x t
  have hinner := hu.inner ℂ hu
  have hre := Complex.reCLM.hasFDerivAt.comp_hasDerivAt t hinner
  have hfun : (fun s : ℝ => (inner ℂ ((NormedSpace.exp (s • A)) x)
      ((NormedSpace.exp (s • A)) x) : ℂ).re)
      = fun s : ℝ => ‖(NormedSpace.exp (s • A)) x‖ ^ 2 := by
    funext s
    simp [← Complex.ofReal_pow]
  have hsym : (inner ℂ (A (NormedSpace.exp (t • A) x)) (NormedSpace.exp (t • A) x) : ℂ).re
      = (inner ℂ (NormedSpace.exp (t • A) x) (A (NormedSpace.exp (t • A) x)) : ℂ).re := by
    have hc := inner_conj_symm (𝕜 := ℂ) (NormedSpace.exp (t • A) x) (A (NormedSpace.exp (t • A) x))
    rw [← hc, Complex.conj_re]
  have hval : (Complex.reCLM ((inner ℂ (NormedSpace.exp (t • A) x)
        (A (NormedSpace.exp (t • A) x)) : ℂ)
      + (inner ℂ (A (NormedSpace.exp (t • A) x)) (NormedSpace.exp (t • A) x) : ℂ)))
      = 2 * (inner ℂ (NormedSpace.exp (t • A) x) (A (NormedSpace.exp (t • A) x)) : ℂ).re := by
    simp only [Complex.reCLM_apply, Complex.add_re, hsym]
    ring
  rw [← hfun]
  convert hre using 1 <;> (first | rfl | simp [hval, Function.comp])

/-! ## The growth bound -/

/-- **Crouzeix's inequality on a half-plane, with constant `1`, for the exponentials.**  If
the numerical range of `A` lies in `{Re z ≤ ω}`, then `‖e^{tA} x‖ ≤ e^{ωt} ‖x‖` for `t ≥ 0`. -/
theorem norm_exp_apply_le {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) (x : E) {t : ℝ}
    (ht : 0 ≤ t) : ‖NormedSpace.exp (t • A) x‖ ≤ Real.exp (ω * t) * ‖x‖ := by
  set g : ℝ → ℝ := fun s => ‖(NormedSpace.exp (s • A)) x‖ ^ 2 * Real.exp (-(2 * ω) * s) with hg
  have hderiv : ∀ s : ℝ, HasDerivAt g
      (2 * (inner ℂ (NormedSpace.exp (s • A) x) (A (NormedSpace.exp (s • A) x))).re
          * Real.exp (-(2 * ω) * s)
        + ‖(NormedSpace.exp (s • A)) x‖ ^ 2 * (Real.exp (-(2 * ω) * s) * -(2 * ω))) s := by
    intro s
    have h1 := hasDerivAt_normSq A x s
    have h2 : HasDerivAt (fun s : ℝ => Real.exp (-(2 * ω) * s))
        (Real.exp (-(2 * ω) * s) * -(2 * ω)) s := by
      simpa using ((hasDerivAt_id s).const_mul (-(2 * ω))).exp
    exact h1.mul h2
  have hnonpos : ∀ s : ℝ, deriv g s ≤ 0 := by
    intro s
    rw [(hderiv s).deriv]
    have hb := h (NormedSpace.exp (s • A) x)
    have hpos : 0 < Real.exp (-(2 * ω) * s) := Real.exp_pos _
    nlinarith [hb, hpos]
  have hdiff : Differentiable ℝ g := fun s => (hderiv s).differentiableAt
  have hanti : Antitone g := antitone_of_deriv_nonpos hdiff hnonpos
  have hle := hanti ht
  simp only [hg] at hle
  have h0 : ‖(NormedSpace.exp ((0 : ℝ) • A)) x‖ ^ 2 * Real.exp (-(2 * ω) * 0) = ‖x‖ ^ 2 := by
    simp
  rw [h0] at hle
  have hexp : 0 < Real.exp (-(2 * ω) * t) := Real.exp_pos _
  have hsq : ‖(NormedSpace.exp (t • A)) x‖ ^ 2 ≤ (Real.exp (ω * t) * ‖x‖) ^ 2 := by
    have hdiv : ‖(NormedSpace.exp (t • A)) x‖ ^ 2 ≤ ‖x‖ ^ 2 / Real.exp (-(2 * ω) * t) := by
      rw [le_div_iff₀ hexp]
      exact hle
    have hone : Real.exp (ω * t) ^ 2 * Real.exp (-(2 * ω) * t) = 1 := by
      rw [sq, ← Real.exp_add, ← Real.exp_add,
        show ω * t + ω * t + -(2 * ω) * t = 0 by ring, Real.exp_zero]
    have hrw : ‖x‖ ^ 2 / Real.exp (-(2 * ω) * t) = (Real.exp (ω * t) * ‖x‖) ^ 2 := by
      rw [div_eq_iff (ne_of_gt hexp), mul_pow]
      nlinarith [hone]
    rw [hrw] at hdiv
    exact hdiv
  have hb : 0 ≤ Real.exp (ω * t) * ‖x‖ := by positivity
  calc ‖(NormedSpace.exp (t • A)) x‖
      = Real.sqrt (‖(NormedSpace.exp (t • A)) x‖ ^ 2) :=
        (Real.sqrt_sq (norm_nonneg _)).symm
    _ ≤ Real.sqrt ((Real.exp (ω * t) * ‖x‖) ^ 2) := Real.sqrt_le_sqrt hsq
    _ = Real.exp (ω * t) * ‖x‖ := Real.sqrt_sq hb

/-- The operator-norm form of the growth bound. -/
theorem norm_exp_le {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) {t : ℝ} (ht : 0 ≤ t) :
    ‖NormedSpace.exp (t • A)‖ ≤ Real.exp (ω * t) :=
  ContinuousLinearMap.opNorm_le_bound _ (Real.exp_pos _).le
    (fun x => norm_exp_apply_le h x ht)

/-- A numerical range in the closed left half-plane generates a **contraction semigroup**. -/
theorem norm_exp_le_one {A : E →L[ℂ] E} (h : NumReLE A 0) {t : ℝ} (ht : 0 ≤ t) :
    ‖NormedSpace.exp (t • A)‖ ≤ 1 := by
  have := norm_exp_le h ht
  simpa using this

/-- On the half-plane `{Re z ≤ ω}` the modulus of `e^{tz}` is at most `e^{ωt}` for `t ≥ 0`:
the bound of `norm_exp_le` is exactly the supremum of the function over the convex domain,
so the constant `1` there is optimal. -/
theorem norm_cexp_le_of_re_le {ω t : ℝ} (ht : 0 ≤ t) {z : ℂ} (hz : z.re ≤ ω) :
    ‖Complex.exp ((t : ℂ) * z)‖ ≤ Real.exp (ω * t) := by
  rw [Complex.norm_exp]
  have : ((t : ℂ) * z).re = t * z.re := by simp
  rw [this]
  exact Real.exp_le_exp.mpr (by nlinarith)

/-! ## The resolvent bound -/

omit [CompleteSpace E] in
/-- A form lower bound `Re ⟪x, S x⟫ ≥ c‖x‖²` bounds `S` below: `c‖x‖ ≤ ‖S x‖`. -/
theorem norm_ge_of_re_inner_ge {S : E →L[ℂ] E} {c : ℝ}
    (h : ∀ x : E, c * ‖x‖ ^ 2 ≤ (inner ℂ x (S x) : ℂ).re) (x : E) : c * ‖x‖ ≤ ‖S x‖ := by
  rcases eq_or_ne x 0 with rfl | hx
  · simp
  · have hpos : 0 < ‖x‖ := norm_pos_iff.mpr hx
    have h1 : c * ‖x‖ ^ 2 ≤ ‖x‖ * ‖S x‖ := le_trans (h x) (by
      simpa using re_inner_le_norm (𝕜 := ℂ) x (S x))
    nlinarith [h1, hpos]

omit [CompleteSpace E] in
/-- Shifting by `z` moves the form bound: `Re ⟪x, (z - A) x⟫ ≥ (Re z - ω)‖x‖²`. -/
theorem re_inner_shift {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) (z : ℂ) (x : E) :
    (z.re - ω) * ‖x‖ ^ 2 ≤ (inner ℂ x ((z • (1 : E →L[ℂ] E) - A) x) : ℂ).re := by
  have hinner : (inner ℂ x ((z • (1 : E →L[ℂ] E) - A) x) : ℂ)
      = z * (inner ℂ x x : ℂ) - (inner ℂ x (A x) : ℂ) := by
    simp
  have hxx : (inner ℂ x x : ℂ) = ((‖x‖ ^ 2 : ℝ) : ℂ) := by
    simp [← Complex.ofReal_pow]
  rw [hinner, hxx]
  have hre : (z * ((‖x‖ ^ 2 : ℝ) : ℂ) - (inner ℂ x (A x) : ℂ)).re
      = z.re * ‖x‖ ^ 2 - (inner ℂ x (A x) : ℂ).re := by
    simp only [Complex.sub_re, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im,
      mul_zero, sub_zero]
  rw [hre]
  have := h x
  linarith

/-- The same bound for the adjoint, because the real part of the form is conjugation
invariant. -/
theorem re_inner_shift_adjoint {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) (z : ℂ) (x : E) :
    (z.re - ω) * ‖x‖ ^ 2
      ≤ (inner ℂ x (ContinuousLinearMap.adjoint (z • (1 : E →L[ℂ] E) - A) x) : ℂ).re := by
  have hadj : (inner ℂ x (ContinuousLinearMap.adjoint (z • (1 : E →L[ℂ] E) - A) x) : ℂ)
      = (inner ℂ ((z • (1 : E →L[ℂ] E) - A) x) x : ℂ) :=
    ContinuousLinearMap.adjoint_inner_right _ x x
  have hconj := inner_conj_symm (𝕜 := ℂ) x ((z • (1 : E →L[ℂ] E) - A) x)
  have hre : (inner ℂ ((z • (1 : E →L[ℂ] E) - A) x) x : ℂ).re
      = (inner ℂ x ((z • (1 : E →L[ℂ] E) - A) x) : ℂ).re := by
    rw [← hconj, Complex.conj_re]
  rw [hadj, hre]
  exact re_inner_shift h z x

omit [CompleteSpace E] in
/-- To the right of the half-plane the shift is injective. -/
theorem shift_ker_eq_bot {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) {z : ℂ} (hz : ω < z.re) :
    ((z • (1 : E →L[ℂ] E) - A) : E →ₗ[ℂ] E).ker = ⊥ := by
  have hlow : ∀ x : E, (z.re - ω) * ‖x‖ ≤ ‖(z • (1 : E →L[ℂ] E) - A) x‖ :=
    norm_ge_of_re_inner_ge (fun x => re_inner_shift h z x)
  rw [LinearMap.ker_eq_bot']
  intro x hx
  have hb := hlow x
  rw [show (z • (1 : E →L[ℂ] E) - A) x = 0 from hx, norm_zero] at hb
  have hx0 : ‖x‖ ≤ 0 := by nlinarith [norm_nonneg x]
  exact norm_eq_zero.mp (le_antisymm hx0 (norm_nonneg x))

/-- To the right of the half-plane the shift is surjective: its range is closed (the shift is
bounded below) and dense (the adjoint is injective). -/
theorem shift_range_eq_top {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) {z : ℂ} (hz : ω < z.re) :
    ((z • (1 : E →L[ℂ] E) - A) : E →ₗ[ℂ] E).range = ⊤ := by
  set T : E →L[ℂ] E := z • (1 : E →L[ℂ] E) - A with hT
  have hc : 0 < z.re - ω := by linarith
  have hlow : ∀ x : E, (z.re - ω) * ‖x‖ ≤ ‖T x‖ :=
    norm_ge_of_re_inner_ge (fun x => re_inner_shift h z x)
  have hlowadj : ∀ x : E, (z.re - ω) * ‖x‖ ≤ ‖ContinuousLinearMap.adjoint T x‖ :=
    norm_ge_of_re_inner_ge (fun x => re_inner_shift_adjoint h z x)
  have hkeradj : ((ContinuousLinearMap.adjoint T : E →L[ℂ] E) : E →ₗ[ℂ] E).ker = ⊥ := by
    rw [LinearMap.ker_eq_bot']
    intro x hx
    have hb := hlowadj x
    rw [show ContinuousLinearMap.adjoint T x = 0 from hx, norm_zero] at hb
    have hx0 : ‖x‖ ≤ 0 := by nlinarith [norm_nonneg x]
    exact norm_eq_zero.mp (le_antisymm hx0 (norm_nonneg x))
  have hanti : AntilipschitzWith ((z.re - ω)⁻¹).toNNReal (T : E → E) := by
    refine AddMonoidHomClass.antilipschitz_of_bound T ?_
    intro x
    have hb := hlow x
    rw [Real.coe_toNNReal _ (by positivity), inv_mul_eq_div, le_div_iff₀ hc]
    linarith [hb]
  have hclosed : IsClosed (Set.range (T : E → E)) :=
    hanti.isClosed_range T.uniformContinuous
  have hcl : IsClosed (((T : E →ₗ[ℂ] E).range : Submodule ℂ E) : Set E) := hclosed
  haveI : CompleteSpace ((T : E →ₗ[ℂ] E).range : Submodule ℂ E) := hcl.completeSpace_coe
  have hperp : ((T : E →ₗ[ℂ] E).range : Submodule ℂ E)ᗮ = ⊥ := by
    rw [T.orthogonal_range]
    exact hkeradj
  have hdd := Submodule.orthogonal_orthogonal ((T : E →ₗ[ℂ] E).range)
  rw [hperp] at hdd
  convert hdd.symm using 1 <;> (first | rfl | simp [hT])

/-- The resolvent of `A` at a point to the right of the half-plane, as a continuous linear
equivalence. -/
noncomputable def shiftEquiv {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) {z : ℂ}
    (hz : ω < z.re) : E ≃L[ℂ] E :=
  ContinuousLinearEquiv.ofBijective (z • (1 : E →L[ℂ] E) - A)
    (shift_ker_eq_bot h hz) (shift_range_eq_top h hz)



theorem shift_symm_apply {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) {z : ℂ} (hz : ω < z.re)
    (y : E) : (z • (1 : E →L[ℂ] E) - A) ((shiftEquiv h hz).symm y) = y :=
  (shiftEquiv h hz).apply_symm_apply y

/-- **The resolvent estimate.**  If the numerical range of `A` lies in `{Re z ≤ ω}`, then every
`z` with `Re z > ω` is in the resolvent set and `‖(z - A)⁻¹‖ ≤ 1/(Re z - ω)`: the Hille–Yosida
bound matching the growth bound `‖e^{tA}‖ ≤ e^{ωt}`. -/
theorem norm_resolvent_le {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) {z : ℂ} (hz : ω < z.re) :
    ‖((shiftEquiv h hz).symm : E →L[ℂ] E)‖ ≤ (z.re - ω)⁻¹ := by
  have hc : 0 < z.re - ω := by linarith
  have hlow : ∀ x : E, (z.re - ω) * ‖x‖ ≤ ‖(z • (1 : E →L[ℂ] E) - A) x‖ :=
    norm_ge_of_re_inner_ge (fun x => re_inner_shift h z x)
  refine ContinuousLinearMap.opNorm_le_bound _ (by positivity) ?_
  intro y
  have hb := hlow ((shiftEquiv h hz).symm y)
  rw [shift_symm_apply h hz y] at hb
  have heq : ((shiftEquiv h hz).symm : E →L[ℂ] E) y = (shiftEquiv h hz).symm y := rfl
  rw [heq, inv_mul_eq_div, le_div_iff₀ hc]
  linarith [hb]

end BookProof.ChapterNumericalRangeSemigroup
