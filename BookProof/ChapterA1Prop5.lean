import Mathlib
import BookProof.ChapterA1

/-!
# Chapter A, §A.1 — Proposition 5: (anti-)unitarity is a realification-invariant

This file formalizes `book.tex` **Proposition 5** (§"Systems on real and complex
Hilbert spaces", line ~4797) of the chapter *"Real representations, CPT theorem
and the relativistic position operator"*.

**Note 4** of the book defines: an (anti-)linear operator `U : H₁ → H₂` between
inner-product spaces is *(anti-)unitary* iff
1) it is surjective, and
2) for all `x`, `⟪U x, U x⟫ = ⟪x, x⟫`.

**Proposition 5** states that for complex Hilbert spaces `H₁, H₂` and their
realifications `H₁ʳ, H₂ʳ`, the operator `U` is (anti-)unitary **iff** the operator
`Uʳ : H₁ʳ → H₂ʳ`, `Uʳ(h) := U(h)`, is (anti-)unitary.  The book's one-line proof:
`⟪h, h⟫ = ⟪h, h⟫ʳ` and `Uʳ(h) = U(h)`, so the two isometry conditions coincide.

We take the realification `H^r` to be the *same carrier type* equipped with the
real inner product `⟪v, u⟫_ℝ = re ⟪v, u⟫_ℂ` (Mathlib's
`InnerProductSpace.rclikeToReal`, registered here as a **local** instance to avoid
the real/complex inner-product diamond).  Then `Uʳ` is literally the same
underlying function `U`, matching the book's `Uʳ(h) = U(h)`, so surjectivity is
shared verbatim.  The mathematical content is the pointwise equivalence of the
two isometry conditions, `inner_self_complex_iff_real`, which needs **no**
(anti-)linearity of `U` at all — it holds for an arbitrary function.  Hence the
statement covers the unitary (linear) and anti-unitary (conjugate-linear) cases
uniformly; the two `LinearMap`/semilinear corollaries record this.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

namespace BookProof.ChapterA

-- The real inner-product structure on a complex inner-product space, from
-- `InnerProductSpace.rclikeToReal`.  Registered **locally** only (never global,
-- to avoid the well-known real/complex diamond).
attribute [local instance] InnerProductSpace.rclikeToReal

variable {H₁ H₂ : Type*} [NormedAddCommGroup H₁] [InnerProductSpace ℂ H₁]
  [NormedAddCommGroup H₂] [InnerProductSpace ℂ H₂]

/-! ## The heart of Proposition 5 -/

/-- **The isometry condition is realification-invariant.**  For an arbitrary map
`T : H₁ → H₂`, the complex diagonal-preservation condition `⟪T x, T x⟫_ℂ = ⟪x, x⟫_ℂ`
holds for all `x` **iff** the real diagonal-preservation condition
`⟪T x, T x⟫_ℝ = ⟪x, x⟫_ℝ` does.  This is the book's `⟪h, h⟫ = ⟪h, h⟫ʳ` step, and it
requires no linearity of `T`.

Forward: `⟪·,·⟫_ℝ = re ⟪·,·⟫_ℂ` (`real_inner_eq_re_inner`) turns the complex
equality into the real one.  Backward: `⟪y, y⟫_ℂ` is real (`inner_self_im = 0`),
so equality of real parts upgrades to equality of the complex inner products. -/
theorem inner_self_complex_iff_real (T : H₁ → H₂) :
    (∀ x, (inner ℂ (T x) (T x) : ℂ) = (inner ℂ x x : ℂ)) ↔
    (∀ x, (inner ℝ (T x) (T x) : ℝ) = (inner ℝ x x : ℝ)) := by
  constructor
  · intro h x
    rw [real_inner_eq_re_inner ℂ, real_inner_eq_re_inner ℂ, h]
  · intro h x
    have hr := h x
    rw [real_inner_eq_re_inner ℂ, real_inner_eq_re_inner ℂ] at hr
    apply RCLike.ext
    · exact hr
    · rw [inner_self_im, inner_self_im]

/-! ## Proposition 5 -/

/-- **Proposition 5.**  For complex Hilbert spaces `H₁, H₂` and their
realifications `H₁ʳ, H₂ʳ` (the same carriers with `⟪·,·⟫_ℝ = re ⟪·,·⟫_ℂ`), an
operator `U : H₁ → H₂` is (anti-)unitary — i.e. surjective and inner-preserving —
**iff** `Uʳ = U` is (anti-)unitary between the realifications.  As `Uʳ` is the
same underlying function, surjectivity is shared, and the two isometry conditions
coincide by `inner_self_complex_iff_real`.  Stated for a bare function `U`, so it
applies uniformly to the linear (unitary) and conjugate-linear (anti-unitary)
cases. -/
theorem prop5 (U : H₁ → H₂) :
    (Function.Surjective U ∧ ∀ x, (inner ℂ (U x) (U x) : ℂ) = (inner ℂ x x : ℂ)) ↔
    (Function.Surjective U ∧ ∀ x, (inner ℝ (U x) (U x) : ℝ) = (inner ℝ x x : ℝ)) :=
  and_congr Iff.rfl (inner_self_complex_iff_real U)

/-- **Proposition 5, unitary (ℂ-linear) case.**  A ℂ-linear operator `U` is
unitary (surjective + complex-inner-preserving) iff its realification is. -/
theorem prop5_linear (U : H₁ →ₗ[ℂ] H₂) :
    (Function.Surjective U ∧ ∀ x, (inner ℂ (U x) (U x) : ℂ) = (inner ℂ x x : ℂ)) ↔
    (Function.Surjective U ∧ ∀ x, (inner ℝ (U x) (U x) : ℝ) = (inner ℝ x x : ℝ)) :=
  prop5 (U : H₁ → H₂)

/-- **Proposition 5, anti-unitary (conjugate-linear) case.**  A conjugate-linear
operator `U` (semilinear over `starRingEnd ℂ`) is anti-unitary (surjective +
complex-inner-preserving) iff its realification is. -/
theorem prop5_antilinear (U : H₁ →ₗ⋆[ℂ] H₂) :
    (Function.Surjective U ∧ ∀ x, (inner ℂ (U x) (U x) : ℂ) = (inner ℂ x x : ℂ)) ↔
    (Function.Surjective U ∧ ∀ x, (inner ℝ (U x) (U x) : ℝ) = (inner ℝ x x : ℝ)) :=
  prop5 (U : H₁ → H₂)

end BookProof.ChapterA
