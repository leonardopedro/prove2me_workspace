import Mathlib
import BookProof.ChapterHyperbolicQuadraticEsa
import BookProof.ChapterKatoRellichRelative
import BookProof.ChapterYangMillsHermite

/-!
# Relatively bounded (unbounded) perturbations of the diagonal quadratic Hamiltonian

`BookProof.ChapterHyperbolicQuadraticEsa` proves that
`H_c = ∑ᵢ cᵢ(−∂ᵢ² + xᵢ²/4)` is essentially self-adjoint on the Gauss–polynomial
(product Hermite) core of `L²(ℝᵈ)` for *every* real weight vector `c`, and widens the
potential class by a **bounded** real multiplier (Kato–Rellich).  This module widens it by
an **unbounded** perturbation, in the elliptic case `cᵢ ≥ c₀ > 0`:

* `posL`, `momL`, `oscL` — the position `xᵢ`, the momentum `πᵢ = −i∂ᵢ` and the
  one-coordinate oscillator `πᵢ² + xᵢ²/4`, as operators from the core into `L²`;
* `posL_symmetric`, `momL_symmetric` — both are symmetric on the core (Gaussian
  integration by parts, through `BookProof.YangMillsHermite.PolySym`);
* `inner_oscL_eq` — the form identity `⟪u, (πᵢ² + xᵢ²/4)u⟫ = ‖πᵢu‖² + ‖xᵢu‖²/4`;
* `re_inner_oscL_le_quadOp` — for weights `cᵢ ≥ c₀ > 0` the oscillator form of a single
  coordinate is dominated by the form of `H_c`: `c₀⟪u, oscᵢ u⟫ ≤ ⟪u, H_c u⟫` (the symbols
  satisfy `c₀(αᵢ + ½) ≤ ∑ⱼ cⱼ(αⱼ + ½)`);
* `norm_posL_le`, `norm_momL_le` — consequently `xᵢ` and `πᵢ` are `H_c`-bounded with
  *arbitrarily small* relative bound: `‖xᵢu‖ ≤ ε‖H_c u‖ + (2/(c₀ε))‖u‖`, and the same for
  `πᵢ`;
* HEADLINE `quadOp_add_firstOrder_essentiallySelfAdjoint` — therefore `H_c + B` is
  essentially self-adjoint on the same core for every **first-order** perturbation
  `B = ∑ᵢ (bᵢ xᵢ + b'ᵢ πᵢ)` with real coefficients.  The perturbation is genuinely
  unbounded, so this is outside the reach of the bounded Kato–Rellich statement;
* `hermiteMvBasis_repr_quadOp` — the product Hermite basis *is* a diagonalizing unitary
  for `H_c`: in those coordinates the operator is multiplication by the real symbol
  `∑ᵢ cᵢ(αᵢ + ½)`;
* `harmonicOsc_add_linearPotential_essentiallySelfAdjoint` and
  `foOp_linear_apply_eq_mul` — the physical corollary: the Stark-shifted oscillator
  `−Δ + ‖x‖²/4 + ⟨b, x⟩` (a harmonic oscillator in a constant external field) is
  essentially self-adjoint on the Hermite core, the perturbation being multiplication by
  the unbounded real function `x ↦ ⟨b, x⟩`.

Two general instruments are proved on the way and are reusable: `apply_sum_of_diagonal`
and `re_inner_diagonal_le` — a diagonal operator with a real symbol acts on a finite
combination of the diagonalizing vectors coefficientwise, and the quadratic forms of two
diagonal operators are ordered by their symbols.

## Honest boundary

The strict positivity `cᵢ ≥ c₀ > 0` is used, and is not removable by this argument: in
the hyperbolic (mixed sign) case the symbol `∑ⱼ cⱼ(αⱼ + ½)` vanishes on an infinite set of
multi-indices, so `H_c` does not dominate the number operator and no relative bound of the
above kind can hold.  The general Faris–Lavine potential (bounded above by a quadratic)
therefore stays open, as recorded in `CONSOLIDATED_PLAN.md`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.HermiteRelative

open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

/-! ## Instruments: diagonal operators on an orthonormal family -/

section Diagonal

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}

/-- A diagonal operator acts coefficientwise on a finite combination of the
diagonalizing vectors. -/
theorem apply_sum_of_diagonal (v : ι → E) (lam : ι → ℝ) {D : Submodule ℂ E}
    (hvD : ∀ a, v a ∈ D) (T : D →ₗ[ℂ] E)
    (hT : ∀ (a : ι) (h : v a ∈ D), T ⟨v a, h⟩ = ((lam a : ℝ) : ℂ) • v a)
    (s : Finset ι) (f : ι → ℂ) :
    ∀ hu : (∑ a ∈ s, f a • v a) ∈ D,
      T ⟨∑ a ∈ s, f a • v a, hu⟩ = ∑ a ∈ s, (((lam a : ℝ) : ℂ) * f a) • v a := by
  classical
  induction s using Finset.induction with
  | empty =>
      intro hu
      have h0 : (⟨∑ a ∈ (∅ : Finset ι), f a • v a, hu⟩ : D) = 0 := Subtype.ext (by simp)
      rw [h0, map_zero, Finset.sum_empty]
  | insert a s ha ih =>
      intro hu
      have hva : f a • v a ∈ D := Submodule.smul_mem _ _ (hvD a)
      have hs : (∑ b ∈ s, f b • v b) ∈ D :=
        Submodule.sum_mem _ fun b _ => Submodule.smul_mem _ _ (hvD b)
      have hsplit : (⟨∑ b ∈ insert a s, f b • v b, hu⟩ : D)
          = ⟨f a • v a, hva⟩ + ⟨∑ b ∈ s, f b • v b, hs⟩ := by
        apply Subtype.ext
        simpa using Finset.sum_insert ha
      have hsm : (⟨f a • v a, hva⟩ : D) = f a • ⟨v a, hvD a⟩ := Subtype.ext rfl
      rw [hsplit, map_add, hsm, map_smul, hT a (hvD a), ih hs, Finset.sum_insert ha, smul_smul,
        mul_comm (f a)]

/-- The quadratic form of a diagonal operator, on a finite combination of the
diagonalizing vectors. -/
theorem re_inner_sum_of_diagonal (v : ι → E) (hv : Orthonormal ℂ v) (lam : ι → ℝ)
    {D : Submodule ℂ E} (hvD : ∀ a, v a ∈ D) (T : D →ₗ[ℂ] E)
    (hT : ∀ (a : ι) (h : v a ∈ D), T ⟨v a, h⟩ = ((lam a : ℝ) : ℂ) • v a)
    (s : Finset ι) (f : ι → ℂ) (hu : (∑ a ∈ s, f a • v a) ∈ D) :
    (inner ℂ (∑ a ∈ s, f a • v a) (T ⟨∑ a ∈ s, f a • v a, hu⟩) : ℂ).re
      = ∑ a ∈ s, lam a * ‖f a‖ ^ 2 := by
  rw [apply_sum_of_diagonal v lam hvD T hT s f hu,
    hv.inner_sum f (fun a => ((lam a : ℝ) : ℂ) * f a) s, Complex.re_sum]
  refine Finset.sum_congr rfl fun a _ => ?_
  have h : (starRingEnd ℂ) (f a) * (((lam a : ℝ) : ℂ) * f a)
      = ((lam a : ℝ) : ℂ) * (f a * (starRingEnd ℂ) (f a)) := by ring
  rw [h, Complex.mul_conj, ← Complex.ofReal_mul, Complex.ofReal_re, Complex.normSq_eq_norm_sq]

/-- **Comparison of two diagonal quadratic forms**: if the symbols are ordered pointwise
then so are the forms. -/
theorem re_inner_diagonal_le (v : ι → E) (hv : Orthonormal ℂ v) (lam mu : ι → ℝ)
    {D : Submodule ℂ E} (hD : Submodule.span ℂ (Set.range v) = D)
    (S T : D →ₗ[ℂ] E)
    (hS : ∀ (a : ι) (h : v a ∈ D), S ⟨v a, h⟩ = ((lam a : ℝ) : ℂ) • v a)
    (hT : ∀ (a : ι) (h : v a ∈ D), T ⟨v a, h⟩ = ((mu a : ℝ) : ℂ) • v a)
    (hle : ∀ a, lam a ≤ mu a) (u : D) :
    (inner ℂ (u : E) (S u) : ℂ).re ≤ (inner ℂ (u : E) (T u) : ℂ).re := by
  classical
  have hvD : ∀ a, v a ∈ D := fun a => hD ▸ Submodule.subset_span ⟨a, rfl⟩
  have hmem : (u : E) ∈ Submodule.span ℂ (Set.range v) := hD ▸ u.2
  obtain ⟨f, hf⟩ := Finsupp.mem_span_range_iff_exists_finsupp.mp hmem
  have hfu : ∑ a ∈ f.support, f a • v a = (u : E) := hf
  have husub : u = ⟨∑ a ∈ f.support, f a • v a, hfu ▸ u.2⟩ := Subtype.ext hfu.symm
  have hS' := re_inner_sum_of_diagonal v hv lam hvD S hS f.support f (hfu ▸ u.2)
  have hT' := re_inner_sum_of_diagonal v hv mu hvD T hT f.support f (hfu ▸ u.2)
  rw [husub, hS', hT']
  exact Finset.sum_le_sum fun a _ => by nlinarith [sq_nonneg ‖f a‖, hle a]

end Diagonal

variable {d : ℕ}

/-! ## The canonical pair and the one-coordinate oscillator on the core -/

theorem coreOp_apply' (T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
    (x : polyGaussCore (d := d)) : coreOp T x = coreEquiv (T (coreEquiv.symm x)) := rfl

theorem coreOp_add (S T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) :
    coreOp (S + T) = coreOp S + coreOp T := by
  refine LinearMap.ext fun x => ?_
  simp [coreOp_apply']

theorem coreOp_smul (r : ℂ) (T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) :
    coreOp (r • T) = r • coreOp T := by
  refine LinearMap.ext fun x => ?_
  simp [coreOp_apply']

theorem coreOp_sum {ι : Type*} (s : Finset ι)
    (T : ι → MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) :
    coreOp (∑ i ∈ s, T i) = ∑ i ∈ s, coreOp (T i) := by
  classical
  induction s using Finset.induction with
  | empty => refine LinearMap.ext fun x => ?_; simp [coreOp_apply']
  | insert i s hi ih => rw [Finset.sum_insert hi, coreOp_add, ih, Finset.sum_insert hi]

theorem coreOp_comp (S T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) :
    coreOp (S.comp T) = (coreOp S).comp (coreOp T) := by
  refine LinearMap.ext fun x => ?_
  simp [coreOp_apply']

/-- The position operator `xᵢ` as a map from the core into `L²`. -/
def posL (i : Fin d) : (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  (polyGaussCore (d := d)).subtype ∘ₗ coreOp (mulXPoly i)

/-- The momentum operator `πᵢ = −i∂ᵢ` as a map from the core into `L²`. -/
def momL (i : Fin d) : (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  (polyGaussCore (d := d)).subtype ∘ₗ coreOp (momPoly i)

/-- The one-coordinate oscillator `πᵢ² + xᵢ²/4` as a map from the core into `L²`. -/
def oscL (i : Fin d) : (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  (polyGaussCore (d := d)).subtype ∘ₗ coreOp (oscPoly i)

/-! ### Symmetry, by Gaussian integration by parts -/

theorem mulXPoly_eq_mulOp (i : Fin d) :
    mulXPoly i = BookProof.YangMillsHermite.mulOp (X i : MvPolynomial (Fin d) ℂ) := by
  refine LinearMap.ext fun p => ?_
  simp [BookProof.YangMillsHermite.mulOp]

theorem momPoly_eq_ymMomOp (i : Fin d) :
    momPoly i = BookProof.YangMillsHermite.momOp i := by
  refine LinearMap.ext fun p => ?_
  rw [momPoly_apply, BookProof.YangMillsHermite.momOp_apply]
  rw [MvPolynomial.smul_eq_C_mul, MvPolynomial.smul_eq_C_mul]
  push_cast
  ring

theorem polySym_mulXPoly (i : Fin d) : BookProof.YangMillsHermite.PolySym (mulXPoly i) := by
  rw [mulXPoly_eq_mulOp]
  exact BookProof.YangMillsHermite.mulOp_polySym (BookProof.YangMillsHermite.realCoeff_X i)

theorem polySym_momPoly (i : Fin d) : BookProof.YangMillsHermite.PolySym (momPoly i) := by
  rw [momPoly_eq_ymMomOp]
  exact BookProof.YangMillsHermite.momOp_polySym i

set_option maxHeartbeats 1000000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
/-- A Gauss-symmetric polynomial operator transports to a symmetric operator on the
core. -/
theorem symmetricOn_of_polySym {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (hT : BookProof.YangMillsHermite.PolySym T) :
    SymmetricOn (polyGaussCore (d := d))
      ((polyGaussCore (d := d)).subtype ∘ₗ coreOp T) := by
  intro x y
  obtain ⟨p, rfl⟩ : ∃ p, (coreEquiv (d := d)) p = x :=
    ⟨coreEquiv.symm x, coreEquiv.apply_symm_apply x⟩
  obtain ⟨q, rfl⟩ : ∃ q, (coreEquiv (d := d)) q = y :=
    ⟨coreEquiv.symm y, coreEquiv.apply_symm_apply y⟩
  have hx : (((polyGaussCore (d := d)).subtype ∘ₗ coreOp T) (coreEquiv p)) = pgLp (T p) :=
    coreOp_coe T p
  have hy : (((polyGaussCore (d := d)).subtype ∘ₗ coreOp T) (coreEquiv q)) = pgLp (T q) :=
    coreOp_coe T q
  rw [hx, hy, coreEquiv_coe, coreEquiv_coe, BookProof.YangMillsHermite.inner_pgLp_pgLp,
    BookProof.YangMillsHermite.inner_pgLp_pgLp]
  exact hT p q

set_option maxHeartbeats 1000000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
/-- **The position operator is symmetric on the core.** -/
theorem posL_symmetric (i : Fin d) : SymmetricOn (polyGaussCore (d := d)) (posL i) :=
  symmetricOn_of_polySym (polySym_mulXPoly i)

set_option maxHeartbeats 1000000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
/-- **The momentum operator is symmetric on the core** — Gaussian integration by parts. -/
theorem momL_symmetric (i : Fin d) : SymmetricOn (polyGaussCore (d := d)) (momL i) :=
  symmetricOn_of_polySym (polySym_momPoly i)

/-! ### The oscillator form -/

set_option maxHeartbeats 1000000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
theorem oscOp_eq (i : Fin d) :
    coreOp (oscPoly i) = (coreOp (momPoly i)).comp (coreOp (momPoly i))
      + (1/4 : ℂ) • ((coreOp (mulXPoly i)).comp (coreOp (mulXPoly i))) := by
  rw [oscPoly, coreOp_add, coreOp_comp, coreOp_smul, coreOp_comp]

set_option maxHeartbeats 1000000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
/-- **The form identity** `⟪u, (πᵢ² + xᵢ²/4)u⟫ = ‖πᵢu‖² + ‖xᵢu‖²/4`. -/
theorem re_inner_oscL_eq (i : Fin d) (u : polyGaussCore (d := d)) :
    (inner ℂ (u : L2d d) (oscL i u) : ℂ).re
      = ‖momL i u‖ ^ 2 + ‖posL i u‖ ^ 2 / 4 := by
  have hosc : oscL i u
      = momL i (coreOp (momPoly i) u) + (1/4 : ℂ) • posL i (coreOp (mulXPoly i) u) := by
    simp [oscL, momL, posL, oscOp_eq]
  have hmom : (inner ℂ (u : L2d d) (momL i (coreOp (momPoly i) u)) : ℂ)
      = inner ℂ (momL i u) (momL i u) := by
    have h := momL_symmetric i u (coreOp (momPoly i) u)
    simpa [momL] using h.symm
  have hpos : (inner ℂ (u : L2d d) (posL i (coreOp (mulXPoly i) u)) : ℂ)
      = inner ℂ (posL i u) (posL i u) := by
    have h := posL_symmetric i u (coreOp (mulXPoly i) u)
    simpa [posL] using h.symm
  rw [hosc, inner_add_right, inner_smul_right, hmom, hpos,
    inner_self_eq_norm_sq_to_K, inner_self_eq_norm_sq_to_K]
  simp [← Complex.ofReal_pow]
  ring

/-! ### The diagonal action of the oscillator and of `H_c` -/

set_option maxHeartbeats 1000000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
theorem oscL_hermiteMvLp (i : Fin d) (a : Fin d →₀ ℕ)
    (h : hermiteMvLp a ∈ polyGaussCore (d := d)) :
    oscL i ⟨hermiteMvLp a, h⟩ = (((a i : ℝ) + 1/2 : ℝ) : ℂ) • hermiteMvLp a := by
  have hcoe : (⟨hermiteMvLp a, h⟩ : polyGaussCore (d := d))
      = coreEquiv (((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • hermiteMv a) := by
    apply Subtype.ext
    rw [coreEquiv_coe, pgLp_hermiteMvLp]
  rw [hcoe]
  simp only [oscL, LinearMap.comp_apply, Submodule.subtype_apply]
  rw [coreOp_coe, map_smul, oscPoly_hermiteMv, ← smul_assoc, smul_eq_mul, mul_comm,
    ← smul_eq_mul, smul_assoc, pgLp_smul, pgLp_hermiteMvLp]
  push_cast
  ring_nf

set_option maxHeartbeats 1000000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
/-- For weights bounded below by `c₀ > 0`, the oscillator form of one coordinate is
dominated by the form of `H_c`. -/
theorem re_inner_oscL_le_quadOp (c : Fin d → ℝ) {c0 : ℝ} (hc0 : 0 < c0) (hc : ∀ i, c0 ≤ c i)
    (i : Fin d) (u : polyGaussCore (d := d)) :
    c0 * (inner ℂ (u : L2d d) (oscL i u) : ℂ).re
      ≤ (inner ℂ (u : L2d d) (quadOp c u) : ℂ).re := by
  classical
  have hsymb : ∀ a : Fin d →₀ ℕ, c0 * ((a i : ℝ) + 1/2) ≤ quadSymbol c a := by
    intro a
    have hterms : ∀ j ∈ (Finset.univ : Finset (Fin d)), 0 ≤ c j * ((a j : ℝ) + 1/2) := by
      intro j _
      have : (0 : ℝ) ≤ c j := le_trans hc0.le (hc j)
      positivity
    have hle : c0 * ((a i : ℝ) + 1/2) ≤ c i * ((a i : ℝ) + 1/2) := by
      have hpos : (0 : ℝ) ≤ (a i : ℝ) + 1/2 := by positivity
      exact mul_le_mul_of_nonneg_right (hc i) hpos
    have hsum : c i * ((a i : ℝ) + 1/2) ≤ ∑ j, c j * ((a j : ℝ) + 1/2) :=
      Finset.single_le_sum hterms (Finset.mem_univ i)
    exact le_trans hle (by simpa [quadSymbol] using hsum)
  have hSdiag : ∀ (a : Fin d →₀ ℕ) (h : hermiteMvLp a ∈ polyGaussCore (d := d)),
      (((c0 : ℝ) : ℂ) • oscL i) ⟨hermiteMvLp a, h⟩
        = (((c0 * ((a i : ℝ) + 1/2) : ℝ)) : ℂ) • hermiteMvLp a := by
    intro a h
    rw [LinearMap.smul_apply, oscL_hermiteMvLp, smul_smul]
    push_cast
    ring_nf
  have hmain := re_inner_diagonal_le (hermiteMvLp (d := d)) orthonormal_hermiteMvLp
    (fun a => c0 * ((a i : ℝ) + 1/2)) (quadSymbol c) span_hermiteMvLp
    (((c0 : ℝ) : ℂ) • oscL i) (quadOp c) hSdiag (fun a h => quadOp_hermiteMvLp c a h) hsymb u
  simpa [inner_smul_right, Complex.ofReal_re] using hmain

/-! ### The relative bounds -/

theorem norm_posL_sq_le (c : Fin d → ℝ) {c0 : ℝ} (hc0 : 0 < c0) (hc : ∀ i, c0 ≤ c i)
    (i : Fin d) (u : polyGaussCore (d := d)) :
    ‖posL i u‖ ^ 2 ≤ (4 / c0) * (‖(u : L2d d)‖ * ‖quadOp c u‖) := by
  have h1 : ‖posL i u‖ ^ 2 / 4 ≤ (inner ℂ (u : L2d d) (oscL i u) : ℂ).re := by
    rw [re_inner_oscL_eq]
    nlinarith [sq_nonneg ‖momL i u‖]
  have h2 := re_inner_oscL_le_quadOp c hc0 hc i u
  have h3 : (inner ℂ (u : L2d d) (quadOp c u) : ℂ).re ≤ ‖(u : L2d d)‖ * ‖quadOp c u‖ :=
    re_inner_le_norm (𝕜 := ℂ) (u : L2d d) (quadOp c u)
  rw [div_mul_eq_mul_div, le_div_iff₀ hc0]
  nlinarith [mul_le_mul_of_nonneg_left h1 hc0.le, h2, h3]

theorem norm_momL_sq_le (c : Fin d → ℝ) {c0 : ℝ} (hc0 : 0 < c0) (hc : ∀ i, c0 ≤ c i)
    (i : Fin d) (u : polyGaussCore (d := d)) :
    ‖momL i u‖ ^ 2 ≤ (4 / c0) * (‖(u : L2d d)‖ * ‖quadOp c u‖) := by
  have h1 : ‖momL i u‖ ^ 2 ≤ (inner ℂ (u : L2d d) (oscL i u) : ℂ).re := by
    rw [re_inner_oscL_eq]
    nlinarith [sq_nonneg ‖posL i u‖]
  have h2 := re_inner_oscL_le_quadOp c hc0 hc i u
  have h3 : (inner ℂ (u : L2d d) (quadOp c u) : ℂ).re ≤ ‖(u : L2d d)‖ * ‖quadOp c u‖ :=
    re_inner_le_norm (𝕜 := ℂ) (u : L2d d) (quadOp c u)
  have h4 : 0 ≤ ‖(u : L2d d)‖ * ‖quadOp c u‖ := by positivity
  rw [div_mul_eq_mul_div, le_div_iff₀ hc0]
  nlinarith [mul_le_mul_of_nonneg_left h1 hc0.le, h2, h3, h4]

/-- An elementary square-root step: `t² ≤ (4/c₀)AB` gives `t ≤ εA + (2/(c₀ε))B`. -/
theorem le_relBound_of_sq_le {t A B c0 e : ℝ} (hA : 0 ≤ A) (hB : 0 ≤ B)
    (hc0 : 0 < c0) (he : 0 < e) (h : t ^ 2 ≤ (4 / c0) * (B * A)) :
    t ≤ e * A + (2 / (c0 * e)) * B := by
  have hrhs : 0 ≤ e * A + (2 / (c0 * e)) * B := by positivity
  have hsq : t ^ 2 ≤ (e * A + (2 / (c0 * e)) * B) ^ 2 := by
    have hcross : (4 / c0) * (B * A) ≤ 2 * (e * A) * ((2 / (c0 * e)) * B) := by
      have : 2 * (e * A) * ((2 / (c0 * e)) * B) = (4 / c0) * (B * A) := by
        field_simp
        ring
      rw [this]
    nlinarith [sq_nonneg (e * A), sq_nonneg ((2 / (c0 * e)) * B), h, hcross]
  nlinarith [hsq, hrhs]

theorem norm_posL_le (c : Fin d → ℝ) {c0 : ℝ} (hc0 : 0 < c0) (hc : ∀ i, c0 ≤ c i)
    {e : ℝ} (he : 0 < e) (i : Fin d) (u : polyGaussCore (d := d)) :
    ‖posL i u‖ ≤ e * ‖quadOp c u‖ + (2 / (c0 * e)) * ‖(u : L2d d)‖ :=
  le_relBound_of_sq_le (norm_nonneg _) (norm_nonneg _) hc0 he
    (norm_posL_sq_le c hc0 hc i u)

theorem norm_momL_le (c : Fin d → ℝ) {c0 : ℝ} (hc0 : 0 < c0) (hc : ∀ i, c0 ≤ c i)
    {e : ℝ} (he : 0 < e) (i : Fin d) (u : polyGaussCore (d := d)) :
    ‖momL i u‖ ≤ e * ‖quadOp c u‖ + (2 / (c0 * e)) * ‖(u : L2d d)‖ :=
  le_relBound_of_sq_le (norm_nonneg _) (norm_nonneg _) hc0 he
    (norm_momL_sq_le c hc0 hc i u)

/-! ## The first-order perturbation -/

/-- The first-order symbol `∑ᵢ (bᵢ xᵢ + b'ᵢ πᵢ)`, on polynomial coordinates. -/
def foPoly (b b' : Fin d → ℝ) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  ∑ i, (((b i : ℝ) : ℂ) • mulXPoly i + ((b' i : ℝ) : ℂ) • momPoly i)

/-- **The first-order perturbation** `B = ∑ᵢ (bᵢ xᵢ + b'ᵢ πᵢ)` on the Hermite core. -/
def foOp (b b' : Fin d → ℝ) : (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  (polyGaussCore (d := d)).subtype ∘ₗ coreOp (foPoly b b')

set_option maxHeartbeats 1000000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
theorem foOp_apply (b b' : Fin d → ℝ) (u : polyGaussCore (d := d)) :
    foOp b b' u = ∑ i, (((b i : ℝ) : ℂ) • posL i u + ((b' i : ℝ) : ℂ) • momL i u) := by
  simp only [foOp, foPoly, LinearMap.comp_apply, Submodule.subtype_apply, coreOp_sum,
    coreOp_add, coreOp_smul, LinearMap.sum_apply, LinearMap.add_apply, LinearMap.smul_apply,
    Submodule.coe_sum, Submodule.coe_add, Submodule.coe_smul]
  rfl

theorem gaussInt_zero : gaussInt (0 : MvPolynomial (Fin d) ℂ) = 0 := by
  have h := gaussInt_smul (0 : ℂ) (0 : MvPolynomial (Fin d) ℂ)
  simpa using h

theorem polySym_zero : BookProof.YangMillsHermite.PolySym
    (0 : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) := by
  intro p q
  simp [BookProof.YangMillsHermite.starP, gaussInt_zero]

theorem polySym_sum {ι : Type*} (s : Finset ι)
    (T : ι → MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
    (h : ∀ i ∈ s, BookProof.YangMillsHermite.PolySym (T i)) :
    BookProof.YangMillsHermite.PolySym (∑ i ∈ s, T i) := by
  classical
  induction s using Finset.induction with
  | empty => simpa using polySym_zero
  | insert i s hi ih =>
      rw [Finset.sum_insert hi]
      exact (h i (Finset.mem_insert_self i s)).add
        (ih fun j hj => h j (Finset.mem_insert_of_mem hj))

theorem polySym_foPoly (b b' : Fin d → ℝ) : BookProof.YangMillsHermite.PolySym (foPoly b b') :=
  polySym_sum _ _ fun i _ =>
    (BookProof.YangMillsHermite.PolySym.real_smul (polySym_mulXPoly i)).add
      (BookProof.YangMillsHermite.PolySym.real_smul (polySym_momPoly i))

set_option maxHeartbeats 1000000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
theorem foOp_symmetric (b b' : Fin d → ℝ) :
    SymmetricOn (polyGaussCore (d := d)) (foOp b b') :=
  symmetricOn_of_polySym (polySym_foPoly b b')

/-- The relative bound of the first-order perturbation with respect to `H_c`. -/
theorem norm_foOp_le (c : Fin d → ℝ) {c0 : ℝ} (hc0 : 0 < c0) (hc : ∀ i, c0 ≤ c i)
    (b b' : Fin d → ℝ) {e : ℝ} (he : 0 < e) (u : polyGaussCore (d := d)) :
    ‖foOp b b' u‖
      ≤ (∑ i, (|b i| + |b' i|)) * (e * ‖quadOp c u‖ + (2 / (c0 * e)) * ‖(u : L2d d)‖) := by
  classical
  set R : ℝ := e * ‖quadOp c u‖ + (2 / (c0 * e)) * ‖(u : L2d d)‖ with hR
  have hR0 : 0 ≤ R := by
    have : 0 ≤ 2 / (c0 * e) := by positivity
    have h1 : 0 ≤ e * ‖quadOp c u‖ := by positivity
    have h2 : 0 ≤ (2 / (c0 * e)) * ‖(u : L2d d)‖ := by positivity
    linarith
  calc ‖foOp b b' u‖
      = ‖∑ i, (((b i : ℝ) : ℂ) • posL i u + ((b' i : ℝ) : ℂ) • momL i u)‖ := by
        rw [foOp_apply]
    _ ≤ ∑ i, ‖((b i : ℝ) : ℂ) • posL i u + ((b' i : ℝ) : ℂ) • momL i u‖ := norm_sum_le _ _
    _ ≤ ∑ i, (|b i| + |b' i|) * R := by
        refine Finset.sum_le_sum fun i _ => ?_
        have hb : ‖((b i : ℝ) : ℂ) • posL i u‖ = |b i| * ‖posL i u‖ := by
          rw [norm_smul]
          simp
        have hb' : ‖((b' i : ℝ) : ℂ) • momL i u‖ = |b' i| * ‖momL i u‖ := by
          rw [norm_smul]
          simp
        have h1 : ‖posL i u‖ ≤ R := norm_posL_le c hc0 hc he i u
        have h2 : ‖momL i u‖ ≤ R := norm_momL_le c hc0 hc he i u
        calc ‖((b i : ℝ) : ℂ) • posL i u + ((b' i : ℝ) : ℂ) • momL i u‖
            ≤ ‖((b i : ℝ) : ℂ) • posL i u‖ + ‖((b' i : ℝ) : ℂ) • momL i u‖ := norm_add_le _ _
          _ = |b i| * ‖posL i u‖ + |b' i| * ‖momL i u‖ := by rw [hb, hb']
          _ ≤ |b i| * R + |b' i| * R := by
              have := mul_le_mul_of_nonneg_left h1 (abs_nonneg (b i))
              have := mul_le_mul_of_nonneg_left h2 (abs_nonneg (b' i))
              linarith
          _ = (|b i| + |b' i|) * R := by ring
    _ = (∑ i, (|b i| + |b' i|)) * R := by rw [Finset.sum_mul]

/-- **The headline.**  For strictly positive weights `cᵢ ≥ c₀ > 0`, the operator
`H_c + ∑ᵢ (bᵢ xᵢ + b'ᵢ πᵢ)` — a diagonal quadratic Hamiltonian plus an arbitrary
*unbounded* first-order perturbation with real coefficients — is essentially self-adjoint
on the Gauss–polynomial (Hermite) core of `L²(ℝᵈ)`. -/
theorem quadOp_add_firstOrder_essentiallySelfAdjoint (c : Fin d → ℝ) {c0 : ℝ} (hc0 : 0 < c0)
    (hc : ∀ i, c0 ≤ c i) (b b' : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (quadOp c + foOp b b') := by
  classical
  set K : ℝ := ∑ i, (|b i| + |b' i|) with hK
  have hK0 : 0 ≤ K := Finset.sum_nonneg fun i _ => by positivity
  set e : ℝ := 1 / (2 * (K + 1)) with he
  have he0 : 0 < e := by
    have : 0 < 2 * (K + 1) := by linarith
    positivity
  refine BookProof.KatoRellich.essentiallySelfAdjointOn_add_relBounded _ _ (quadOp_symmetric c)
    (quadOp_essentiallySelfAdjoint c) (foOp_symmetric b b') (a := K * e)
    (b := K * (2 / (c0 * e))) (by positivity) ?_ (by positivity) ?_
  · rw [he]
    rw [mul_one_div, div_lt_one (by linarith)]
    linarith
  · intro u
    have h := norm_foOp_le c hc0 hc b b' he0 u
    calc ‖foOp b b' u‖ ≤ K * (e * ‖quadOp c u‖ + (2 / (c0 * e)) * ‖(u : L2d d)‖) := h
      _ = K * e * ‖quadOp c u‖ + K * (2 / (c0 * e)) * ‖(u : L2d d)‖ := by ring

/-! ## The diagonalizing unitary -/

/-- **The Hermite unitary diagonalizes `H_c`**: the coordinates of `H_c u` in the product
Hermite basis are those of `u` multiplied by the real symbol `∑ᵢ cᵢ(αᵢ + ½)`.  This is the
spectral theorem in multiplication form for this (unbounded) operator: the Hilbert basis
`hermiteMvBasis` *is* a diagonalizing unitary `L²(ℝᵈ) ≃ ℓ²`. -/
theorem hermiteMvBasis_repr_quadOp (c : Fin d → ℝ) (u : polyGaussCore (d := d))
    (a : Fin d →₀ ℕ) :
    hermiteMvBasis.repr (quadOp c u) a
      = ((quadSymbol c a : ℝ) : ℂ) * hermiteMvBasis.repr (u : L2d d) a := by
  have hmem : hermiteMvLp a ∈ polyGaussCore (d := d) := hermiteMvLp_mem_core a
  have hsym := quadOp_symmetric c ⟨hermiteMvLp a, hmem⟩ u
  rw [quadOp_hermiteMvLp c a hmem, inner_smul_left, Complex.conj_ofReal] at hsym
  rw [HilbertBasis.repr_apply_apply, HilbertBasis.repr_apply_apply, hermiteMvBasis_apply]
  exact hsym.symm

/-! ## The Stark-shifted oscillator -/

/-- The first-order perturbation with `b' = 0` is multiplication by the (unbounded) linear
function `x ↦ ⟨b, x⟩`. -/
theorem foOp_linear_apply_eq_mul (b : Fin d → ℝ) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFun (foPoly b 0 p) x = ((∑ i, b i * x i : ℝ) : ℂ) * pgFun p x := by
  classical
  have hpoly : foPoly b 0 p = ∑ i, ((b i : ℝ) : ℂ) • (X i * p) := by
    simp [foPoly, mulXPoly]
  rw [hpoly]
  have : pgFun (∑ i, ((b i : ℝ) : ℂ) • (X i * p)) x
      = ∑ i, ((b i : ℝ) : ℂ) * pgFun (X i * p) x := by
    classical
    induction (Finset.univ : Finset (Fin d)) using Finset.induction with
    | empty => simp [pgFun]
    | insert i s hi ih =>
        rw [Finset.sum_insert hi, Finset.sum_insert hi,
          BookProof.HyperbolicQuadratic.pgFun_add, ih,
          BookProof.HyperbolicQuadratic.pgFun_smul]
  rw [this]
  have hx : ∀ i : Fin d, pgFun ((X i : MvPolynomial (Fin d) ℂ) * p) x
      = ((x i : ℝ) : ℂ) * pgFun p x := fun i => by
    simpa using posOp_apply_eq_mul i p x
  simp_rw [hx]
  push_cast
  rw [Finset.sum_mul]
  exact Finset.sum_congr rfl fun i _ => by ring

/-- **The Stark-shifted harmonic oscillator** `−Δ + ‖x‖²/4 + ⟨b, x⟩` is essentially
self-adjoint on the Hermite core of `L²(ℝᵈ)`.  The perturbation is the unbounded real
potential `x ↦ ⟨b, x⟩`. -/
theorem harmonicOsc_add_linearPotential_essentiallySelfAdjoint (b : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (quadOp (fun _ => (1 : ℝ)) + foOp b 0) :=
  quadOp_add_firstOrder_essentiallySelfAdjoint _ (c0 := 1) one_pos (fun _ => le_rfl) b 0

end

end BookProof.HermiteRelative
