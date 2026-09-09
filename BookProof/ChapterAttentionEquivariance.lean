import Mathlib
import BookProof.ChapterAttentionOutput
import BookProof.ChapterAttentionEntropy

/-!
# Chapter "The Coherent State of Attention": attention is a set function

An attention head has no notion of *where* a key sits in the list it was handed:
the keys enter only through the scores they produce, and the scores are summed
over.  This module proves that precisely.

* `scoreSoftmax_perm` — **equivariance.**  Relabelling the keys by a permutation
  `σ` relabels the attention weights by `σ`, and changes nothing else.
* `headOutput_perm` / `attentionOutput_perm` — **invariance of the output.**  The
  head output is unchanged when the key/value pairs are permuted: the head sees
  the *set* of pairs, not the list.
* `shannonEntropy_perm` — the attention entropy is a symmetric function of the
  weights, as any information measure of an unordered ensemble must be.
* `bornWeight_perm` — the same statement in the coherent-state picture.

This is the discrete companion of `ChapterCoherentDynamics`, which proves the
*continuous* symmetries (unitary invariance, free evolution, Weyl displacement).
Together they exhibit the full symmetry group of a head: the unitary group acting
on the phase-space labels, and the symmetric group acting on the key index.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionEquivariance

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterSoftmaxBorn BookProof.ChapterObservableExpectation
  BookProof.ChapterAttentionOutput BookProof.ChapterAttentionEntropy

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-! ## The partition function is a symmetric function of the scores -/

/-- The Softmax denominator only depends on the multiset of scores. -/
theorem denom_perm (beta : ℝ) (s : Fin m → ℝ) (sigma : Equiv.Perm (Fin m)) :
    ∑ l, Real.exp (beta * s (sigma l)) = ∑ l, Real.exp (beta * s l) :=
  Fintype.sum_equiv sigma _ _ (fun _ => rfl)

/-! ## Equivariance of the weights -/

/-- **Attention is permutation-equivariant.**  Reordering the keys reorders the
attention weights the same way. -/
theorem scoreSoftmax_perm (beta : ℝ) (s : Fin m → ℝ) (sigma : Equiv.Perm (Fin m))
    (j : Fin m) :
    scoreSoftmax beta (s ∘ sigma) j = scoreSoftmax beta s (sigma j) := by
  rw [scoreSoftmax, scoreSoftmax]
  simp only [Function.comp_apply]
  rw [denom_perm beta s sigma]

/-- The Born weights of the coherent-state picture are permutation-equivariant. -/
theorem bornWeight_perm (q : EuclideanSpace ℝ (Fin n)) (k : Fin m → EuclideanSpace ℝ (Fin n))
    (sigma : Equiv.Perm (Fin m)) (j : Fin m) :
    bornWeight q (k ∘ sigma) j = bornWeight q k (sigma j) := by
  rw [bornWeight, bornWeight]
  simp only [Function.comp_apply]
  congr 1
  exact Fintype.sum_equiv sigma _ _ (fun _ => rfl)

/-! ## Invariance of the output -/

/-- The expectation value of a permuted ensemble is unchanged. -/
theorem observableExpectation_perm (p : Fin m → ℝ) (v : Fin m → E)
    (sigma : Equiv.Perm (Fin m)) :
    observableExpectation (p ∘ sigma) (v ∘ sigma) = observableExpectation p v :=
  Fintype.sum_equiv sigma _ _ (fun _ => rfl)

/-- **The head output is permutation-invariant**: a head reads its key/value pairs
as an unordered set. -/
theorem headOutput_perm (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E)
    (sigma : Equiv.Perm (Fin m)) :
    headOutput beta (s ∘ sigma) (v ∘ sigma) = headOutput beta s v := by
  rw [headOutput_eq_sum, headOutput_eq_sum]
  refine Fintype.sum_equiv sigma _ _ (fun l => ?_)
  rw [scoreSoftmax_perm]
  rfl

/-- The coherent-state attention output is permutation-invariant. -/
theorem attentionOutput_perm (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (v : Fin m → E)
    (sigma : Equiv.Perm (Fin m)) :
    attentionOutput q (k ∘ sigma) (v ∘ sigma) = attentionOutput q k v := by
  rw [attentionOutput, attentionOutput]
  refine Fintype.sum_equiv sigma _ _ (fun l => ?_)
  rw [bornWeight_perm]
  rfl

/-! ## Invariance of the information measures -/

/-- The Shannon entropy of a permuted distribution is unchanged. -/
theorem shannonEntropy_perm (p : Fin m → ℝ) (sigma : Equiv.Perm (Fin m)) :
    shannonEntropy (p ∘ sigma) = shannonEntropy p := by
  rw [shannonEntropy, shannonEntropy]
  congr 1
  exact Fintype.sum_equiv sigma _ _ (fun _ => rfl)

/-- **The attention entropy is a symmetric function of the scores.** -/
theorem shannonEntropy_scoreSoftmax_perm (beta : ℝ) (s : Fin m → ℝ)
    (sigma : Equiv.Perm (Fin m)) :
    shannonEntropy (scoreSoftmax beta (s ∘ sigma)) = shannonEntropy (scoreSoftmax beta s) := by
  have h : scoreSoftmax beta (s ∘ sigma) = (scoreSoftmax beta s) ∘ sigma :=
    funext fun j => scoreSoftmax_perm beta s sigma j
  rw [h, shannonEntropy_perm]

end BookProof.ChapterAttentionEquivariance

end
