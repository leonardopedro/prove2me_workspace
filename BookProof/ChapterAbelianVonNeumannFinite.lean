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

/-- **Commuting with a diagonal matrix with distinct entries forces diagonality.** -/
theorem commutes_diagonal_iff (e : n → ℂ) (he : Function.Injective e) (M : Matrix n n ℂ) :
    M * diagonal e = diagonal e * M ↔ ∃ d : n → ℂ, M = diagonal d := by
  constructor
  · intro h
    refine ⟨fun i => M i i, ?_⟩
    ext i j
    rcases eq_or_ne i j with rfl | hij
    · simp
    · have hthis := congrFun (congrFun h i) j
      simp only [Matrix.mul_apply, Matrix.diagonal_apply, Finset.sum_ite_eq',
        Finset.mem_univ, if_true, mul_ite, ite_mul, zero_mul, mul_zero,
        Finset.sum_ite_eq] at hthis
      have hne : e j - e i ≠ 0 := sub_ne_zero.mpr (fun hc => hij (he hc).symm)
      have hzero : M i j * (e j - e i) = 0 := by ring_nf; linear_combination hthis
      have hMij : M i j = 0 := (mul_eq_zero.mp hzero).resolve_right hne
      simp [Matrix.diagonal_apply_ne _ hij, hMij]
  · rintro ⟨d, rfl⟩
    rw [diagonal_mul_diagonal, diagonal_mul_diagonal]
    simp [mul_comm]

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

theorem diagonalStarAlgHom_injective :
    Function.Injective (diagonalStarAlgHom : (n → ℂ) →⋆ₐ[ℂ] Matrix n n ℂ) := by
  intro d d' h
  funext i
  have := congrFun (congrFun h i) i
  simpa using this

/-- The copy of `ℓ∞({1,…,n})` obtained by conjugating the diagonal matrices with a
unitary `U`: still a unital `*`-algebra homomorphism. -/
def conjDiagonal (U : Matrix.unitaryGroup n ℂ) : (n → ℂ) →⋆ₐ[ℂ] Matrix n n ℂ :=
  ((Unitary.conjStarAlgAut ℂ (Matrix n n ℂ) U : Matrix n n ℂ ≃⋆ₐ[ℂ] Matrix n n ℂ) :
      Matrix n n ℂ →⋆ₐ[ℂ] Matrix n n ℂ).comp diagonalStarAlgHom

@[simp] theorem conjDiagonal_apply (U : Matrix.unitaryGroup n ℂ) (d : n → ℂ) :
    conjDiagonal U d = (Unitary.conjStarAlgAut ℂ (Matrix n n ℂ) U) (diagonal d) := rfl

theorem conjDiagonal_injective (U : Matrix.unitaryGroup n ℂ) :
    Function.Injective (conjDiagonal U) := by
  intro d d' h
  refine diagonalStarAlgHom_injective ?_
  simpa [conjDiagonal_apply] using
    (Unitary.conjStarAlgAut ℂ (Matrix n n ℂ) U).injective h

/-- **Headline.**  For a Hermitian matrix with pairwise distinct eigenvalues, the
commutant is exactly the unitary conjugate of the diagonal algebra — a faithful
copy of `ℓ∞({1,…,n})`. -/
theorem commutant_eq_range_conjDiagonal {A : Matrix n n ℂ} (hA : A.IsHermitian)
    (hdist : Function.Injective hA.eigenvalues) :
    {M : Matrix n n ℂ | M * A = A * M} = Set.range (conjDiagonal hA.eigenvectorUnitary) := by
  classical
  set c := Unitary.conjStarAlgAut ℂ (Matrix n n ℂ) hA.eigenvectorUnitary with hc
  set e : n → ℂ := RCLike.ofReal ∘ hA.eigenvalues with he
  have hAeq : A = c (diagonal e) := hA.spectral_theorem
  have heinj : Function.Injective e := by
    intro i j hij
    exact hdist (by simpa [he, Complex.ofReal_inj] using hij)
  ext M
  simp only [Set.mem_setOf_eq, Set.mem_range]
  constructor
  · intro h
    have h' : c.symm M * diagonal e = diagonal e * c.symm M := by
      have h1 : c.symm (M * A) = c.symm M * c.symm A := map_mul _ _ _
      have h2 : c.symm (A * M) = c.symm A * c.symm M := map_mul _ _ _
      have hcA : c.symm A = diagonal e := by rw [hAeq]; exact c.symm_apply_apply _
      rw [hcA] at h1 h2
      rw [← h1, ← h2, h]
    obtain ⟨d, hd⟩ := (commutes_diagonal_iff e heinj (c.symm M)).1 h'
    refine ⟨d, ?_⟩
    rw [conjDiagonal_apply, ← hc, ← hd, c.apply_symm_apply]
  · rintro ⟨d, rfl⟩
    have hcomm : diagonal d * diagonal e = diagonal e * diagonal d := by
      rw [diagonal_mul_diagonal, diagonal_mul_diagonal]
      simp [mul_comm]
    have hc2 := congrArg c hcomm
    rw [map_mul, map_mul] at hc2
    rw [conjDiagonal_apply, ← hc, hAeq]
    exact hc2

/-- Packaged form: the algebra of matrices commuting with a Hermitian matrix with
distinct eigenvalues is a faithful `*`-algebra copy of `ℓ∞({1,…,n})` — the first
type in the book's list of abelian von Neumann algebras. -/
theorem abelian_commutant_isomorphic_ellInfty {A : Matrix n n ℂ} (hA : A.IsHermitian)
    (hdist : Function.Injective hA.eigenvalues) :
    ∃ f : (n → ℂ) →⋆ₐ[ℂ] Matrix n n ℂ,
      Function.Injective f ∧ Set.range f = {M : Matrix n n ℂ | M * A = A * M} :=
  ⟨conjDiagonal hA.eigenvectorUnitary, conjDiagonal_injective _,
    (commutant_eq_range_conjDiagonal hA hdist).symm⟩

end BookProof.ChapterAbelianVonNeumannFinite
