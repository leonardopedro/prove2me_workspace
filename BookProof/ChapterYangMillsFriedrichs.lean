import Mathlib
import BookProof.ChapterFarisLavine
import BookProof.ChapterWeylHamiltonian
import BookProof.ChapterH9

/-!
# Quantum Yang–Mills: the Weyl-gauge form and its closability (the Friedrichs route)

Source: `book.tex`, chapter *"Quantization due to time-evolution: Yang-Mills and
Classical Statistical Field Theory"*, §*"Pure SU(3) Yang-Mills theory"*
(~7037–7120), and the plan item recorded in `CONSOLIDATED_PLAN.md` §11 (Parts
A–D of the suggested `PLAN_LEAN_SPECIALIST_QYM_FLOW.md`).

In the Weyl gauge and in the Hermite (oscillator) basis the gauge-fixed
Yang–Mills Hamiltonian is a **sum of squares** of the self-adjoint electric-field
operators `πⁱ_a` and magnetic-field operators `B_{i a}`,

  `H = ½ Σ (πⁱ_a)² + ½ Σ (B_{i a})²`,

hence symmetric and bounded below by `0`.  `BookProof.ChapterWeylHamiltonian`
proves this for *bounded* fields; the Friedrichs route needs the same statement
for a **densely defined** operator on a domain, together with the closability of
its quadratic form — that is what this module supplies.

## What is proved here (all `sorry`-free and `axiom`-free)

**Part A — the Weyl-gauge Hamiltonian on a domain.**

* `weylOpDom` — `H = ½ Σ πᵢ² + ½ Σ Bₐ²` as an operator `D →ₗ[ℂ] D`;
* `weylOpDom_symmetricOn` — it is symmetric on `D`;
* `weylOpDom_quadForm` — its quadratic form is the **sum of squares**
  `q(x) = ½ Σ ‖πᵢ x‖² + ½ Σ ‖Bₐ x‖²`;
* `weylOpDom_quadForm_nonneg` — hence `H ≥ 0`: the operator is semi-bounded, the
  hypothesis of the Friedrichs extension theorem.

**Part B — the quadratic form and its closure.**  For an arbitrary symmetric,
positive operator `H` on a domain `D`:

* `formInner`, `formNormSq` — the form inner product `⟪x,y⟫ + ⟪x, H y⟫` and the
  associated form norm;
* `formInner_conj_symm`, `formNormSq_ge_normSq` — it is a Hermitian form
  dominating the ambient norm (`‖x‖² ≤ q(x)`), so it *is* an inner product;
* `formNormSq_add`, `formNormSq_add_le`, `re_formInner_sq_le` — the expansion of
  the form norm and its **Cauchy–Schwarz inequality**;
* `form_closable` — **the headline of Part B.**  *The form is closable*: if a
  sequence is Cauchy in the form norm and tends to `0` in the ambient space, then
  its form norm tends to `0`.  This is exactly the step that makes the
  Friedrichs construction well defined (the form closure has no "ghost"
  elements), and it is where symmetry and positivity of `H` are used;
* `weylForm_closable` — the Weyl-gauge form of Part A is closable.

**Part C — the Friedrichs extension, as a named theorem (never an axiom).**

* `friedrichs_extension_of_semibounded` — the classical theorem (K. Friedrichs,
  *Spektraltheorie halbbeschränkter Operatoren*, Math. Ann. **109** (1934)
  465–487; M. Reed & B. Simon, *Methods of Modern Mathematical Physics* I/II,
  Thm X.23) enters as an explicit hypothesis and is applied to the Weyl-gauge
  operator: a densely defined symmetric positive operator has a self-adjoint
  positive extension.
* `friedrichs_hypothesis_satisfiable` — the named hypothesis is **not vacuous**:
  it holds (with the operator as its own extension) whenever the domain is the
  whole space, which is the bounded Weyl case of
  `BookProof.ChapterWeylHamiltonian`.
* `weyl_friedrichs_extension` — the conclusion for the Weyl-gauge Hamiltonian,
  conditional on that named theorem.

**Part D — the Hashimoto/SIRK limit (research conjecture, recorded not claimed).**

* `weylKrylov_bestApprox_antitone`, `weylKrylov_bestApprox_tendsto_zero` — the
  *proved* supporting facts, specialized to the Weyl-gauge generator: the Krylov
  (Hashimoto order-`n`) best-approximation error is antitone in the order and
  tends to `0` for a cyclic seed;
* the conjecture of `CONSOLIDATED_PLAN.md` §11.2 ("the infinite Hashimoto limit
  selects the Friedrichs extension") is **recorded in prose** in Part D and is
  neither stated as a Lean theorem nor proved: its formalization needs the limit
  operator of the Krylov flag, which is not constructed here.

## Scope

Nothing here claims self-adjointness of the continuum Yang–Mills operator on
`L²(ℝ⁹⁹ × ℤ₂³¹)`, nor a mass gap, nor global existence.  The Millennium problem
is out of scope; the Friedrichs theorem itself is a *hypothesis*, and the
Hashimoto-limit identification is recorded as a conjecture.
-/

namespace BookProof.YangMillsFriedrichs

open BookProof.FarisLavine

/-! ## Part B (general theory) — the form of a positive symmetric operator

We develop the form first, since Part A is an instance of it. -/

section Form

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

/-- The **form inner product** of a positive symmetric operator `H`:
`⟪x, y⟫_H = ⟪x, y⟫ + ⟪x, H y⟫`.  Its completion is the form domain of the
Friedrichs extension. -/
noncomputable def formInner (H : D →ₗ[ℂ] F) (x y : D) : ℂ :=
  inner ℂ (x : F) (y : F) + inner ℂ (x : F) (H y)

/-- The **form norm** squared, `‖x‖_H² = ‖x‖² + ⟪x, H x⟫`. -/
noncomputable def formNormSq (H : D →ₗ[ℂ] F) (x : D) : ℝ := (formInner H x x).re

theorem formNormSq_eq (H : D →ₗ[ℂ] F) (x : D) :
    formNormSq H x = ‖(x : F)‖ ^ 2 + quadForm H x := by
  have h : (inner ℂ (x : F) (x : F) : ℂ).re = ‖(x : F)‖ ^ 2 := by
    simpa using inner_self_eq_norm_sq (𝕜 := ℂ) (x : F)
  simp only [formNormSq, formInner, Complex.add_re, quadForm, h]

/-- The form is **Hermitian** when `H` is symmetric. -/
theorem formInner_conj_symm {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H) (x y : D) :
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
      have := ((innerSL ℂ ((x n : F) + H (x n))).continuous.tendsto 0).comp hzero
      simpa using this
    have := (Complex.continuous_re.tendsto 0).comp hcont
    simpa [hform] using this
  have hle : formNormSq H (x n) - ε / 2 ≤ 0 := by
    refine ge_of_tendsto hlim ?_
    filter_upwards [Filter.eventually_ge_atTop (max N₀ N₁)] with m hm
    exact hkey m hm
  rw [Real.dist_eq, sub_zero, abs_of_nonneg hnn]
  linarith

end Form

/-! ## Part A — the Weyl-gauge Hamiltonian on a domain -/

section Weyl

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

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

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

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
      ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsPositiveSelfAdjointExtension H' A)
    (hdense : Dense (D : Set F)) (hsym : SymmetricOn D H)
    (hpos : ∀ x : D, 0 ≤ quadForm H x) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsPositiveSelfAdjointExtension H A :=
  friedrichs D H hdense hsym hpos

/-- **The named hypothesis is satisfiable.**  For an operator already defined on
the whole space — the bounded Weyl-gauge case of
`BookProof.ChapterWeylHamiltonian` — the operator is its own positive
self-adjoint extension. -/
theorem friedrichs_hypothesis_satisfiable (H : (⊤ : Submodule ℂ F) →ₗ[ℂ] F)
    (hsym : SymmetricOn (⊤ : Submodule ℂ F) H)
    (hpos : ∀ x : (⊤ : Submodule ℂ F), 0 ≤ quadForm H x) :
    IsPositiveSelfAdjointExtension H H := by
  refine ⟨fun x => ⟨trivial, by congr⟩, hsym, hpos, fun w u hw => ⟨trivial, ?_⟩⟩
  have hzero : ∀ v : (⊤ : Submodule ℂ F), (inner ℂ (v : F) (H ⟨w, trivial⟩ - u) : ℂ) = 0 := by
    intro v
    rw [inner_sub_right, ← hw v, ← hsym v ⟨w, trivial⟩]
    ring
  have hd : (inner ℂ (H ⟨w, trivial⟩ - u) (H ⟨w, trivial⟩ - u) : ℂ) = 0 :=
    hzero ⟨H ⟨w, trivial⟩ - u, trivial⟩
  exact sub_eq_zero.mp (inner_self_eq_zero.mp hd)

/-- **The Weyl-gauge Hamiltonian has a positive self-adjoint (Friedrichs)
extension**, conditional on the named theorem above.  Nothing is claimed about
the continuum operator beyond that conditional. -/
theorem weyl_friedrichs_extension {D : Submodule ℂ F} {n m : ℕ}
    {pi : Fin n → D →ₗ[ℂ] D} {Bf : Fin m → D →ₗ[ℂ] D}
    (friedrichs : ∀ (D' : Submodule ℂ F) (H' : D' →ₗ[ℂ] F), Dense (D' : Set F) →
      SymmetricOn D' H' → (∀ x : D', 0 ≤ quadForm H' x) →
      ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsPositiveSelfAdjointExtension H' A)
    (hdense : Dense (D : Set F))
    (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn D (D.subtype.comp (Bf a))) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F),
      IsPositiveSelfAdjointExtension (weylOp pi Bf) A :=
  friedrichs_extension_of_semibounded (weylOp pi Bf) friedrichs hdense
    (weylOpDom_symmetricOn hpi hB) (weylOpDom_quadForm_nonneg hpi hB)

end Friedrichs

/-! ## Part D — the Hashimoto/SIRK limit: proved supporting facts, and the
conjecture written down -/

section Sirk

open BookProof.ChapterH5 BookProof.ChapterH9

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- The Hashimoto/SIRK order-`n` approximation error for the Weyl-gauge generator
is **antitone in the order** (proved, `BookProof.ChapterH9`). -/
theorem weylKrylov_bestApprox_antitone (H : E →ₗ[ℂ] E) (v : E) {p q : ℕ} (hpq : p ≤ q) (u : E) :
    ‖u - (krylovSpan H v q).starProjection u‖ ≤ ‖u - (krylovSpan H v p).starProjection u‖ :=
  krylov_bestApprox_antitone H v hpq u

/-- For a cyclic seed the Hashimoto/SIRK approximation error **tends to zero**
(proved, `BookProof.ChapterH9`).  This is the supporting fact behind the
uniqueness claim of `CONSOLIDATED_PLAN.md` §11.2 — it does *not* by itself
identify the limit operator. -/
theorem weylKrylov_bestApprox_tendsto_zero (H : E →ₗ[ℂ] E) (v u : E)
    (hdense : Dense ((⨆ k : ℕ, krylovSpan H v k : Submodule ℂ E) : Set E)) :
    Filter.Tendsto (fun k : ℕ => ‖u - (krylovSpan H v k).starProjection u‖)
      Filter.atTop (nhds 0) :=
  krylov_bestApprox_tendsto_zero H v u hdense

/- **The conjecture of `CONSOLIDATED_PLAN.md` §11.2 — recorded, not stated as a
Lean theorem.**  *The operator recovered in the infinite Hashimoto/SIRK limit is
the Friedrichs extension.*  Formalizing it requires the limit operator of the
Krylov flag, which is exactly the piece that is not constructed here; the two
theorems above are the proved facts that support it (nesting and, for a cyclic
seed, convergence of the best-approximation error).  It is deliberately not
written as a Lean statement, because every naive rendering of it is either
trivially true (all extensions agree on the original domain by definition) or
requires the unformalized limit. -/

end Sirk

end BookProof.YangMillsFriedrichs
