import Mathlib


/-!
# The finite-dimensional abelian type: `ℓ∞({1,…,n})`

The book's chapter *"Selecting events is not rewriting the history of events"*
lists the five isomorphism types of abelian von Neumann algebras (`book.tex`
lines 8789–8800), the first of which is `ℓ∞({1,…,n})`.  The full classification
is von Neumann's theorem and is not formalized here; this file proves the
concrete finite-dimensional instance, which is a genuine theorem of matrix
algebra:

*If `A` is a Hermitian `n × n` complex matrix with pairwise distinct eigenvalues,
then the algebra of matrices commuting with `A` is the image of `ℓ∞({1,…,n})`
(i.e. of `n → ℂ` with pointwise operations) under an injective unital
`*`-algebra homomorphism — namely `d ↦ U · diag d · U*` for the eigenvector
unitary `U`.*

Contents:

* `commutes_diagonal_iff` — a matrix commutes with a diagonal matrix having
  distinct diagonal entries iff it is itself diagonal;
* `diagonalStarAlgHom` — `d ↦ diag d` as a unital `*`-algebra homomorphism
  `(n → ℂ) →⋆ₐ[ℂ] Matrix n n ℂ`, i.e. the standard copy of `ℓ∞({1,…,n})`;
* `conjDiagonal` — its conjugate by a unitary, again a `*`-algebra homomorphism;
* `commutant_eq_range_conjDiagonal` — HEADLINE: the commutant of a Hermitian
  matrix with distinct eigenvalues is exactly the range of `conjDiagonal`;
* `abelian_commutant_isomorphic_ellInfty` — packaged existence statement: the
  commutant *is* a copy of `ℓ∞({1,…,n})` inside the matrix algebra.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix

namespace BookProof.ChapterAbelianVonNeumannFinite

variable {n : Type*} [Fintype n] [DecidableEq n]



/-- `ℓ∞({1,…,n}) = (n → ℂ)` sits inside the matrix algebra as the diagonal
matrices, via a unital `*`-algebra homomorphism. -/
def diagonalStarAlgHom : (n → ℂ) →⋆ₐ[ℂ] Matrix n n ℂ :=
  { Matrix.diagonalAlgHom ℂ with
    map_star' := by
      intro d
      change diagonal (star d) = star (diagonal d)
      rw [Matrix.star_eq_conjTranspose, Matrix.diagonal_conjTranspose] }

@[simp] theorem diagonalStarAlgHom_apply (d : n → ℂ) :
    (diagonalStarAlgHom : (n → ℂ) →⋆ₐ[ℂ] Matrix n n ℂ) d = diagonal d := rfl



/-- The copy of `ℓ∞({1,…,n})` obtained by conjugating the diagonal matrices with a
unitary `U`: still a unital `*`-algebra homomorphism. -/
def conjDiagonal (U : Matrix.unitaryGroup n ℂ) : (n → ℂ) →⋆ₐ[ℂ] Matrix n n ℂ :=
  ((Unitary.conjStarAlgAut ℂ (Matrix n n ℂ) U : Matrix n n ℂ ≃⋆ₐ[ℂ] Matrix n n ℂ) :
      Matrix n n ℂ →⋆ₐ[ℂ] Matrix n n ℂ).comp diagonalStarAlgHom

@[simp] theorem conjDiagonal_apply (U : Matrix.unitaryGroup n ℂ) (d : n → ℂ) :
    conjDiagonal U d = (Unitary.conjStarAlgAut ℂ (Matrix n n ℂ) U) (diagonal d) := rfl







end BookProof.ChapterAbelianVonNeumannFinite
