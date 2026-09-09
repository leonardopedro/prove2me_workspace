import Mathlib

/-!
# The finite (type `I_n`) case of the abelian von Neumann classification

`BookProof/ChapterSelectingEvents.lean` (book Chapter 13, `book.tex` ~8789–8800)
records von Neumann's classification of abelian von Neumann algebras: every one
of them is `*`-isomorphic to one of

`ℓ∞({1,…,n})`, `ℓ∞(ℕ)`, `L∞([0,1])`, `L∞([0,1] ∪ {1,…,n})`, `L∞([0,1] ∪ ℕ)`.

The full five-way classification is a deep theorem and is *not* claimed here.
What **is** proved in this file is its first case, in the concrete
finite-dimensional model `Mat(n, ℂ)`:

* `diagonalStarAlgHom` — the `*`-algebra embedding `ℓ∞({1,…,n}) = (n → ℂ) →
  Mat(n, ℂ)` given by `d ↦ diag(d)`, and `diagonalStarAlgHom_injective`;
* `diagonal_commute` — its image is abelian;
* `commutant_diagonal_eq_diagonal` — its image is **maximal** abelian: anything
  commuting with all diagonal matrices is itself diagonal;
* `vonNeumann_abelian_typeI_case` — the headline packaging: `ℓ∞({1,…,n})` is
  realized inside `Mat(n, ℂ)` as a maximal abelian self-adjoint subalgebra.

All results are `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

namespace BookProof.AbelianDiagonal

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- The `*`-algebra embedding of `ℓ∞({1,…,n}) = (n → ℂ)` into `Mat(n, ℂ)`,
`d ↦ diag(d)`. -/
noncomputable def diagonalStarAlgHom : (n → ℂ) →⋆ₐ[ℂ] Matrix n n ℂ where
  toFun d := Matrix.diagonal d
  map_one' := Matrix.diagonal_one
  map_mul' d e := (Matrix.diagonal_mul_diagonal d e).symm
  map_zero' := Matrix.diagonal_zero
  map_add' d e := (Matrix.diagonal_add d e).symm
  commutes' r := by
    ext i j
    by_cases h : i = j <;> simp [h, Algebra.algebraMap_eq_smul_one]
  map_star' d := by
    simp [Matrix.star_eq_conjTranspose]

@[simp] theorem diagonalStarAlgHom_apply (d : n → ℂ) :
    (diagonalStarAlgHom d : Matrix n n ℂ) = Matrix.diagonal d := rfl

/-- The embedding is injective: `ℓ∞({1,…,n})` sits inside `Mat(n, ℂ)`. -/
theorem diagonalStarAlgHom_injective :
    Function.Injective (diagonalStarAlgHom : (n → ℂ) →⋆ₐ[ℂ] Matrix n n ℂ) :=
  fun _ _ h => Matrix.diagonal_injective h

/-- The diagonal algebra is abelian. -/
theorem diagonal_commute (d e : n → ℂ) :
    Matrix.diagonal d * Matrix.diagonal e = Matrix.diagonal e * Matrix.diagonal d := by
  rw [Matrix.diagonal_mul_diagonal, Matrix.diagonal_mul_diagonal]
  simp [mul_comm]

/-- **Maximal abelianness.**  Any matrix commuting with every diagonal matrix is
itself diagonal.  Hence the diagonal algebra is its own commutant: it is a
maximal abelian self-adjoint subalgebra (MASA) of `Mat(n, ℂ)`. -/
theorem commutant_diagonal_eq_diagonal (M : Matrix n n ℂ)
    (h : ∀ d : n → ℂ, M * Matrix.diagonal d = Matrix.diagonal d * M) :
    M = Matrix.diagonal (fun i => M i i) := by
  ext i j
  rcases eq_or_ne i j with rfl | hij
  · simp
  · have hd := congrFun (congrFun (h (Pi.single i 1)) i) j
    rw [Matrix.mul_diagonal, Matrix.diagonal_mul] at hd
    rw [Matrix.diagonal_apply_ne _ hij]
    simpa [Pi.single_apply, hij, Ne.symm hij] using hd.symm

/-- Conversely, a diagonal matrix commutes with every diagonal matrix. -/
theorem mem_commutant_of_diagonal (e : n → ℂ) (d : n → ℂ) :
    Matrix.diagonal e * Matrix.diagonal d = Matrix.diagonal d * Matrix.diagonal e :=
  diagonal_commute e d

/-- **Headline: the finite (type `I_n`) case of the abelian von Neumann
classification.**  Inside `Mat(n, ℂ)` the algebra `ℓ∞({1,…,n}) = (n → ℂ)` is
realized, by an injective `*`-algebra map, as an abelian subalgebra which is
exactly its own commutant.

This is the first of von Neumann's five isomorphism classes; the remaining four
(and the exhaustiveness of the list) are not claimed here. -/
theorem vonNeumann_abelian_typeI_case :
    Function.Injective (diagonalStarAlgHom : (n → ℂ) →⋆ₐ[ℂ] Matrix n n ℂ) ∧
      (∀ d e : n → ℂ,
        Matrix.diagonal d * Matrix.diagonal e = Matrix.diagonal e * Matrix.diagonal d) ∧
      (∀ M : Matrix n n ℂ,
        (∀ d : n → ℂ, M * Matrix.diagonal d = Matrix.diagonal d * M) ↔
          ∃ e : n → ℂ, M = Matrix.diagonal e) := by
  refine ⟨diagonalStarAlgHom_injective, diagonal_commute, fun M => ⟨fun h => ?_, ?_⟩⟩
  · exact ⟨fun i => M i i, commutant_diagonal_eq_diagonal M h⟩
  · rintro ⟨e, rfl⟩ d
    exact diagonal_commute e d

end BookProof.AbelianDiagonal
