import Mathlib
import BookProof.ChapterParity
import BookProof.ChapterParitySU2

/-!
# Chapter "On the physical parity transformation and antiparticles" — the custodial
commutant and the Pauli basis

This file continues the finite algebraic core of the `book.tex` chapter *"On the physical
parity transformation and antiparticles"* (`book.tex` line ~7522, §"Majorana spinors in
the Standard Model").  The chapter's footnote on the gauge-invariant products records the
representation-theoretic fact underlying the **custodial `SU(2)`**:

  *"the basis of matrices commuting with the generators of `SU(2)_L` is `{1, iσ_j}`, with
  `j = 1, 2, 3`, for a total of 4 matrices."*

Two clean, self-contained algebraic facts underlie this.

* **Schur's lemma for the doublet.**  On a single `SU(2)` doublet the generators act by
  the three Pauli matrices `σ₁, σ₂, σ₃`, which act *irreducibly*: the only matrices
  commuting with all three are the scalars `c · 1`.  This is `commutant_pauli_scalar`.
  (The four-dimensional custodial commutant `{1, iσ_j}` of the footnote is this scalar
  commutant on the *other* tensor factor of the Higgs/quark bidoublet — see
  `ChapterParityHiggs` for the bidoublet structure.)

* **The Pauli basis.**  The identity together with the three Pauli matrices,
  `{1, σ₁, σ₂, σ₃}`, are linearly independent over `ℂ` and hence form a basis of the
  `2×2` complex matrices; the custodial generators `{1, iσ_j}` are the same four matrices
  up to the scalar `i`, so they too are four linearly independent matrices.  This is
  `pauli_basis_indep`.

## Contents

* `commutant_pauli_scalar` : a `2×2` matrix commuting with `σ₁, σ₂, σ₃` is scalar,
  `M = (M 0 0) • 1`.
* `pauli_basis_indep` : `{1, σ₁, σ₂, σ₃}` are linearly independent over `ℂ`.

The surrounding physical modelling (the Standard-Model gauge structure, the counting of
gauge-invariant Yukawa products) is left as prose.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix
open scoped ComplexConjugate

namespace BookProof.ChapterParityCustodial

open BookProof.ChapterParity BookProof.ChapterParitySU2

/-- **Schur's lemma for the `SU(2)` doublet.**  The Pauli matrices `σ₁, σ₂, σ₃` act
irreducibly on `ℂ²`: any matrix `M` commuting with all three is a scalar multiple of the
identity, `M = (M 0 0) • 1`.
-/
theorem commutant_pauli_scalar (M : Matrix (Fin 2) (Fin 2) ℂ)
    (h1 : M * pauli1 = pauli1 * M) (_h2 : M * pauli2 = pauli2 * M)
    (h3 : M * pauli3 = pauli3 * M) :
    M = (M 0 0) • (1 : Matrix (Fin 2) (Fin 2) ℂ) := by
  simp_all only [← ext_iff, mul_apply, Fin.sum_univ_succ, Fin.isValue, Finset.univ_unique,
    Fin.default_eq_zero, Finset.sum_singleton, Fin.succ_zero_eq_one, mul_comm,
    Fin.forall_fin_two, add_right_inj, add_left_inj, smul_apply, one_apply, smul_eq_mul,
    ite_mul, one_mul, zero_mul, ↓reduceIte, zero_ne_one, true_and, one_ne_zero]
  unfold pauli1 pauli2 pauli3 at *
  norm_num at *
  grind

/-- **The Pauli basis.**  The identity and the three Pauli matrices `{1, σ₁, σ₂, σ₃}` are
linearly independent over `ℂ`: if `c₀ • 1 + c₁ • σ₁ + c₂ • σ₂ + c₃ • σ₃ = 0` then all
coefficients vanish.  Hence they form a basis of `Matrix (Fin 2) (Fin 2) ℂ`, and the
custodial generators `{1, iσ_j}` (the same matrices scaled by `i`) are likewise four
linearly independent matrices.
-/
theorem pauli_basis_indep (c0 c1 c2 c3 : ℂ)
    (h : c0 • (1 : Matrix (Fin 2) (Fin 2) ℂ) + c1 • pauli1 + c2 • pauli2 + c3 • pauli3 = 0) :
    c0 = 0 ∧ c1 = 0 ∧ c2 = 0 ∧ c3 = 0 := by
  unfold pauli1 pauli2 pauli3 at h
  simp_all only [smul_of, smul_cons, smul_eq_mul, mul_zero, mul_one, smul_empty, mul_neg, ← ext_iff,
      add_apply, smul_apply, of_apply, cons_val', cons_val_fin_one, zero_apply, Fin.forall_fin_two,
          Fin.isValue, cons_val_zero, cons_val_one, one_apply_eq, add_zero, ne_eq, zero_ne_one,
              not_false_eq_true, one_apply_ne, zero_add, one_ne_zero]
  simp_all only [add_eq_zero_iff_eq_neg, Complex.ext_iff, Complex.neg_re, Complex.neg_im, neg_neg,
      Complex.mul_re, Complex.I_re, mul_zero, Complex.I_im, mul_one, zero_sub, Complex.mul_im,
          add_zero, Complex.zero_re, neg_eq_zero, Complex.zero_im]
  refine ⟨⟨by linarith, by linarith⟩, ⟨by linarith, by linarith⟩,
    ⟨by linarith, by linarith⟩, by linarith, by linarith⟩

end BookProof.ChapterParityCustodial
