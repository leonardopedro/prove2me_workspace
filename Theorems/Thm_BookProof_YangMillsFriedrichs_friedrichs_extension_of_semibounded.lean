-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.friedrichs_extension_of_semibounded
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavineCore
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

import Mathlib
import BookProof.ChapterFarisLavine
import BookProof.ChapterWeylHamiltonian
import BookProof.ChapterH9

theorem BookProof.YangMillsFriedrichs.friedrichs_extension_of_semibounded {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H) (x y : D) :
    (starRingEnd ℂ) (formInner H y x) = formInner H x y := by
  simp only [formInner, map_add]
  rw [inner_conj_symm]
  congr 1
  rw [← hsym x y, inner_conj_symm]

theorem re_formInner_swap {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H) (x y : D) :
    (formInner H y x).re = (formInner H x y).re := by
  have := congrArg Complex.re (formInner_conj_symm hsym x y)
  simpa using this

/-- The form dominates the ambient norm: `‖x‖² ≤ ‖x‖_H²`. -/
theorem formNormSq_ge_normSq {H : D →ₗ[ℂ] F} (hpos : ∀ x : D, 0 ≤ quadForm H x) (x : D) :
    ‖(x : F)‖ ^ 2 ≤ formNormSq H x := by
  rw [formNormSq_eq]
  linarith [hpos x]

theorem formNormSq_nonneg {H : D →ₗ[ℂ] F} (hpos : ∀ x : D, 0 ≤ quadForm H x) (x : D) :
    0 ≤ formNormSq H x :=
  le_trans (by positivity) (formNormSq_ge_normSq hpos x)

theorem formInner_add_left (H : D →ₗ[ℂ] F) (x y z : D) :
    formInner H (x + y) z = formInner H x z + formInner H y z := by
  simp only [formInner, Submodule.coe_add, inner_add_left]
  ring

theorem formInner_add_right (H : D →ₗ[ℂ] F) (x y z : D) :
    formInner H x (y + z) = formInner H x y + formInner H x z := by
  simp only [formInner, Submodule.coe_add, inner_add_right, map_add]
  ring

theorem formInner_real_smul_left (H : D →ₗ[ℂ] F) (t : ℝ) (x y : D) :
    formInner H ((t : ℂ) • x) y = (t : ℂ) * formInner H x y := by
  simp only [formInner, Submodule.coe_smul, inner_smul_left, Complex.conj_ofReal]
  ring

theorem formInner_real_smul_right (H : D →ₗ[ℂ] F) (t : ℝ) (x y : D) :
    formInner H x ((t : ℂ) • y) = (t : ℂ) * formInner H x y := by
  simp only [formInner, Submodule.coe_smul, inner_smul_right, map_smul]
  ring

/-- Expansion of the form norm of a sum. -/
theorem formNormSq_add {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H) (x y : D) :
    formNormSq H (x + y)
      = formNormSq H x + 2 * (formInner H x y).re + formNormSq H y := by
  simp only [formNormSq, formInner_add_left, formInner_add_right, Complex.add_re]
  rw [re_formInner_swap hsym x y]
  ring

/-- Expansion of the form norm of a difference. -/
theorem formNormSq_sub {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H) (x y : D) :
    formNormSq H (x - y)
      = formNormSq H x - 2 * (formInner H x y).re + formNormSq H y := by
  have h : x - y = x + ((-1 : ℝ) : ℂ) • y := by
    push_cast
    module
  rw [h, formNormSq_add hsym]
  have h1 : formInner H x (((-1 : ℝ) : ℂ) • y) = ((-1 : ℝ) : ℂ) * formInner H x y :=
    formInner_real_smul_right H (-1) x y
  have h2 : formNormSq H (((-1 : ℝ) : ℂ) • y) = formNormSq H y := by
    simp only [formNormSq, formInner_real_smul_left, formInner_real_smul_right]
    push_cast
    ring_nf
  rw [h1, h2]
  push_cast
  simp
  ring

/-- Expansion along a real parameter: `‖x + t y‖_H² = ‖x‖_H² + 2t Re⟪x,y⟫_H +
t²‖y‖_H²`. -/
theorem formNormSq_add_smul {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H) (t : ℝ) (x y : D) :
    formNormSq H (x + (t : ℂ) • y)
      = formNormSq H x + 2 * t * (formInner H x y).re + t ^ 2 * formNormSq H y := by
  rw [formNormSq_add hsym]
  have h1 : formInner H x ((t : ℂ) • y) = (t : ℂ) * formInner H x y :=
    formInner_real_smul_right H t x y
  have h2 : formNormSq H ((t : ℂ) • y) = t ^ 2 * formNormSq H y := by
    simp only [formNormSq, formInner_real_smul_left, formInner_real_smul_right]
    rw [show ((t : ℂ) * ((t : ℂ) * formInner H y y)) = ((t ^ 2 : ℝ) : ℂ) * formInner H y y by
      push_cast; ring, Complex.re_ofReal_mul]
  rw [h1, h2, Complex.mul_re]
  simp
  ring

/-- **Cauchy–Schwarz for the form.** -/
theorem re_formInner_sq_le {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H)
    (hpos : ∀ x : D, 0 ≤ quadForm H x) (x y : D) :
    (formInner H x y).re ^ 2 ≤ formNormSq H x * formNormSq H y := by
  set A := formNormSq H x with hA
  set C := formNormSq H y with hC
  set B := (formInner H x y).re with hB
  have hquad : ∀ t : ℝ, 0 ≤ A + 2 * t * B + t ^ 2 * C := by
    intro t
    rw [← formNormSq_add_smul hsym t x y]
    exact formNormSq_nonneg hpos _
  have hCnn : 0 ≤ C := formNormSq_nonneg hpos y
  rcases eq_or_lt_of_le hCnn with hC0 | hCpos
  · -- `C = 0` forces `B = 0`
    have hB0 : B = 0 := by
      by_contra hBne
      have key := hquad (-(A + 1) / (2 * B))
      rw [← hC0] at key
      have hval : A + 2 * (-(A + 1) / (2 * B)) * B + (-(A + 1) / (2 * B)) ^ 2 * 0 = -1 := by
        field_simp
        ring
      rw [hval] at key
      linarith
    rw [hB0, ← hC0]
    simp
  · have h := hquad (-(B / C))
    have hCne : C ≠ 0 := ne_of_gt hCpos
    field_simp at h
    nlinarith [h, hCpos]

/-- A crude triangle-type bound, used to see that a form-Cauchy sequence has
bounded form norm. -/
theorem formNormSq_add_le {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H)
    (hpos : ∀ x : D, 0 ≤ quadForm H x) (x y : D) :
    formNormSq H (x + y) ≤ 2 * formNormSq H x + 2 * formNormSq H y := by
  have h := formNormSq_sub hsym x y
  have hnn : 0 ≤ formNormSq H (x - y) := formNormSq_nonneg hpos _
  have := formNormSq_add hsym x y
  linarith

/-- **The form of a positive symmetric operator is closable.**  If `xₙ` is Cauchy
for the form norm and tends to `0` in the ambient space, then its form norm tends
to `0`.  This is the analytic heart of the Friedrichs construction: it says the
form closure adds no spurious elements, so the closed form — and with it the
Friedrichs extension — is well defined. -/
theorem form_closable {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H)
    (hpos : ∀ x : D, 0 ≤ quadForm H x) (x : ℕ → D)
    (hCauchy : ∀ ε > 0, ∃ N : ℕ, ∀ p ≥ N, ∀ q ≥ N, formNormSq H (x p - x q) < ε)
    (hzero : Filter.Tendsto (fun n => ((x n : F))) Filter.atTop (nhds 0)) :
    Filter.Tendsto (fun n => formNormSq H (x n)) Filter.atTop (nhds 0) := by
  -- the form norms are bounded
  obtain ⟨N₀, hN₀⟩ := hCauchy 1 one_pos
  set Cbd : ℝ := 2 * 1 + 2 * formNormSq H (x N₀) with hCbd
  have hbdd : ∀ n ≥ N₀, formNormSq H (x n) ≤ Cbd := by
    intro n hn
    have hsplit : x n = (x n - x N₀) + x N₀ := by abel
    have := formNormSq_add_le hsym hpos (x n - x N₀) (x N₀)
    rw [← hsplit] at this
    have h1 : formNormSq H (x n - x N₀) < 1 := hN₀ n hn N₀ le_rfl
    rw [hCbd]
    linarith
  have hCbdnn : 0 ≤ Cbd := by
    have := formNormSq_nonneg hpos (x N₀)
    rw [hCbd]; linarith
  rw [Metric.tendsto_atTop]
  intro ε hε
  -- choose the form-Cauchy threshold
  set δ : ℝ := (ε / 2) ^ 2 / (Cbd + 1) with hδ
  have hδpos : 0 < δ := by
    rw [hδ]; positivity
  obtain ⟨N₁, hN₁⟩ := hCauchy δ hδpos
  refine ⟨max N₀ N₁, fun n hn => ?_⟩
  have hn0 : N₀ ≤ n := le_trans (le_max_left _ _) hn
  have hn1 : N₁ ≤ n := le_trans (le_max_right _ _) hn
  have hnn : 0 ≤ formNormSq H (x n) := formNormSq_nonneg hpos _
  -- the key estimate: `q(xₙ) ≤ ε/2 + Re⟪xₙ, x_m⟫_H` for every large `m`
  have hkey : ∀ m ≥ max N₀ N₁, formNormSq H (x n) - ε / 2 ≤ (formInner H (x n) (x m)).re := by
    intro m hm
    have hm0 : N₀ ≤ m := le_trans (le_max_left _ _) hm
    have hm1 : N₁ ≤ m := le_trans (le_max_right _ _) hm
    have hsplit : formInner H (x n) (x n) = formInner H (x n) (x n - x m)
        + formInner H (x n) (x m) := by
      rw [← formInner_add_right]
      congr 1
      abel
    have hre : formNormSq H (x n)
        = (formInner H (x n) (x n - x m)).re + (formInner H (x n) (x m)).re := by
      simp only [formNormSq, hsplit, Complex.add_re]
    have hCS := re_formInner_sq_le hsym hpos (x n) (x n - x m)
    have hlt : formNormSq H (x n - x m) < δ := hN₁ n hn1 m hm1
    have hbn : formNormSq H (x n) ≤ Cbd := hbdd n hn0
    have hprod : (formInner H (x n) (x n - x m)).re ^ 2 ≤ Cbd * δ := by
      refine le_trans hCS ?_
      have h1 : 0 ≤ formNormSq H (x n - x m) := formNormSq_nonneg hpos _
      nlinarith
    have hεδ : Cbd * δ ≤ (ε / 2) ^ 2 := by
      rw [hδ]
      rw [mul_div_assoc'] at *
      rw [div_le_iff₀ (by linarith : (0:ℝ) < Cbd + 1)]
      nlinarith [sq_nonneg (ε / 2)]
    have habs : |(formInner H (x n) (x n - x m)).re| ≤ ε / 2 := by
      have h2 : (formInner H (x n) (x n - x m)).re ^ 2 ≤ (ε / 2) ^ 2 := le_trans hprod hεδ
      nlinarith [abs_nonneg ((formInner H (x n) (x n - x m)).re),
        sq_abs ((formInner H (x n) (x n - x m)).re), hε]
    rw [hre]
    linarith [(abs_le.mp habs).2]
  -- let `m → ∞`: the right-hand side tends to `0` by symmetry of `H`
  have hlim : Filter.Tendsto (fun m => (formInner H (x n) (x m)).re) Filter.atTop (nhds 0) := by
    have hform : ∀ m, formInner H (x n) (x m)
        = inner ℂ ((x n : F) + H (x n)) ((x m : F)) := by
      intro m
      simp only [formInner, inner_add_left]
      congr 1
      exact (hsym (x n) (x m)).symm
    have hcont : Filter.Tendsto
        (fun m => (inner ℂ ((x n : F) + H (x n)) ((x m : F)) : ℂ)) Filter.atTop (nhds 0) := by
      have hthis := ((innerSL ℂ ((x n : F) + H (x n))).continuous.tendsto 0).comp hzero
      simp at hthis
      refine Filter.Tendsto.congr ?_ hthis
      intro m
      rw [Function.comp_apply]
      simp
    have hthis := (Complex.continuous_re.tendsto 0).comp hcont
    simp at hthis
    refine Filter.Tendsto.congr ?_ hthis
    intro m
    rw [Function.comp_apply, hform]
    simp
  have hle : formNormSq H (x n) - ε / 2 ≤ 0 := by
    refine ge_of_tendsto hlim ?_
    filter_upwards [Filter.eventually_ge_atTop (max N₀ N₁)] with m hm
    exact hkey m hm
  rw [Real.dist_eq, sub_zero, abs_of_nonneg hnn]
  linarith

end Form

/-! ## Part A — the Weyl-gauge Hamiltonian on a domain -/

section Weyl


/-- The **Weyl-gauge Yang–Mills Hamiltonian on a domain**,
`H = ½ Σᵢ πᵢ² + ½ Σₐ Bₐ²`, for electric- and magnetic-field operators that leave
the domain invariant. -/
noncomputable def weylOpDom {n m : ℕ} (pi : Fin n → D →ₗ[ℂ] D) (Bf : Fin m → D →ₗ[ℂ] D) :
    D →ₗ[ℂ] D :=
  (((1 / 2 : ℝ) : ℂ)) • ((∑ i, (pi i).comp (pi i)) + (∑ a, (Bf a).comp (Bf a)))

/-- The Weyl-gauge Hamiltonian, viewed as an operator into the ambient space. -/
noncomputable def weylOp {n m : ℕ} (pi : Fin n → D →ₗ[ℂ] D) (Bf : Fin m → D →ₗ[ℂ] D) :
    D →ₗ[ℂ] F :=
  D.subtype.comp (weylOpDom pi Bf)

theorem weylOp_apply {n m : ℕ} (pi : Fin n → D →ₗ[ℂ] D) (Bf : Fin m → D →ₗ[ℂ] D) (x : D) :
    weylOp pi Bf x
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ i, ((pi i (pi i x) : D) : F)) + ∑ a, ((Bf a (Bf a x) : D) : F)) := by
  simp [weylOp, weylOpDom]

/-- The square of a symmetric operator has quadratic form `‖π x‖²`. -/
theorem inner_sq_eq_normSq {T : D →ₗ[ℂ] D}
    (hT : SymmetricOn D (D.subtype.comp T)) (x : D) :
    (inner ℂ (x : F) ((T (T x) : D) : F) : ℂ) = ((‖((T x : D) : F)‖ ^ 2 : ℝ) : ℂ) := by
  have h := hT x (T x)
  simp only [LinearMap.comp_apply, Submodule.subtype_apply] at h
  rw [← h]
  simp

/-- **The Weyl-gauge Hamiltonian is symmetric on its domain.** -/
theorem weylOpDom_symmetricOn {n m : ℕ} {pi : Fin n → D →ₗ[ℂ] D} {Bf : Fin m → D →ₗ[ℂ] D}
    (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn D (D.subtype.comp (Bf a))) :
    SymmetricOn D (weylOp pi Bf) := by
  intro x y
  have hsq : ∀ (T : D →ₗ[ℂ] D), SymmetricOn D (D.subtype.comp T) →
      (inner ℂ ((T (T x) : D) : F) ((y : D) : F) : ℂ)
        = inner ℂ ((x : D) : F) ((T (T y) : D) : F) := by
    intro T hT
    have h1 := hT (T x) y
    have h2 := hT x (T y)
    simp only [LinearMap.comp_apply, Submodule.subtype_apply] at h1 h2
    rw [h1, h2]
  rw [weylOp_apply, weylOp_apply, inner_smul_left, inner_smul_right, inner_add_left,
    inner_add_right, sum_inner, sum_inner, inner_sum, inner_sum]
  have hpisum : ∀ i : Fin n, (inner ℂ ((pi i (pi i x) : D) : F) ((y : D) : F) : ℂ)
      = inner ℂ ((x : D) : F) ((pi i (pi i y) : D) : F) := fun i => hsq (pi i) (hpi i)
  have hBsum : ∀ a : Fin m, (inner ℂ ((Bf a (Bf a x) : D) : F) ((y : D) : F) : ℂ)
      = inner ℂ ((x : D) : F) ((Bf a (Bf a y) : D) : F) := fun a => hsq (Bf a) (hB a)
  rw [Finset.sum_congr rfl fun i _ => hpisum i, Finset.sum_congr rfl fun a _ => hBsum a,
    Complex.conj_ofReal]

/-- **The quadratic form of the Weyl-gauge Hamiltonian is a sum of squares**:
`q(x) = ½ Σ ‖πᵢ x‖² + ½ Σ ‖Bₐ x‖²`. -/
theorem weylOpDom_quadForm {n m : ℕ} {pi : Fin n → D →ₗ[ℂ] D} {Bf : Fin m → D →ₗ[ℂ] D}
    (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn D (D.subtype.comp (Bf a))) (x : D) :
    quadForm (weylOp pi Bf) x
      = 1 / 2 * (∑ i, ‖((pi i x : D) : F)‖ ^ 2) + 1 / 2 * ∑ a, ‖((Bf a x : D) : F)‖ ^ 2 := by
  have hinner : (inner ℂ ((x : D) : F) (weylOp pi Bf x) : ℂ)
      = (((1 / 2 * (∑ i, ‖((pi i x : D) : F)‖ ^ 2)
          + 1 / 2 * ∑ a, ‖((Bf a x : D) : F)‖ ^ 2 : ℝ)) : ℂ) := by
    rw [weylOp_apply, inner_smul_right, inner_add_right, inner_sum, inner_sum,
      Finset.sum_congr rfl fun i _ => inner_sq_eq_normSq (hpi i) x,
      Finset.sum_congr rfl fun a _ => inner_sq_eq_normSq (hB a) x]
    push_cast
    ring
  rw [quadForm, hinner, Complex.ofReal_re]

/-- **The Weyl-gauge Hamiltonian is semi-bounded** (positive): the hypothesis of
the Friedrichs extension theorem. -/
theorem weylOpDom_quadForm_nonneg {n m : ℕ} {pi : Fin n → D →ₗ[ℂ] D} {Bf : Fin m → D →ₗ[ℂ] D}
    (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn D (D.subtype.comp (Bf a))) (x : D) :
    0 ≤ quadForm (weylOp pi Bf) x := by
  rw [weylOpDom_quadForm hpi hB x]
  positivity

/-- **The Weyl-gauge form is closable** — Part B applied to Part A. -/
theorem weylForm_closable {n m : ℕ} {pi : Fin n → D →ₗ[ℂ] D} {Bf : Fin m → D →ₗ[ℂ] D}
    (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn D (D.subtype.comp (Bf a))) (x : ℕ → D)
    (hCauchy : ∀ ε > 0, ∃ N : ℕ, ∀ p ≥ N, ∀ q ≥ N, formNormSq (weylOp pi Bf) (x p - x q) < ε)
    (hzero : Filter.Tendsto (fun k => ((x k : F))) Filter.atTop (nhds 0)) :
    Filter.Tendsto (fun k => formNormSq (weylOp pi Bf) (x k)) Filter.atTop (nhds 0) :=
  form_closable (weylOpDom_symmetricOn hpi hB) (weylOpDom_quadForm_nonneg hpi hB) x hCauchy hzero

end Weyl

/-! ## Part C — the Friedrichs extension as a named theorem -/

section Friedrichs


/-- The statement "`A` on the domain `Dom` is a positive self-adjoint extension
of `H` on `D`", spelled out: `Dom` contains `D`, `A` agrees with `H` there, `A`
is symmetric and positive, and the adjoint of `A` is `A` itself (every vector
that behaves like a domain vector *is* one). -/
def IsPositiveSelfAdjointExtension {D Dom : Submodule ℂ F} (H : D →ₗ[ℂ] F) (A : Dom →ₗ[ℂ] F) :
    Prop :=
  (∀ x : D, ∃ h : (x : F) ∈ Dom, A ⟨(x : F), h⟩ = H x) ∧ SymmetricOn Dom A ∧
    (∀ y : Dom, 0 ≤ quadForm A y) ∧
    (∀ w u : F, (∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) u) →
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u)

/-- **The Friedrichs extension theorem, as a named hypothesis** (K. Friedrichs,
Math. Ann. **109** (1934) 465–487; Reed–Simon Vol. II, Thm X.23): *a densely
defined symmetric operator that is bounded below admits a canonical positive
self-adjoint extension.*  It enters as an explicit hypothesis, never as an
`axiom`; `friedrichs_hypothesis_satisfiable` shows the hypothesis is consistent.
-/
theorem friedrichs_extension_of_semibounded {D : Submodule ℂ F} (H : D →ₗ[ℂ] F)
    (friedrichs : ∀ (D' : Submodule ℂ F) (H' : D' →ₗ[ℂ] F), Dense (D' : Set F) →
      SymmetricOn D' H' → (∀ x : D', 0 ≤ quadForm H' x) →
      ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsPositiveSelfAdjointExtension H' A) := by sorry
