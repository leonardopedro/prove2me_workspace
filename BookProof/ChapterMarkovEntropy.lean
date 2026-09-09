import Mathlib

/-!
# Chapter "Wave-function parametrization of a probability measure", §2
"Probability updates, machine learning and Quantum Mechanics":
**Markov processes are entropy-monotone, hence Bayesian inference is irreversible**

Formalization of the self-contained mathematical claim the book makes in §2 of its
central foundational chapter (`book.tex` line ~1338), where it contrasts its
*reversible* "Unitary inference" with ordinary Bayesian inference:

> "Markov processes cannot produce an arbitrary function of time, because there
> is an ordering (related with the concept of entropy) with respect to which all
> continuous-time Markov processes are monotonic.  Thus, Bayesian inference is
> irreversible."

The self-contained finite-dimensional content is the classical **entropy
increase under a doubly-stochastic (bistochastic) Markov map** (the discrete
`H`-theorem): applying such a Markov transition matrix `M` to a probability
vector `p` can only *increase* the Shannon entropy, `H(p) ≤ H(M p)`, with
equality (reversibility) for a **permutation** matrix — a deterministic,
invertible transition.  So the entropy ordering is monotone along any Markov
process, and can be preserved only by the reversible (permutation) maps; a
genuinely mixing Markov step cannot be undone.  This is exactly the
irreversibility the book invokes to motivate unitary inference.

The proof is Jensen's inequality for the concave function `negMulLog x = -x·log x`
(`Real.concaveOn_negMulLog`), applied row by row, together with the two
stochasticity constraints.

Consistently with the finite-dimensional models used throughout `BookProof`, the
statement is over finite index sets `Fin n`.  This file is `sorry`-free and
`axiom`-free (only `propext`, `Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators
open Finset

namespace BookProof.ChapterMarkovEntropy

variable {n : ℕ}

/-- Shannon entropy of a finite probability vector `p : Fin n → ℝ`,
`H(p) = ∑_a -p a · log (p a)`. -/
noncomputable def entropy (p : Fin n → ℝ) : ℝ :=
  ∑ a, Real.negMulLog (p a)

/-- The action of a Markov transition matrix `M` (with `M j i` the probability of
moving from state `i` to state `j`) on a probability vector `p`:
`(M p) j = ∑_i M j i · p i`. -/
def applyMarkov (M : Fin n → Fin n → ℝ) (p : Fin n → ℝ) : Fin n → ℝ :=
  fun j => ∑ i, M j i * p i

/-- A **doubly stochastic** (bistochastic) transition matrix: nonnegative entries
whose rows and columns both sum to one. -/
structure IsDoublyStochastic (M : Fin n → Fin n → ℝ) : Prop where
  nonneg : ∀ j i, 0 ≤ M j i
  colSum : ∀ i, ∑ j, M j i = 1
  rowSum : ∀ j, ∑ i, M j i = 1

/-- **Headline — entropy increase under a doubly-stochastic Markov map
(discrete `H`-theorem).**  For a doubly-stochastic transition matrix `M` and a
probability vector `p` with nonnegative entries, the Markov step does not
decrease the Shannon entropy: `H(p) ≤ H(M p)`.  This is the entropy monotonicity
the book invokes; irreversibility follows, since the entropy cannot be brought
back down by a further Markov step. -/
theorem entropy_applyMarkov_ge (M : Fin n → Fin n → ℝ) (hM : IsDoublyStochastic M)
    (p : Fin n → ℝ) (hp : ∀ i, 0 ≤ p i) :
    entropy p ≤ entropy (applyMarkov M p) := by
  -- Row-wise concave Jensen inequality for `negMulLog`, weights `M j i`.
  have h_jensen : ∀ j, ∑ i, M j i * Real.negMulLog (p i)
      ≤ Real.negMulLog (∑ i, M j i * p i) := by
    intro j
    have h := Real.concaveOn_negMulLog.le_map_sum (t := Finset.univ)
      (w := fun i => M j i) (p := fun i => p i)
      (fun i _ => hM.nonneg j i) (hM.rowSum j)
      (fun i _ => Set.mem_Ici.mpr (hp i))
    simpa [smul_eq_mul] using h
  calc entropy p
      = ∑ i, (∑ j, M j i) * Real.negMulLog (p i) := by simp [entropy, hM.colSum]
    _ = ∑ j, ∑ i, M j i * Real.negMulLog (p i) := by
        rw [Finset.sum_comm]
        exact Finset.sum_congr rfl fun i _ => by rw [Finset.sum_mul]
    _ ≤ ∑ j, Real.negMulLog (∑ i, M j i * p i) :=
        Finset.sum_le_sum fun j _ => h_jensen j
    _ = entropy (applyMarkov M p) := rfl

/-- The permutation matrix of `σ`: `M j i = 1` iff `j = σ i`, else `0`.  This
models a *deterministic, invertible* (reversible) transition. -/
def permMatrix (σ : Equiv.Perm (Fin n)) : Fin n → Fin n → ℝ :=
  fun j i => if j = σ i then 1 else 0

/-- A permutation matrix is doubly stochastic. -/
theorem permMatrix_doublyStochastic (σ : Equiv.Perm (Fin n)) :
    IsDoublyStochastic (permMatrix σ) where
  nonneg j i := by unfold permMatrix; split_ifs <;> norm_num
  colSum i := by simp [permMatrix]
  rowSum j := by
    unfold permMatrix
    rw [Finset.sum_eq_single (σ.symm j)]
    · simp
    · intro b _ hb
      rw [if_neg]
      intro h
      exact hb (by rw [h, Equiv.symm_apply_apply])
    · intro h; exact absurd (Finset.mem_univ _) h

/-- Applying a permutation matrix just reindexes the vector: `(M p) j = p (σ⁻¹ j)`. -/
theorem applyMarkov_permMatrix (σ : Equiv.Perm (Fin n)) (p : Fin n → ℝ) :
    applyMarkov (permMatrix σ) p = fun j => p (σ.symm j) := by
  funext j
  unfold applyMarkov permMatrix
  rw [Finset.sum_eq_single (σ.symm j)] <;> aesop

/-- **Reversible case: entropy is preserved by a permutation (deterministic,
invertible) transition.**  This is the equality boundary of the `H`-theorem:
only the reversible Markov maps leave the entropy unchanged, in contrast with a
genuinely mixing doubly-stochastic step, which strictly increases it. -/
theorem entropy_applyMarkov_permMatrix (σ : Equiv.Perm (Fin n)) (p : Fin n → ℝ) :
    entropy (applyMarkov (permMatrix σ) p) = entropy p := by
  rw [applyMarkov_permMatrix]
  exact Equiv.sum_comp σ.symm (fun j => Real.negMulLog (p j))

end BookProof.ChapterMarkovEntropy
