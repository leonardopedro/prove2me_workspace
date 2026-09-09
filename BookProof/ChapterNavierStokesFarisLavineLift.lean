import Mathlib
import BookProof.ChapterNavierStokesFullEsa

/-!
# The one-particle comparison operator, and how the Faris–Lavine bounds lift

Companion to `BookProof.ChapterNavierStokesSecondQuant`, which lifts *essential
self-adjointness* from the sectors of a Fock space to the finite-particle
domain.  This module supplies the other two ingredients of the Faris–Lavine
route to essential self-adjointness of the Navier–Stokes Hamiltonian:

**1. The one-particle comparison operator.**  In the fiber space the advection
term is a *linear* vector field `V(u)`, so the natural comparison operator is
`n = ∑ᵢ πᵢ² + ∑ᵢ Vᵢ² + I`.  `ComparisonData` packages the (symmetric) momenta
`πᵢ` and drifts `Vᵢ` on a dense domain of an arbitrary complex inner product
space, and `ComparisonData.comparison` is the operator.  Proved here:
`comparison_isSymmetricDom` (symmetry), `comparison_inner_eq` (the quadratic
form is `∑‖πᵢv‖² + ∑‖Vᵢv‖² + ‖v‖²` — no cross terms, because the squares are
squares of symmetric operators), `comparison_ge_norm_sq` (`n ≥ I`, the
positivity Faris–Lavine asks of the comparison operator) and two criteria for
essential self-adjointness: `comparison_hasZeroDeficiencyOn_of_eigenvectors`
from a total family of eigenvectors, and `diagComparison_hasZeroDeficiencyOn`,
an unconditional instance in the representation in which the `πᵢ` and `Vᵢ` are
simultaneously diagonal (the fiber momentum representation), where the operator
is also genuinely unbounded (`diagComparison_not_bounded`).

**2. How the two Faris–Lavine bounds behave when summed over particles.**  On an
`m`-particle sector the second-quantized operators are `Ĥ = ∑ₖ hₖ` and
`N̂ = ∑ₖ nₖ + I`.

* `norm_sum_le_of_pairwise` — the *operator* bound lifts with the **same**
  constant provided the domination holds *pairwise*,
  `|Re⟪hₖv, hₗv⟫| ≤ c² Re⟪nₖv, nₗv⟫` for all pairs `k, l`.
* `not_forall_norm_sum_le_of_pointwise` — and pairwise is genuinely needed: the
  naive argument "triangle inequality plus the one-particle bound" is **not**
  valid.  There are two pairs `(hₖ, nₖ)` with `‖hₖ x‖ ≤ ‖nₖ x‖` for every `x`
  and yet `‖(h₀ + h₁)x‖ > ‖(n₀ + n₁)x‖`; the step
  `∑ₖ ‖nₖ Ψ‖ ≤ ‖N̂ Ψ‖` in the informal argument is false as stated.
* `abs_re_inner_commutator_sum_le` — the *form commutator* bound, by contrast,
  lifts exactly as the informal argument says, because quadratic forms are
  additive: with `[hₖ, nₗ] = 0` for `k ≠ l` (different particles) one has
  `[Ĥ, N̂] = ∑ₖ [hₖ, nₖ]`(`commDom_sum`, `commDom_add_id`) and therefore
  `|Re⟪Ψ, [Ĥ, N̂]Ψ⟫| ≤ c₂ Re⟪Ψ, N̂Ψ⟫`.

## Scope

Nothing here claims essential self-adjointness of the continuum Navier–Stokes
generator.  The Faris–Lavine criterion itself is not proved anywhere in this
project; it enters as a named hypothesis (`ns_esa_of_farisLavine_dense`).  What
is established here is exactly which bounds survive second quantization, and in
what form.
-/

namespace BookProof.NavierStokesFlow

namespace FarisLavineLift

open FullEsa

/-! ## Elementary inner-product facts -/

section Elementary

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- The squared norm of a finite sum, expanded into the real parts of all the
pairwise inner products. -/
theorem norm_sum_sq_eq {κ : Type*} (s : Finset κ) (a : κ → F) :
    ‖∑ k ∈ s, a k‖ ^ 2 = ∑ k ∈ s, ∑ l ∈ s, (inner ℂ (a k) (a l) : ℂ).re := by
  have hinner : (inner ℂ (∑ k ∈ s, a k) (∑ l ∈ s, a l) : ℂ)
      = ∑ k ∈ s, ∑ l ∈ s, (inner ℂ (a k) (a l) : ℂ) := by
    rw [sum_inner]
    exact Finset.sum_congr rfl fun k _ => inner_sum _ _ _
  have hnorm : ‖∑ k ∈ s, a k‖ ^ 2 = (inner ℂ (∑ k ∈ s, a k) (∑ k ∈ s, a k) : ℂ).re := by
    simpa using (inner_self_eq_norm_sq (𝕜 := ℂ) (∑ k ∈ s, a k)).symm
  rw [hnorm, hinner, Complex.re_sum]
  exact Finset.sum_congr rfl fun k _ => Complex.re_sum _ _

/-- Adding a vector that makes a non-negative angle can only increase the
norm. -/
theorem norm_le_norm_add_of_re_inner_nonneg {x y : F} (h : 0 ≤ (inner ℂ x y : ℂ).re) :
    ‖x‖ ≤ ‖x + y‖ := by
  have hsq : ‖x + y‖ ^ 2 = ‖x‖ ^ 2 + 2 * (inner ℂ x y : ℂ).re + ‖y‖ ^ 2 := by
    simpa using norm_add_sq (𝕜 := ℂ) x y
  nlinarith [norm_nonneg x, norm_nonneg y, sq_nonneg ‖y‖, norm_nonneg (x + y)]

end Elementary

/-! ## The one-particle comparison operator `n = π² + V² + I` -/

section Comparison

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- The data of a one-particle comparison operator on a fiber space: a dense
domain, the momenta `πᵢ = -i ∂/∂uᵢ` and the drifts `Vᵢ(u)`, all symmetric and
preserving the domain.  In the Navier–Stokes fiber space `Vᵢ(u) = u_{i,j}u_j −
ν u_{i,jj}` is a *linear* function of the (independent) fiber coordinates, so
`Vᵢ²` is a non-negative quadratic potential. -/
structure ComparisonData (F : Type*) [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    (d : ℕ) where
  /-- The dense domain (a core: in the Navier–Stokes fiber space, `C_c^∞`). -/
  D : Submodule ℂ F
  /-- The domain is dense. -/
  dense : Dense (D : Set F)
  /-- The momenta. -/
  mom : Fin d → (D →ₗ[ℂ] D)
  /-- The drift (advection) fields. -/
  drift : Fin d → (D →ₗ[ℂ] D)
  /-- Each momentum is symmetric. -/
  mom_symm : ∀ i, IsSymmetricDom (mom i)
  /-- Each drift is symmetric. -/
  drift_symm : ∀ i, IsSymmetricDom (drift i)

namespace ComparisonData

variable {d : ℕ} (c : ComparisonData F d)

/-- The comparison operator `n = ∑ᵢ πᵢ² + ∑ᵢ Vᵢ² + I`. -/
noncomputable def comparison : c.D →ₗ[ℂ] c.D :=
  (∑ i, (c.mom i).comp (c.mom i)) + (∑ i, (c.drift i).comp (c.drift i)) + LinearMap.id

/-- The comparison operator is symmetric: each summand is the square of a
symmetric operator. -/
theorem comparison_isSymmetricDom : IsSymmetricDom c.comparison := by
  have hid : IsSymmetricDom (LinearMap.id : c.D →ₗ[ℂ] c.D) := by
    intro x y
    simp
  refine IsSymmetricDom.add (IsSymmetricDom.add ?_ ?_) hid
  · exact IsSymmetricDom.sum Finset.univ fun i _ =>
      (c.mom_symm i).comp_of_commute (c.mom_symm i) rfl
  · exact IsSymmetricDom.sum Finset.univ fun i _ =>
      (c.drift_symm i).comp_of_commute (c.drift_symm i) rfl

/-- The quadratic form of the comparison operator: `⟪v, n v⟫ = ∑‖πᵢv‖² +
∑‖Vᵢv‖² + ‖v‖²`.  In particular it is real and non-negative — the squares of
the symmetric constituents contribute their norms, and there are no cross
terms. -/
theorem comparison_inner_eq (v : c.D) :
    (inner ℂ ((v : F)) ((c.comparison v : c.D) : F) : ℂ).re
      = (∑ i, ‖((c.mom i v : c.D) : F)‖ ^ 2) + (∑ i, ‖((c.drift i v : c.D) : F)‖ ^ 2)
        + ‖(v : F)‖ ^ 2 := by
  have hmom : ∀ i : Fin d,
      (inner ℂ ((v : F)) (((c.mom i).comp (c.mom i) v : c.D) : F) : ℂ)
        = ((‖((c.mom i v : c.D) : F)‖ ^ 2 : ℝ) : ℂ) := by
    intro i
    have h := (c.mom_symm i) v ((c.mom i) v)
    have h2 : (inner ℂ ((v : F)) (((c.mom i) ((c.mom i) v) : c.D) : F) : ℂ)
        = inner ℂ ((c.mom i v : c.D) : F) ((c.mom i v : c.D) : F) := by
      simpa using h.symm
    rw [LinearMap.comp_apply, h2]
    simp
  have hdrift : ∀ i : Fin d,
      (inner ℂ ((v : F)) (((c.drift i).comp (c.drift i) v : c.D) : F) : ℂ)
        = ((‖((c.drift i v : c.D) : F)‖ ^ 2 : ℝ) : ℂ) := by
    intro i
    have h := (c.drift_symm i) v ((c.drift i) v)
    have h2 : (inner ℂ ((v : F)) (((c.drift i) ((c.drift i) v) : c.D) : F) : ℂ)
        = inner ℂ ((c.drift i v : c.D) : F) ((c.drift i v : c.D) : F) := by
      simpa using h.symm
    rw [LinearMap.comp_apply, h2]
    simp
  have hsplit : (inner ℂ ((v : F)) ((c.comparison v : c.D) : F) : ℂ)
      = (∑ i, (inner ℂ ((v : F)) (((c.mom i).comp (c.mom i) v : c.D) : F) : ℂ))
        + (∑ i, (inner ℂ ((v : F)) (((c.drift i).comp (c.drift i) v : c.D) : F) : ℂ))
        + inner ℂ ((v : F)) ((v : F)) := by
    simp only [comparison, LinearMap.add_apply, LinearMap.id_apply, Submodule.coe_add,
      inner_add_right, LinearMap.sum_apply, AddSubmonoidClass.coe_finset_sum, inner_sum]
  rw [hsplit]
  simp only [hmom, hdrift]
  rw [← Complex.ofReal_sum, ← Complex.ofReal_sum]
  have hself : (inner ℂ ((v : F)) ((v : F)) : ℂ) = ((‖(v : F)‖ ^ 2 : ℝ) : ℂ) := by
    simp
  rw [hself]
  have hcast : ∀ r : ℝ, ((r : ℂ) ^ 2).re = r ^ 2 := fun r => by
    rw [← Complex.ofReal_pow, Complex.ofReal_re]
  simp [hcast]

/-- **The comparison operator dominates the identity**: `⟪v, n v⟫ ≥ ‖v‖²`.  This
is the positivity Faris–Lavine requires of the comparison operator (`N ≥ I`), and
it holds *unconditionally*, because `V²` is a square. -/
theorem comparison_ge_norm_sq (v : c.D) :
    ‖(v : F)‖ ^ 2 ≤ (inner ℂ ((v : F)) ((c.comparison v : c.D) : F) : ℂ).re := by
  rw [c.comparison_inner_eq v]
  have h1 : (0 : ℝ) ≤ ∑ i, ‖((c.mom i v : c.D) : F)‖ ^ 2 :=
    Finset.sum_nonneg fun i _ => sq_nonneg _
  have h2 : (0 : ℝ) ≤ ∑ i, ‖((c.drift i v : c.D) : F)‖ ^ 2 :=
    Finset.sum_nonneg fun i _ => sq_nonneg _
  linarith

/-- Consequently the comparison operator is non-negative. -/
theorem comparison_nonneg (v : c.D) :
    0 ≤ (inner ℂ ((v : F)) ((c.comparison v : c.D) : F) : ℂ).re :=
  le_trans (sq_nonneg _) (c.comparison_ge_norm_sq v)

/-- **Essential self-adjointness of the comparison operator from a total family
of eigenvectors** — the situation of the fiber momentum representation, in which
the momenta and the drifts are simultaneously diagonalized. -/
theorem comparison_hasZeroDeficiencyOn_of_eigenvectors {I : Type*} (e : I → c.D) (lam : I → ℝ)
    (heig : ∀ i, c.comparison (e i) = ((lam i : ℂ)) • e i)
    (htotal : ∀ w : F, (∀ i, (inner ℂ ((e i : c.D) : F) w : ℂ) = 0) → w = 0) :
    HasZeroDeficiencyOn c.D c.comparison :=
  hasZeroDeficiencyOn_of_total_eigenvectors c.D c.comparison e lam heig htotal

end ComparisonData

end Comparison

/-! ### An unconditional instance: the comparison operator in the momentum
representation -/

section DiagonalComparison

open LpNat DiagonalEsa

/-- The comparison operator in the representation in which the momenta `πᵢ` and
the drifts `Vᵢ` are simultaneously diagonal — the fiber momentum representation,
where `πᵢ` is multiplication by the momentum symbol `pᵢ` and `Vᵢ` multiplication
by the (linear) advection symbol `qᵢ`.  Here `ℓ²(ℕ)` plays the role of the fiber
space and the finite-mode states the role of the core `C_c^∞`. -/
noncomputable def diagComparisonData (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    ComparisonData L2N d where
  D := lpFiniteModes ℕ
  dense := lpFiniteModes_dense
  mom i := diagOp (p i)
  drift i := diagOp (q i)
  mom_symm _ := FullEsa.diagOp_isSymmetricDom _
  drift_symm _ := FullEsa.diagOp_isSymmetricDom _

/-- The identity is the diagonal operator with constant symbol `1`. -/
theorem diagOp_one :
    (LinearMap.id : lpFiniteModes ℕ →ₗ[ℂ] lpFiniteModes ℕ) = diagOp (fun _ => 1) := by
  refine LinearMap.ext fun f => Subtype.ext (lp.ext ?_)
  funext n
  simp [diagOp, diagFun]

/-- In this representation the comparison operator is multiplication by the
classical symbol `∑ᵢ pᵢ² + ∑ᵢ qᵢ² + 1 ≥ 1`. -/
theorem diagComparison_eq (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    (diagComparisonData d p q).comparison
      = diagOp (fun k => (∑ i, p i k ^ 2) + (∑ i, q i k ^ 2) + 1) := by
  have hmom : (∑ i, ((diagComparisonData d p q).mom i).comp
      ((diagComparisonData d p q).mom i)) = diagOp (fun k => ∑ i, p i k ^ 2) := by
    have hcomp : ∀ i : Fin d, ((diagComparisonData d p q).mom i).comp
        ((diagComparisonData d p q).mom i) = diagOp (fun k => p i k ^ 2) := by
      intro i
      rw [show ((diagComparisonData d p q).mom i) = diagOp (p i) from rfl,
        FullEsa.diagOp_comp]
      simp [sq]
    rw [Finset.sum_congr rfl fun i _ => hcomp i, FullEsa.diagOp_sum]
  have hdrift : (∑ i, ((diagComparisonData d p q).drift i).comp
      ((diagComparisonData d p q).drift i)) = diagOp (fun k => ∑ i, q i k ^ 2) := by
    have hcomp : ∀ i : Fin d, ((diagComparisonData d p q).drift i).comp
        ((diagComparisonData d p q).drift i) = diagOp (fun k => q i k ^ 2) := by
      intro i
      rw [show ((diagComparisonData d p q).drift i) = diagOp (q i) from rfl,
        FullEsa.diagOp_comp]
      simp [sq]
    rw [Finset.sum_congr rfl fun i _ => hcomp i, FullEsa.diagOp_sum]
  rw [ComparisonData.comparison, hmom, hdrift, diagOp_one, FullEsa.diagOp_add,
    FullEsa.diagOp_add]

/-- **The one-particle comparison operator is essentially self-adjoint** in the
momentum representation, with no hypothesis whatsoever on the symbols: this is
the fiber-space form of the statement that `−Δ + V² + I` with `V² ≥ 0` is
essentially self-adjoint on a core. -/
theorem diagComparison_hasZeroDeficiencyOn (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    HasZeroDeficiencyOn (lpFiniteModes ℕ) (diagComparisonData d p q).comparison := by
  rw [diagComparison_eq]
  exact diagOp_hasZeroDeficiencyOn _

/-- And it is genuinely unbounded as soon as one of the symbols is: essential
self-adjointness here is not a boundedness phenomenon. -/
theorem diagComparison_not_bounded (d : ℕ) (p q : Fin d → ℕ → ℝ)
    (hunb : ∀ C : ℝ, ∃ k, C < |(∑ i, p i k ^ 2) + (∑ i, q i k ^ 2) + 1|) :
    ¬ ∃ C : ℝ, ∀ f : lpFiniteModes ℕ,
      ‖(diagComparisonData d p q).comparison f‖ ≤ C * ‖f‖ := by
  rw [diagComparison_eq]
  exact diagOp_not_bounded _ hunb

end DiagonalComparison

/-! ## Lifting the two Faris–Lavine bounds over the particles of a sector -/

section Lifting

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {κ : Type*}

theorem coe_sum_apply (s : Finset κ) (A : κ → (D →ₗ[ℂ] D)) (v : D) :
    (((∑ k ∈ s, A k) v : D) : F) = ∑ k ∈ s, ((A k v : D) : F) := by
  simp

/-- **Lifting the operator bound to a sector.**  If the one-particle domination
holds *pairwise* — `|Re⟪hₖ v, hₗ v⟫| ≤ c² Re⟪nₖ v, nₗ v⟫` for every pair of
particles — then the sums obey the same bound with the same constant:
`‖∑ₖ hₖ v‖ ≤ c ‖∑ₖ nₖ v‖`.  The diagonal `k = l` of the hypothesis is the
one-particle bound `‖hv‖ ≤ c‖nv‖`; the off-diagonal part is what the tensor
structure of the Fock sector provides, and by
`not_forall_norm_sum_le_of_pointwise` it cannot be dispensed with. -/
theorem norm_sum_le_of_pairwise (s : Finset κ) (h n : κ → (D →ₗ[ℂ] D)) (cst : ℝ)
    (hc : 0 ≤ cst) (v : D)
    (hpair : ∀ k ∈ s, ∀ l ∈ s,
      |(inner ℂ ((h k v : D) : F) ((h l v : D) : F) : ℂ).re|
        ≤ cst ^ 2 * (inner ℂ ((n k v : D) : F) ((n l v : D) : F) : ℂ).re) :
    ‖(((∑ k ∈ s, h k) v : D) : F)‖ ≤ cst * ‖(((∑ k ∈ s, n k) v : D) : F)‖ := by
  have hL : ‖(((∑ k ∈ s, h k) v : D) : F)‖ ^ 2
      = ∑ k ∈ s, ∑ l ∈ s, (inner ℂ ((h k v : D) : F) ((h l v : D) : F) : ℂ).re := by
    rw [coe_sum_apply s h v]
    exact norm_sum_sq_eq s fun k => ((h k v : D) : F)
  have hR : ‖(((∑ k ∈ s, n k) v : D) : F)‖ ^ 2
      = ∑ k ∈ s, ∑ l ∈ s, (inner ℂ ((n k v : D) : F) ((n l v : D) : F) : ℂ).re := by
    rw [coe_sum_apply s n v]
    exact norm_sum_sq_eq s fun k => ((n k v : D) : F)
  have hsq : ‖(((∑ k ∈ s, h k) v : D) : F)‖ ^ 2
      ≤ cst ^ 2 * ‖(((∑ k ∈ s, n k) v : D) : F)‖ ^ 2 := by
    rw [hL, hR, Finset.mul_sum]
    refine Finset.sum_le_sum fun k hk => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun l hl => le_trans (le_abs_self _) (hpair k hk l hl)
  nlinarith [norm_nonneg (((∑ k ∈ s, h k) v : D) : F),
    norm_nonneg (((∑ k ∈ s, n k) v : D) : F),
    mul_nonneg hc (norm_nonneg (((∑ k ∈ s, n k) v : D) : F))]

/-- Adding the identity to the comparison operator can only help, provided the
comparison operator is non-negative on the state. -/
theorem norm_le_norm_add_id (N : D →ₗ[ℂ] D) (v : D)
    (hpos : 0 ≤ (inner ℂ ((N v : D) : F) ((v : F)) : ℂ).re) :
    ‖((N v : D) : F)‖ ≤ ‖((((N + LinearMap.id : D →ₗ[ℂ] D)) v : D) : F)‖ := by
  have : ((((N + LinearMap.id : D →ₗ[ℂ] D)) v : D) : F) = ((N v : D) : F) + (v : F) := by
    simp
  rw [this]
  exact norm_le_norm_add_of_re_inner_nonneg hpos

/-! ### The commutator -/

/-- The commutator of two domain-preserving operators. -/
def commDom (A B : D →ₗ[ℂ] D) : D →ₗ[ℂ] D := A.comp B - B.comp A

@[simp] theorem commDom_apply (A B : D →ₗ[ℂ] D) (v : D) :
    commDom A B v = A (B v) - B (A v) := rfl

/-- Adding the identity to the second argument does not change the
commutator: `[Ĥ, N̂ + I] = [Ĥ, N̂]`. -/
theorem commDom_add_id (A B : D →ₗ[ℂ] D) :
    commDom A (B + LinearMap.id) = commDom A B := by
  ext v
  simp [commDom]

/-- **The commutator of second-quantized operators is the second quantization of
the commutators**: if operators belonging to different particles commute, then
`[∑ₖ hₖ, ∑ₗ nₗ] = ∑ₖ [hₖ, nₖ]`. -/
theorem commDom_sum (s : Finset κ) (h n : κ → (D →ₗ[ℂ] D))
    (hcomm : ∀ k ∈ s, ∀ l ∈ s, k ≠ l → (h k).comp (n l) = (n l).comp (h k)) :
    commDom (∑ k ∈ s, h k) (∑ k ∈ s, n k) = ∑ k ∈ s, commDom (h k) (n k) := by
  ext v
  have hexp : (commDom (∑ k ∈ s, h k) (∑ k ∈ s, n k)) v
      = ∑ k ∈ s, ∑ l ∈ s, (h k (n l v) - n l (h k v)) := by
    simp only [commDom, LinearMap.sub_apply, LinearMap.comp_apply, LinearMap.sum_apply, map_sum,
      Finset.sum_sub_distrib]
    congr 1
    exact Finset.sum_comm
  rw [hexp]
  have hdiag : ∀ k ∈ s, ∑ l ∈ s, (h k (n l v) - n l (h k v)) = commDom (h k) (n k) v := by
    intro k hk
    rw [Finset.sum_eq_single_of_mem k hk]
    · simp [commDom]
    · intro l hl hlk
      have := hcomm k hk l hl (Ne.symm hlk)
      have happ := congrArg (fun T : D →ₗ[ℂ] D => T v) this
      simp only [LinearMap.comp_apply] at happ
      rw [happ]
      simp
  rw [Finset.sum_congr rfl hdiag]
  simp

/-- **Lifting the form-commutator bound to a sector.**  Quadratic forms are
additive over the particles, so the one-particle bound
`|⟪v, [hₖ, nₖ]v⟫| ≤ c₂ Re⟪v, nₖ v⟫` sums, and — unlike the operator bound —
this lifting needs nothing beyond the commutation of operators belonging to
different particles.  The comparison operator on the sector is `N̂ = ∑ₖ nₖ + I`,
whose form exceeds that of `∑ₖ nₖ` by `‖v‖² ≥ 0`.

The commutator expectation is bounded in modulus, not in real part: for
symmetric `hₖ`, `nₖ` the number `⟪v, [hₖ, nₖ]v⟫` is purely imaginary, so a bound
on its real part would say nothing. -/
theorem norm_inner_commutator_sum_le (s : Finset κ) (h n : κ → (D →ₗ[ℂ] D)) (c₂ : ℝ)
    (hc₂ : 0 ≤ c₂) (v : D)
    (hcomm : ∀ k ∈ s, ∀ l ∈ s, k ≠ l → (h k).comp (n l) = (n l).comp (h k))
    (hbound : ∀ k ∈ s, ‖(inner ℂ ((v : F)) ((commDom (h k) (n k) v : D) : F) : ℂ)‖
      ≤ c₂ * (inner ℂ ((v : F)) ((n k v : D) : F) : ℂ).re) :
    ‖(inner ℂ ((v : F))
        ((commDom (∑ k ∈ s, h k) ((∑ k ∈ s, n k) + LinearMap.id) v : D) : F) : ℂ)‖
      ≤ c₂ * (inner ℂ ((v : F))
        ((((∑ k ∈ s, n k) + LinearMap.id : D →ₗ[ℂ] D) v : D) : F) : ℂ).re := by
  rw [commDom_add_id, commDom_sum s h n hcomm]
  have hleft : (inner ℂ ((v : F)) (((∑ k ∈ s, commDom (h k) (n k)) v : D) : F) : ℂ)
      = ∑ k ∈ s, (inner ℂ ((v : F)) ((commDom (h k) (n k) v : D) : F) : ℂ) := by
    rw [coe_sum_apply s (fun k => commDom (h k) (n k)) v, inner_sum]
  have hright : (inner ℂ ((v : F))
        ((((∑ k ∈ s, n k) + LinearMap.id : D →ₗ[ℂ] D) v : D) : F) : ℂ).re
      = (∑ k ∈ s, (inner ℂ ((v : F)) ((n k v : D) : F) : ℂ).re) + ‖(v : F)‖ ^ 2 := by
    have hcoe : ((((∑ k ∈ s, n k) + LinearMap.id : D →ₗ[ℂ] D) v : D) : F)
        = (∑ k ∈ s, ((n k v : D) : F)) + (v : F) := by
      simp
    rw [hcoe, inner_add_right, Complex.add_re, inner_sum, Complex.re_sum]
    congr 1
    simpa using inner_self_eq_norm_sq (𝕜 := ℂ) ((v : F))
  rw [hleft, hright]
  have habs : ‖∑ k ∈ s, (inner ℂ ((v : F)) ((commDom (h k) (n k) v : D) : F) : ℂ)‖
      ≤ ∑ k ∈ s, c₂ * (inner ℂ ((v : F)) ((n k v : D) : F) : ℂ).re :=
    le_trans (norm_sum_le _ _) (Finset.sum_le_sum hbound)
  have hsq : (0 : ℝ) ≤ c₂ * ‖(v : F)‖ ^ 2 := mul_nonneg hc₂ (sq_nonneg _)
  rw [← Finset.mul_sum] at habs
  nlinarith [habs, hsq]

/-- The same bound in the shape the Faris–Lavine criterion is stated in: the
right-hand side is the modulus of `⟪v, N̂ v⟫`, which for a non-negative
comparison operator agrees with its real part. -/
theorem norm_inner_commutator_sum_le' (s : Finset κ) (h n : κ → (D →ₗ[ℂ] D)) (c₂ : ℝ)
    (hc₂ : 0 ≤ c₂) (v : D)
    (hcomm : ∀ k ∈ s, ∀ l ∈ s, k ≠ l → (h k).comp (n l) = (n l).comp (h k))
    (hbound : ∀ k ∈ s, ‖(inner ℂ ((v : F)) ((commDom (h k) (n k) v : D) : F) : ℂ)‖
      ≤ c₂ * (inner ℂ ((v : F)) ((n k v : D) : F) : ℂ).re) :
    ‖(inner ℂ ((v : F))
        ((commDom (∑ k ∈ s, h k) ((∑ k ∈ s, n k) + LinearMap.id) v : D) : F) : ℂ)‖
      ≤ c₂ * ‖(inner ℂ ((v : F))
        ((((∑ k ∈ s, n k) + LinearMap.id : D →ₗ[ℂ] D) v : D) : F) : ℂ)‖ := by
  refine le_trans (norm_inner_commutator_sum_le s h n c₂ hc₂ v hcomm hbound) ?_
  exact mul_le_mul_of_nonneg_left (Complex.re_le_norm _) hc₂

end Lifting

/-! ## Sharpness: the naive lifting of the operator bound is invalid -/

section Sharpness

open EuclideanSpace

/-- The two-dimensional fiber used for the counterexample. -/
abbrev E2 := EuclideanSpace ℂ (Fin 2)

/-- `hₖ x = xₖ · e₀`: both "particles" push into the same direction. -/
noncomputable def hEx (k : Fin 2) : E2 →ₗ[ℂ] E2 :=
  LinearMap.smulRight (EuclideanSpace.projₗ (𝕜 := ℂ) k)
    (EuclideanSpace.single (0 : Fin 2) (1 : ℂ))

/-- `nₖ x = xₖ · eₖ`: the comparison operators are the coordinate
projections. -/
noncomputable def nEx (k : Fin 2) : E2 →ₗ[ℂ] E2 :=
  LinearMap.smulRight (EuclideanSpace.projₗ (𝕜 := ℂ) k) (EuclideanSpace.single k (1 : ℂ))

theorem norm_hEx (k : Fin 2) (x : E2) : ‖hEx k x‖ = ‖x k‖ := by
  simp [hEx, norm_smul]

theorem norm_nEx (k : Fin 2) (x : E2) : ‖nEx k x‖ = ‖x k‖ := by
  simp [nEx, norm_smul]

/-- The state on which the naive lifting fails: both coordinates equal to 1. -/
noncomputable def vEx : E2 :=
  EuclideanSpace.single (0 : Fin 2) (1 : ℂ) + EuclideanSpace.single (1 : Fin 2) (1 : ℂ)

theorem vEx_apply (i : Fin 2) : vEx i = 1 := by
  fin_cases i <;> simp [vEx, EuclideanSpace.single_apply]

theorem norm_vEx_sq : ‖vEx‖ ^ 2 = 2 := by
  rw [EuclideanSpace.norm_eq, Real.sq_sqrt (by positivity)]
  simp [vEx_apply]

theorem sum_nEx_vEx : (nEx 0 + nEx 1) vEx = vEx := by
  simp [nEx, vEx]

theorem sum_hEx_vEx :
    (hEx 0 + hEx 1) vEx = (2 : ℂ) • EuclideanSpace.single (0 : Fin 2) (1 : ℂ) := by
  simp only [LinearMap.add_apply, hEx, LinearMap.smulRight_apply, ← add_smul]
  rw [show (EuclideanSpace.projₗ (𝕜 := ℂ) (0 : Fin 2)) vEx = vEx 0 from rfl,
    show (EuclideanSpace.projₗ (𝕜 := ℂ) (1 : Fin 2)) vEx = vEx 1 from rfl,
    vEx_apply, vEx_apply]
  norm_num

/-- **The informal Fock-space argument for the operator bound is not valid.**
The step `∑ₖ ‖hₖΨ‖ ≤ c ∑ₖ ‖nₖΨ‖ ≤ c ‖N̂Ψ‖` uses the triangle inequality in the
wrong direction: `∑ₖ ‖nₖΨ‖` can exceed `‖∑ₖ nₖΨ‖`.  Concretely there are two
pairs of operators with `‖hₖ x‖ ≤ ‖nₖ x‖` for every `x` and every `k`, and a
state on which the sums violate the same bound.  This is why
`norm_sum_le_of_pairwise` assumes the *pairwise* domination. -/
theorem not_forall_norm_sum_le_of_pointwise :
    ∃ (h n : Fin 2 → (E2 →ₗ[ℂ] E2)) (v : E2),
      (∀ (k : Fin 2) (x : E2), ‖h k x‖ ≤ ‖n k x‖) ∧
        ‖(n 0 + n 1) v‖ < ‖(h 0 + h 1) v‖ := by
  refine ⟨hEx, nEx, vEx, fun k x => le_of_eq (by rw [norm_hEx, norm_nEx]), ?_⟩
  have hn : ‖(nEx 0 + nEx 1) vEx‖ ^ 2 = 2 := by
    rw [sum_nEx_vEx]; exact norm_vEx_sq
  have hh : ‖(hEx 0 + hEx 1) vEx‖ = 2 := by
    rw [sum_hEx_vEx, norm_smul, EuclideanSpace.norm_single]
    norm_num
  rw [hh]
  nlinarith [hn, norm_nonneg ((nEx 0 + nEx 1) vEx)]

end Sharpness

end FarisLavineLift

end BookProof.NavierStokesFlow
