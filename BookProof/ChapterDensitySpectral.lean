import Mathlib

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
the density matrix as a **diagonal probability operator rotated by a unitary**

This file formalizes the self-contained finite-dimensional content of the last
paragraph of the section *"5. Free field parametrization in Bayesian inference and
Statistical Mechanics"* (`book.tex` line ~1706), where the book states:

> *"We can always define the density matrix through a diagonal operator rotated by
> a unitary operator, with the diagonal operator defining the marginal probability
> of the initial state and the unitary operator defining the conditioned
> probability of the final state conditioned by the initial state."*

Mathematically this is the **spectral decomposition of a density matrix**: any
density matrix `ρ` (Hermitian, positive semidefinite, unit trace) equals
`ρ = U · diag(d) · U†` where `U` is unitary and `d` is its eigenvalue vector,
which is a genuine **probability distribution** — each eigenvalue is nonnegative
(positive semidefiniteness) and they sum to `1` (unit trace).  The diagonal
`d` is the "marginal probability of the initial state"; the unitary `U` (the
eigenvector rotation) is the "conditioned probability of the final state".

Everything is over `Matrix n n ℂ` for a finite index set `n`, consistently with
the finite-dimensional models used throughout `BookProof`.  All results are
`sorry`-free and `axiom`-free (only `propext`, `Classical.choice`, `Quot.sound`).

We prove:

* `density_eigenvalues_nonneg` — the eigenvalues of a density matrix are `≥ 0`;
* `density_eigenvalues_sum_one` — the eigenvalues sum to `1` (so together with the
  previous result they form a probability distribution);
* `density_spectral` — the spectral decomposition `ρ = U · diag(eigenvalues) · U†`
  (the "diagonal operator rotated by a unitary");
* `isDensityMatrix_of_unitary_diagonal` — the **converse**: for any unitary `U`
  and any probability distribution `d`, the matrix `U · diag(d) · U†` is a density
  matrix;
* `density_iff_exists_unitary_diagonal` — the **headline** characterization: a
  matrix is a density matrix **iff** it is a probability-diagonal operator rotated
  by a unitary.
-/

namespace BookProof.DensitySpectral

open Matrix
open scoped BigOperators ComplexOrder

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- A **density matrix**: Hermitian, positive semidefinite, of unit trace. -/
def IsDensityMatrix (ρ : Matrix n n ℂ) : Prop :=
  ρ.IsHermitian ∧ ρ.PosSemidef ∧ ρ.trace = 1

/-- The eigenvalues of a density matrix are nonnegative (positive semidefiniteness). -/
theorem density_eigenvalues_nonneg {ρ : Matrix n n ℂ} (h : IsDensityMatrix ρ) (i : n) :
    0 ≤ h.1.eigenvalues i :=
  h.2.1.eigenvalues_nonneg i

/-- The eigenvalues of a density matrix sum to `1` (unit trace). Together with
`density_eigenvalues_nonneg` this makes the eigenvalue vector a probability
distribution — the book's "marginal probability of the initial state". -/
theorem density_eigenvalues_sum_one {ρ : Matrix n n ℂ} (h : IsDensityMatrix ρ) :
    ∑ i, h.1.eigenvalues i = 1 := by
  have htr : ρ.trace = ∑ i, ((h.1.eigenvalues i : ℝ) : ℂ) := h.1.trace_eq_sum_eigenvalues
  have hsum : ∑ i, ((h.1.eigenvalues i : ℝ) : ℂ) = 1 := htr.symm.trans h.2.2
  have hcast : ((∑ i, h.1.eigenvalues i : ℝ) : ℂ) = 1 := by rw [Complex.ofReal_sum]; exact hsum
  exact_mod_cast hcast

/-- **Spectral decomposition of a density matrix.** Every density matrix is a
diagonal operator (its eigenvalues) rotated by the unitary of its eigenvectors:
`ρ = U · diag(eigenvalues) · U†`. -/
theorem density_spectral {ρ : Matrix n n ℂ} (h : IsDensityMatrix ρ) :
    ρ = (h.1.eigenvectorUnitary : Matrix n n ℂ)
        * diagonal (RCLike.ofReal ∘ h.1.eigenvalues)
        * (h.1.eigenvectorUnitary : Matrix n n ℂ)ᴴ := by
  have hs := h.1.spectral_theorem
  rw [Unitary.conjStarAlgAut_apply] at hs
  simpa [Matrix.star_eq_conjTranspose] using hs

/-- **Converse.** For any unitary `U` and any probability distribution `d` (nonnegative
entries summing to `1`), the matrix `U · diag(d) · U†` is a density matrix. -/
theorem isDensityMatrix_of_unitary_diagonal
    (U : Matrix.unitaryGroup n ℂ) (d : n → ℝ)
    (hd : ∀ i, 0 ≤ d i) (hsum : ∑ i, d i = 1) :
    IsDensityMatrix ((U : Matrix n n ℂ) * diagonal (RCLike.ofReal ∘ d)
      * (U : Matrix n n ℂ)ᴴ) := by
  set D : Matrix n n ℂ := diagonal (RCLike.ofReal ∘ d) with hD
  have hDherm : D.IsHermitian := by
    rw [hD, Matrix.IsHermitian, Matrix.diagonal_conjTranspose]
    congr 1; funext i; simp [Function.comp]
  have hUstarU : (U : Matrix n n ℂ)ᴴ * (U : Matrix n n ℂ) = 1 := by
    have := Matrix.UnitaryGroup.star_mul_self U
    simpa [Matrix.star_eq_conjTranspose] using this
  refine ⟨?_, ?_, ?_⟩
  · unfold Matrix.IsHermitian
    rw [Matrix.conjTranspose_mul, Matrix.conjTranspose_mul, Matrix.conjTranspose_conjTranspose,
      hDherm, Matrix.mul_assoc]
  · have hDpsd : D.PosSemidef := by
      rw [hD, Matrix.posSemidef_diagonal_iff]
      intro i; simp only [Function.comp]; rw [RCLike.ofReal_nonneg]; exact hd i
    exact hDpsd.mul_mul_conjTranspose_same (U : Matrix n n ℂ)
  · rw [Matrix.trace_mul_comm, ← Matrix.mul_assoc, hUstarU, Matrix.one_mul, hD,
      Matrix.trace_diagonal]
    simp only [Function.comp]
    rw [← RCLike.ofReal_sum, hsum, RCLike.ofReal_one]

/-- **Headline (book §5).** A complex matrix is a density matrix iff it is a diagonal
probability operator rotated by a unitary: `ρ = U · diag(d) · U†` with `d` a probability
distribution (nonnegative, summing to `1`). -/
theorem density_iff_exists_unitary_diagonal (ρ : Matrix n n ℂ) :
    IsDensityMatrix ρ ↔
      ∃ (U : Matrix.unitaryGroup n ℂ) (d : n → ℝ),
        (∀ i, 0 ≤ d i) ∧ (∑ i, d i = 1) ∧
        ρ = (U : Matrix n n ℂ) * diagonal (RCLike.ofReal ∘ d) * (U : Matrix n n ℂ)ᴴ := by
  constructor
  · intro h
    exact ⟨h.1.eigenvectorUnitary, h.1.eigenvalues, density_eigenvalues_nonneg h,
      density_eigenvalues_sum_one h, density_spectral h⟩
  · rintro ⟨U, d, hd, hsum, rfl⟩
    exact isDensityMatrix_of_unitary_diagonal U d hd hsum

end BookProof.DensitySpectral
