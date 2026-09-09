import Mathlib
import BookProof.ChapterDensitySpectral

/-!
# The density matrix: the diagonal is the **marginal**, the unitary is the **conditional**

`BookProof/ChapterDensitySpectral.lean` proves the book's claim (`book.tex`
~1796–1800) that a density matrix is "a diagonal operator rotated by a unitary
operator": `ρ = U · diag(d) · U†` with `d` a probability distribution
(`density_iff_exists_unitary_diagonal`).

The book adds a *probabilistic reading* of the two factors: the diagonal `d`
"defines the marginal probability of the initial state" and the unitary
"defines the conditioned probability of the final state conditioned by the
initial state".  This file supplies exactly that reading, as theorems.

* `bornKernel U i j = ‖U i j‖²` is the Born-rule transition matrix of a unitary.
  It is a genuine conditional probability: nonnegative
  (`bornKernel_nonneg`) with unit row sums (`bornKernel_row_sum`) and unit
  column sums (`bornKernel_col_sum`) — i.e. **doubly stochastic**.
* `density_diag_eq_kernel_apply`: the diagonal of `ρ = U · diag(d) · U†` in the
  computational basis is the transport of `d` by that kernel,
  `ρ i i = ∑ k, ‖U i k‖² · d k`.
* `density_diag_isProbability`: consequently the diagonal of any density matrix
  is itself a probability distribution — the marginal of the final state.
* `density_marginal_conditional`: the headline packaging both halves.

All results are `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

namespace BookProof.DensitySpectral

open Matrix
open scoped BigOperators ComplexOrder

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- The **Born-rule transition matrix** of a unitary `U`: `bornKernel U i j = ‖U i j‖²`,
the probability of observing the final state `i` given the initial state `j`. -/
def bornKernel (U : Matrix n n ℂ) (i j : n) : ℝ := Complex.normSq (U i j)

omit [Fintype n] [DecidableEq n] in
theorem bornKernel_nonneg (U : Matrix n n ℂ) (i j : n) : 0 ≤ bornKernel U i j :=
  Complex.normSq_nonneg _

/-- Rows of the Born kernel of a unitary sum to `1`. -/
theorem bornKernel_row_sum (U : Matrix.unitaryGroup n ℂ) (i : n) :
    ∑ j, bornKernel (U : Matrix n n ℂ) i j = 1 := by
  have h : (U : Matrix n n ℂ) * (U : Matrix n n ℂ)ᴴ = 1 := by
    have := Unitary.mul_star_self_of_mem U.2
    simpa [Matrix.star_eq_conjTranspose] using this
  have h2 := congrFun (congrFun h i) i
  rw [Matrix.mul_apply] at h2
  simp only [Matrix.conjTranspose_apply, Matrix.one_apply_eq] at h2
  have key : ∀ j, (U : Matrix n n ℂ) i j * star ((U : Matrix n n ℂ) i j)
      = ((Complex.normSq ((U : Matrix n n ℂ) i j) : ℝ) : ℂ) := fun j => by
    simpa [Complex.star_def] using Complex.mul_conj ((U : Matrix n n ℂ) i j)
  simp only [key] at h2
  rw [← Complex.ofReal_sum] at h2
  exact_mod_cast h2

/-- Columns of the Born kernel of a unitary sum to `1`; together with
`bornKernel_row_sum` the kernel is doubly stochastic. -/
theorem bornKernel_col_sum (U : Matrix.unitaryGroup n ℂ) (j : n) :
    ∑ i, bornKernel (U : Matrix n n ℂ) i j = 1 := by
  have h : (U : Matrix n n ℂ)ᴴ * (U : Matrix n n ℂ) = 1 := by
    have := Unitary.star_mul_self_of_mem U.2
    simpa [Matrix.star_eq_conjTranspose] using this
  have h2 := congrFun (congrFun h j) j
  rw [Matrix.mul_apply] at h2
  simp only [Matrix.conjTranspose_apply, Matrix.one_apply_eq] at h2
  have key : ∀ i, star ((U : Matrix n n ℂ) i j) * (U : Matrix n n ℂ) i j
      = ((Complex.normSq ((U : Matrix n n ℂ) i j) : ℝ) : ℂ) := fun i => by
    rw [mul_comm]
    simpa [Complex.star_def] using Complex.mul_conj ((U : Matrix n n ℂ) i j)
  simp only [key] at h2
  rw [← Complex.ofReal_sum] at h2
  exact_mod_cast h2

/-- **The diagonal of `U · diag(d) · U†` is the transport of `d` by the Born
kernel of `U`.**  This is the book's "the unitary defines the conditioned
probability of the final state conditioned by the initial state". -/
theorem density_diag_eq_kernel_apply (U : Matrix n n ℂ) (d : n → ℝ) (i : n) :
    (U * Matrix.diagonal (RCLike.ofReal ∘ d) * Uᴴ : Matrix n n ℂ) i i
      = ((∑ k, bornKernel U i k * d k : ℝ) : ℂ) := by
  rw [Matrix.mul_apply]
  push_cast
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [Matrix.mul_diagonal, Matrix.conjTranspose_apply]
  simp only [Function.comp_apply, bornKernel,
    Complex.normSq_eq_conj_mul_self]
  simp []
  ring

omit [DecidableEq n] in
/-- The diagonal of a density matrix is a probability distribution: the marginal
probability of the final state in the computational basis. -/
theorem density_diag_isProbability {ρ : Matrix n n ℂ} (h : IsDensityMatrix ρ) :
    (∀ i, 0 ≤ (ρ i i).re) ∧ ∑ i, (ρ i i).re = 1 := by
  constructor
  · intro i
    exact (RCLike.nonneg_iff.mp (h.2.1.diag_nonneg (i := i))).1
  · have h1 : (∑ i, ρ i i) = 1 := by simpa [Matrix.trace, Matrix.diag] using h.2.2
    simpa using congrArg Complex.re h1

/-- **Headline (book §5, probabilistic reading).**  Every density matrix `ρ`
decomposes as `U · diag(d) · U†` where

* `d` is a probability distribution — the *marginal* of the initial state, and
* `bornKernel U` is a doubly stochastic conditional probability matrix,

and the final-state marginal `ρ i i` is obtained from `d` by that conditional:
`ρ i i = ∑ k, ‖U i k‖² · d k`. -/
theorem density_marginal_conditional {ρ : Matrix n n ℂ} (h : IsDensityMatrix ρ) :
    ∃ (U : Matrix.unitaryGroup n ℂ) (d : n → ℝ),
      (∀ i, 0 ≤ d i) ∧ (∑ i, d i = 1) ∧
      (∀ i j, 0 ≤ bornKernel (U : Matrix n n ℂ) i j) ∧
      (∀ i, ∑ j, bornKernel (U : Matrix n n ℂ) i j = 1) ∧
      (∀ j, ∑ i, bornKernel (U : Matrix n n ℂ) i j = 1) ∧
      (∀ i, ρ i i = ((∑ k, bornKernel (U : Matrix n n ℂ) i k * d k : ℝ) : ℂ)) := by
  obtain ⟨U, d, hd, hsum, hrho⟩ := (density_iff_exists_unitary_diagonal ρ).mp h
  refine ⟨U, d, hd, hsum, bornKernel_nonneg _, bornKernel_row_sum U,
    bornKernel_col_sum U, fun i => ?_⟩
  rw [hrho]
  exact density_diag_eq_kernel_apply (U : Matrix n n ℂ) d i

end BookProof.DensitySpectral
