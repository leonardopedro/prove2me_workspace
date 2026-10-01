-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.norm_sum_le_of_pairwise
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_norm_sum_sq_eq
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_coe_sum_apply
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift





open FullEsa

set_option maxHeartbeats 1000000 in
 :=
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
        refine (FullEsa.diagOp_comp (p i) (p i)).trans ?_
        simp [sq]
      rw [Finset.sum_congr rfl fun i _ => hcomp i]
      exact (FullEsa.diagOp_sum (Finset.univ : Finset (Fin d)) fun i k => p i k ^ 2).trans rfl
    have hdrift : (∑ i, ((diagComparisonData d p q).drift i).comp
        ((diagComparisonData d p q).drift i)) = diagOp (fun k => ∑ i, q i k ^ 2) := by
      have hcomp : ∀ i : Fin d, ((diagComparisonData d p q).drift i).comp
          ((diagComparisonData d p q).drift i) = diagOp (fun k => q i k ^ 2) := by
        intro i
        refine (FullEsa.diagOp_comp (q i) (q i)).trans ?_
        simp [sq]
      rw [Finset.sum_congr rfl fun i _ => hcomp i]
      exact (FullEsa.diagOp_sum (Finset.univ : Finset (Fin d)) fun i k => q i k ^ 2).trans rfl
    rw [ComparisonData.comparison, hmom, hdrift]
    have h1 :
        (diagOp fun k => ∑ i, p i k ^ 2) + (diagOp fun k => ∑ i, q i k ^ 2)
            + (LinearMap.id : lpFiniteModes ℕ →ₗ[ℂ] lpFiniteModes ℕ)
          = diagOp (fun k => (∑ i, p i k ^ 2) + (∑ i, q i k ^ 2) + 1) := by
      rw [diagOp_one, FullEsa.diagOp_add, FullEsa.diagOp_add]
      all_goals rfl
    exact h1
  
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
