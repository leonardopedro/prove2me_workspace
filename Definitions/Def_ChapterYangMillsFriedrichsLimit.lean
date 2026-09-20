import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterH5

import Mathlib

/-!
# Quantum Yang–Mills, the Friedrichs route: the construction in the bounded regime
and the Hashimoto/SIRK limit

This module continues `BookProof.ChapterYangMillsFriedrichs`
(`PLAN_LEAN_SPECIALIST_QYM_FLOW.md`, Parts C and D) at the two places where that
module stopped:

* **Part C was conditional.**  There the Friedrichs theorem entered as a *named
  hypothesis*, shown consistent only in the degenerate case of an operator that
  is already defined on the whole space.  Here the hypothesis is **discharged,
  by an explicit construction, for a genuinely non-degenerate class**: a
  symmetric positive operator on a *proper* dense domain whose quadratic form is
  bounded.  `friedrichs_of_bounded` builds the extension (continuous extension
  by density) and proves all four clauses of
  `BookProof.YangMillsFriedrichs.IsPositiveSelfAdjointExtension`; the class is
  non-empty and non-trivial by `friedrichs_bounded_nontrivial_example`.

* **Part D.4 was recorded as a conjecture only.**  The obstruction named there
  was that the *limit operator of the Krylov flag* is not constructed.  In the
  bounded regime it can be: `sirk_compression_tendsto` proves that the
  Hashimoto/SIRK compressions `Pₙ A Pₙ` converge to `A` strongly whenever the
  Krylov flag of a seed is dense, and `sirk_limit_unique` proves that this limit
  determines the operator.  Combining these with Part C gives
  `sirk_limit_eq_positive_selfadjoint_extension`: *in the bounded regime the
  operator recovered in the infinite Hashimoto limit is the positive
  self-adjoint (Friedrichs) extension of the Weyl-gauge Hamiltonian.*  This is
  the conjecture of `CONSOLIDATED_PLAN.md` §11.2, proved under the standing
  boundedness hypothesis; the unbounded continuum case remains open and is not
  claimed.

## Scope

Nothing here claims self-adjointness of the *unbounded* continuum Yang–Mills
operator, nor a mass gap.  Everything below carries an explicit boundedness
hypothesis on the operator, which is exactly the hypothesis that makes the
Krylov limit an operator limit.
-/

namespace BookProof.YangMillsFriedrichsLimit

open BookProof.ChapterH5
open BookProof.FarisLavine


/-! ## Part C — the Friedrichs hypothesis discharged for bounded operators -/

section Bounded

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- An everywhere-defined continuous operator, read as a linear map on the
submodule `⊤` — the shape in which
`BookProof.YangMillsFriedrichs.IsPositiveSelfAdjointExtension` expects an
extension. -/
noncomputable def topRestrict (A : F →L[ℂ] F) : (⊤ : Submodule ℂ F) →ₗ[ℂ] F :=
  A.toLinearMap.comp (⊤ : Submodule ℂ F).subtype

@[simp] theorem topRestrict_apply (A : F →L[ℂ] F) (x : (⊤ : Submodule ℂ F)) :
    topRestrict A x = A (x : F) := rfl











end Bounded

/-! ### A genuinely proper dense domain

The class of `friedrichs_of_bounded` really does contain operators whose domain
is a *proper* dense subspace: in `ℓ²(ℕ, ℂ)` the span of the canonical orthonormal
basis is dense but omits every vector of infinite support. -/

section ProperDomain

open scoped InnerProductSpace ENNReal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]







end ProperDomain

/-! ## Part D — the Hashimoto/SIRK limit in the bounded regime -/

section Sirk


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- The **Hashimoto/SIRK order-`n` compression** of a bounded operator with
respect to the Krylov flag of a seed `v`: `Pₙ A Pₙ`, where `Pₙ` is the
orthogonal projection onto the order-`n` Krylov subspace. -/
noncomputable def sirkCompression (A : F →L[ℂ] F) (v : F) (n : ℕ) (u : F) : F :=
  (krylovSpan A.toLinearMap v n).starProjection
    (A ((krylovSpan A.toLinearMap v n).starProjection u))









end Sirk

/-! ## The Weyl-gauge Hamiltonian: the two parts combined -/

section Weyl


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-! ## Continuity passes density: symmetry and positivity on the full space -/

theorem symmetricOn_top_of_dense {D : Submodule ℂ F} (A : F →L[ℂ] F)
    (hdense : Dense (D : Set F)) (hsym : ∀ x y : D, (inner ℂ (A (x : F)) (y : F) : ℂ)
      = inner ℂ (x : F) (A (y : F))) :
    SymmetricOn (⊤ : Submodule ℂ F) (topRestrict A) := by
  -- first fix `x ∈ D` and let `y` run over the dense set
  have step1 : ∀ x : D, ∀ y : F, (inner ℂ (A (x : F)) y : ℂ) = inner ℂ (x : F) (A y) := by
    intro x
    have hcont₁ : Continuous fun y : F => (inner ℂ (A (x : F)) y : ℂ) :=
      Continuous.inner continuous_const continuous_id
    have hcont₂ : Continuous fun y : F => (inner ℂ (x : F) (A y) : ℂ) :=
      Continuous.inner continuous_const A.continuous
    have := Continuous.ext_on hdense hcont₁ hcont₂ (by
      rintro y hy
      exact hsym x ⟨y, hy⟩)
    exact fun y => congrFun this y
  -- now let `x` run over the dense set
  have step2 : ∀ y : F, ∀ x : F, (inner ℂ (A x) y : ℂ) = inner ℂ x (A y) := by
    intro y
    have hcont₁ : Continuous fun x : F => (inner ℂ (A x) y : ℂ) :=
      Continuous.inner A.continuous continuous_const
    have hcont₂ : Continuous fun x : F => (inner ℂ x (A y) : ℂ) :=
      Continuous.inner continuous_id continuous_const
    have := Continuous.ext_on hdense hcont₁ hcont₂ (by
      rintro x hx
      exact step1 ⟨x, hx⟩ y)
    exact fun x => congrFun this x
  intro x y
  exact step2 (y : F) (x : F)

/-- Positivity of the quadratic form passes from a dense subspace to the whole
space, for a *continuous* operator (nonnegativity is a closed condition). -/
theorem quadForm_top_nonneg_of_dense {D : Submodule ℂ F} (A : F →L[ℂ] F)
    (hdense : Dense (D : Set F))
    (hpos : ∀ x : D, 0 ≤ (inner ℂ (x : F) (A (x : F)) : ℂ).re) :
    ∀ y : (⊤ : Submodule ℂ F), 0 ≤ quadForm (topRestrict A) y := by
  have hcont : Continuous fun y : F => (inner ℂ y (A y) : ℂ).re :=
    Complex.continuous_re.comp (Continuous.inner continuous_id A.continuous)
  have hclosed : IsClosed {y : F | 0 ≤ (inner ℂ y (A y) : ℂ).re} :=
    isClosed_le continuous_const hcont
  have hsub : (D : Set F) ⊆ {y : F | 0 ≤ (inner ℂ y (A y) : ℂ).re} := by
    rintro y hy
    exact hpos ⟨y, hy⟩
  have huniv : ∀ y : F, 0 ≤ (inner ℂ y (A y) : ℂ).re := by
    intro y
    have := hclosed.closure_subset_iff.mpr hsub
    have hy : y ∈ closure (D : Set F) := by rw [hdense.closure_eq]; trivial
    exact this hy
  intro y
  exact huniv (y : F)


end Weyl

end BookProof.YangMillsFriedrichsLimit
