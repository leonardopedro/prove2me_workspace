import Mathlib
import BookProof.ChapterAttentionSparse

/-!
# Chapter "The Coherent State of Attention": top-`k` is the optimal shortlist

`ChapterAttentionSparse` prices a shortlist `S` exactly: the sparse head differs
from the dense head by `2(1 − P(S))` in `ℓ¹`, where `P(S)` is the attention mass of
`S`.  The natural next question is which shortlist of a given size to pick.  The
answer is the obvious one, and this module proves it: the keys of largest weight.

* `sum_le_sum_of_isTop` — a general fact about non-negative weights: a set whose
  members all dominate every outsider carries at least as much mass as any set of
  the same size or smaller;
* **`attendedMass_le_of_isTop`** — hence the top-`k` shortlist maximizes the
  attended mass, and `l1dist_maskedSoftmax_le_of_isTop` — it therefore *minimizes*
  the `ℓ¹` error and (`norm_headOutput_topk_sub_le_of_isTop`) the output error among
  all shortlists of at most its size;
* `isTopWeight_of_isTopScore` — and at a positive temperature "the `k` largest
  weights" is the same shortlist as "the `k` largest scores", so the selection can
  be made before the Softmax is evaluated.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionTopK

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterAttentionMasking BookProof.ChapterAttentionMarkov
  BookProof.ChapterObservableExpectation BookProof.ChapterAttentionOutput
  BookProof.ChapterAttentionSparse

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-! ## Choosing the heaviest keys -/

/-- `S` collects the heaviest keys for the weights `p`: every member dominates every
outsider. -/
def IsTop (p : Fin m → ℝ) (S : Finset (Fin m)) : Prop :=
  ∀ x ∈ S, ∀ y ∉ S, p y ≤ p x

/-- **A heaviest-first set carries the most mass.**  For non-negative weights, a set
`S` whose members all dominate the outsiders carries at least as much total weight
as any set `T` of at most the same size. -/
theorem sum_le_sum_of_isTop {p : Fin m → ℝ} (hp : ∀ x, 0 ≤ p x) {S T : Finset (Fin m)}
    (hS : IsTop p S) (hcard : T.card ≤ S.card) :
    ∑ x ∈ T, p x ≤ ∑ x ∈ S, p x := by
  have hsplitT : ∑ x ∈ T ∩ S, p x + ∑ x ∈ T \ S, p x = ∑ x ∈ T, p x :=
    Finset.sum_inter_add_sum_diff T S p
  have hsplitS : ∑ x ∈ S ∩ T, p x + ∑ x ∈ S \ T, p x = ∑ x ∈ S, p x :=
    Finset.sum_inter_add_sum_diff S T p
  have hinter : ∑ x ∈ T ∩ S, p x = ∑ x ∈ S ∩ T, p x := by rw [Finset.inter_comm]
  have hcardT := Finset.card_inter_add_card_sdiff T S
  have hcardS := Finset.card_inter_add_card_sdiff S T
  have hcardinter : (T ∩ S).card = (S ∩ T).card := by rw [Finset.inter_comm]
  have hdiffcard : (T \ S).card ≤ (S \ T).card := by omega
  have hdiff : ∑ x ∈ T \ S, p x ≤ ∑ x ∈ S \ T, p x := by
    rcases Finset.eq_empty_or_nonempty (S \ T) with hB | hB
    · have hBcard : (S \ T).card = 0 := by rw [hB]; simp
      have hA0 : (T \ S).card = 0 := by omega
      have hA : T \ S = ∅ := Finset.card_eq_zero.1 hA0
      simp [hA, hB]
    · obtain ⟨y₀, hy₀B, hy₀min⟩ := Finset.exists_min_image (S \ T) p hB
      have hy₀S : y₀ ∈ S := (Finset.mem_sdiff.1 hy₀B).1
      have hA : ∑ x ∈ T \ S, p x ≤ ((T \ S).card : ℝ) * p y₀ := by
        have := Finset.sum_le_card_nsmul (T \ S) p (p y₀) fun x hx => by
          exact hS y₀ hy₀S x (Finset.mem_sdiff.1 hx).2
        simpa [nsmul_eq_mul] using this
      have hBsum : ((S \ T).card : ℝ) * p y₀ ≤ ∑ x ∈ S \ T, p x := by
        have := Finset.card_nsmul_le_sum (S \ T) p (p y₀) fun x hx => hy₀min x hx
        simpa [nsmul_eq_mul] using this
      have hcards : ((T \ S).card : ℝ) ≤ ((S \ T).card : ℝ) := by exact_mod_cast hdiffcard
      have hy₀pos : 0 ≤ p y₀ := hp y₀
      calc ∑ x ∈ T \ S, p x ≤ ((T \ S).card : ℝ) * p y₀ := hA
        _ ≤ ((S \ T).card : ℝ) * p y₀ := mul_le_mul_of_nonneg_right hcards hy₀pos
        _ ≤ ∑ x ∈ S \ T, p x := hBsum
  rw [← hsplitT, ← hsplitS, hinter]
  linarith

/-! ## Top-`k` attention -/

/-- **The top-`k` shortlist maximizes the attended mass.** -/
theorem attendedMass_le_of_isTop (beta : ℝ) (s : Fin m → ℝ) {S T : Finset (Fin m)}
    (hS : IsTop (scoreSoftmax beta s) S) (hcard : T.card ≤ S.card) :
    attendedMass beta s T ≤ attendedMass beta s S :=
  sum_le_sum_of_isTop (scoreSoftmax_nonneg beta s) hS hcard

/-- **…and therefore minimizes the sparsification error.** -/
theorem l1dist_maskedSoftmax_le_of_isTop (beta : ℝ) (s : Fin m → ℝ) {S T : Finset (Fin m)}
    (hS : IsTop (scoreSoftmax beta s) S) (hcard : T.card ≤ S.card) (hSne : S.Nonempty)
    (hTne : T.Nonempty) (i : Fin m) :
    l1dist (maskedSoftmax beta s S) (scoreSoftmax beta s)
      ≤ l1dist (maskedSoftmax beta s T) (scoreSoftmax beta s) := by
  rw [l1dist_maskedSoftmax_eq beta s hSne i, l1dist_maskedSoftmax_eq beta s hTne i]
  have := attendedMass_le_of_isTop beta s hS hcard
  linarith

/-- The output of the top-`k` head is at least as accurate as that of any other
shortlist of at most the same size. -/
theorem norm_headOutput_topk_sub_le_of_isTop (beta : ℝ) (s : Fin m → ℝ)
    {S T : Finset (Fin m)} (hS : IsTop (scoreSoftmax beta s) S) (hcard : T.card ≤ S.card)
    (hSne : S.Nonempty) (i : Fin m) {v : Fin m → E} {C : ℝ} (hv : ∀ j, ‖v j‖ ≤ C)
    (hC : 0 ≤ C) :
    ‖observableExpectation (maskedSoftmax beta s S) v - headOutput beta s v‖
      ≤ 2 * (1 - attendedMass beta s T) * C := by
  refine le_trans (norm_headOutput_masked_sub_le beta s hSne i hv) ?_
  have := attendedMass_le_of_isTop beta s hS hcard
  have h2 : 2 * (1 - attendedMass beta s S) ≤ 2 * (1 - attendedMass beta s T) := by linarith
  exact mul_le_mul_of_nonneg_right h2 hC

/-- **The shortlist can be chosen before the Softmax.**  At a positive temperature
the keys of largest weight are exactly the keys of largest score. -/
theorem isTopWeight_of_isTopScore {beta : ℝ} (hbeta : 0 < beta) (s : Fin m → ℝ)
    {S : Finset (Fin m)} (hS : ∀ x ∈ S, ∀ y ∉ S, s y ≤ s x) :
    IsTop (scoreSoftmax beta s) S := fun x hx y hy =>
  (scoreSoftmax_le_iff hbeta s y x).2 (hS x hx y hy)

end BookProof.ChapterAttentionTopK

end
