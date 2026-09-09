import Mathlib
import BookProof.ChapterAttentionOutput
import BookProof.ChapterAttentionEntropy

/-!
# Chapter "The Coherent State of Attention": coarse-graining the keys

A head does not really attend to *positions*; it attends to whatever the positions
stand for.  Duplicate a key, split a token in two, or group the context into
topics, and the Born measurement should not notice.  This module proves that it
does not: the correct bookkeeping is the **pushforward** of the attention
distribution along a grouping map `f : Fin m → Fin r`.

* `mergeWeights` — the coarse-grained distribution `P(y) = ∑_{f(x)=y} p(x)`, shown
  to be a probability distribution (`mergeWeights_nonneg`, `sum_mergeWeights`).
* `observableExpectation_merge` — **the headline**: if the values depend on the key
  only through its group, the output computed key-by-key and the output computed
  group-by-group agree; `headOutput_merge` states this for an attention head.
* `shannonEntropy_mergeWeights_le` — the **data-processing inequality** for the
  attention entropy: merging keys can only lose information, never create it.
* `mergeWeights_scoreSoftmax_of_fiber_const` — the multiplicity rule: if the scores
  depend only on the group, the coarse-grained weights are the Softmax of the group
  scores *weighted by the size of each group*.  Duplicating a key is not neutral —
  it doubles that key's share; only the values, not the weights, are invariant.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionCoarseGrain

open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness
  BookProof.ChapterSoftmaxOrder BookProof.ChapterAttentionEntropy
  BookProof.ChapterAttentionOutput

variable {m r : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-! ## The pushforward of the attention distribution -/

/-- The **coarse-grained attention weights**: the total weight of each group. -/
def mergeWeights (f : Fin m → Fin r) (p : Fin m → ℝ) (y : Fin r) : ℝ :=
  ∑ x ∈ Finset.univ.filter (fun x => f x = y), p x

theorem mergeWeights_nonneg {f : Fin m → Fin r} {p : Fin m → ℝ} (hp : ∀ x, 0 ≤ p x)
    (y : Fin r) : 0 ≤ mergeWeights f p y :=
  Finset.sum_nonneg fun x _ => hp x

/-- Coarse-graining preserves total probability. -/
theorem sum_mergeWeights (f : Fin m → Fin r) (p : Fin m → ℝ) :
    ∑ y, mergeWeights f p y = ∑ x, p x :=
  Finset.sum_fiberwise Finset.univ f p

theorem sum_mergeWeights_one {f : Fin m → Fin r} {p : Fin m → ℝ} (hp : ∑ x, p x = 1) :
    ∑ y, mergeWeights f p y = 1 := by
  rw [sum_mergeWeights, hp]

/-- Each key's weight is at most the weight of its group. -/
theorem le_mergeWeights {f : Fin m → Fin r} {p : Fin m → ℝ} (hp : ∀ x, 0 ≤ p x) (x : Fin m) :
    p x ≤ mergeWeights f p (f x) := by
  refine Finset.single_le_sum (f := p) (fun z _ => hp z) ?_
  simp

/-! ## Coarse-graining does not move the output -/

/-- **The output only sees the groups.**  If the values depend on the key only
through its group, the group-by-group expectation equals the key-by-key one. -/
theorem observableExpectation_merge (f : Fin m → Fin r) (p : Fin m → ℝ) (v : Fin r → E) :
    observableExpectation (mergeWeights f p) v
      = observableExpectation p (fun x => v (f x)) := by
  have hstep : ∀ y : Fin r, mergeWeights f p y • v y
      = ∑ x ∈ Finset.univ.filter (fun x => f x = y), p x • v (f x) := by
    intro y
    rw [mergeWeights, Finset.sum_smul]
    refine Finset.sum_congr rfl fun x hx => ?_
    rw [(Finset.mem_filter.mp hx).2]
  calc observableExpectation (mergeWeights f p) v
      = ∑ y, mergeWeights f p y • v y := rfl
    _ = ∑ y, ∑ x ∈ Finset.univ.filter (fun x => f x = y), p x • v (f x) :=
        Finset.sum_congr rfl fun y _ => hstep y
    _ = ∑ x, p x • v (f x) :=
        Finset.sum_fiberwise Finset.univ f (fun x => p x • v (f x))
    _ = observableExpectation p (fun x => v (f x)) := rfl

/-- The same statement for an attention head: merging keys whose values agree does
not move the head's output. -/
theorem headOutput_merge (beta : ℝ) (s : Fin m → ℝ) (f : Fin m → Fin r) (v : Fin r → E) :
    observableExpectation (mergeWeights f (scoreSoftmax beta s)) v
      = headOutput beta s (fun x => v (f x)) :=
  observableExpectation_merge f (scoreSoftmax beta s) v

/-! ## Data processing: coarse-graining destroys information -/

/-- Rewriting the coarse-grained entropy as a key-by-key sum. -/
theorem sum_mergeWeights_log (f : Fin m → Fin r) (p : Fin m → ℝ) :
    ∑ y, mergeWeights f p y * Real.log (mergeWeights f p y)
      = ∑ x, p x * Real.log (mergeWeights f p (f x)) := by
  have hstep : ∀ y : Fin r, mergeWeights f p y * Real.log (mergeWeights f p y)
      = ∑ x ∈ Finset.univ.filter (fun x => f x = y),
          p x * Real.log (mergeWeights f p (f x)) := by
    intro y
    have h1 : ∑ x ∈ Finset.univ.filter (fun x => f x = y),
          p x * Real.log (mergeWeights f p (f x))
        = ∑ x ∈ Finset.univ.filter (fun x => f x = y), p x * Real.log (mergeWeights f p y) :=
      Finset.sum_congr rfl fun x hx => by rw [(Finset.mem_filter.mp hx).2]
    rw [h1, ← Finset.sum_mul]
    rfl
  calc ∑ y, mergeWeights f p y * Real.log (mergeWeights f p y)
      = ∑ y, ∑ x ∈ Finset.univ.filter (fun x => f x = y),
          p x * Real.log (mergeWeights f p (f x)) :=
        Finset.sum_congr rfl fun y _ => hstep y
    _ = ∑ x, p x * Real.log (mergeWeights f p (f x)) :=
        Finset.sum_fiberwise Finset.univ f
          (fun x => p x * Real.log (mergeWeights f p (f x)))

/-- **The data-processing inequality for attention.**  Coarse-graining the keys can
only decrease the entropy of the Born measurement. -/
theorem shannonEntropy_mergeWeights_le {f : Fin m → Fin r} {p : Fin m → ℝ}
    (hp : ∀ x, 0 ≤ p x) :
    shannonEntropy (mergeWeights f p) ≤ shannonEntropy p := by
  have hterm : ∀ x : Fin m,
      p x * Real.log (p x) ≤ p x * Real.log (mergeWeights f p (f x)) := by
    intro x
    rcases eq_or_lt_of_le (hp x) with h | h
    · simp [← h]
    · exact mul_le_mul_of_nonneg_left (Real.log_le_log h (le_mergeWeights hp x)) (hp x)
  have hsum : ∑ x, p x * Real.log (p x)
      ≤ ∑ x, p x * Real.log (mergeWeights f p (f x)) :=
    Finset.sum_le_sum fun x _ => hterm x
  rw [shannonEntropy, shannonEntropy, neg_le_neg_iff, sum_mergeWeights_log]
  exact hsum

/-! ## Multiplicity: duplicated keys accumulate weight -/

/-- If the scores depend on the key only through its group, the coarse-grained
attention weights are the Softmax of the group scores weighted by the group sizes:
a key that appears twice gets twice the share. -/
theorem mergeWeights_scoreSoftmax_of_fiber_const (beta : ℝ) (f : Fin m → Fin r)
    (t : Fin r → ℝ) (y : Fin r) :
    mergeWeights f (scoreSoftmax beta (fun x => t (f x))) y
      = ((Finset.univ.filter (fun x => f x = y)).card : ℝ) * Real.exp (beta * t y)
        / ∑ z, ((Finset.univ.filter (fun x => f x = z)).card : ℝ) * Real.exp (beta * t z) := by
  have hden : ∑ x, Real.exp (beta * t (f x))
      = ∑ z, ((Finset.univ.filter (fun x => f x = z)).card : ℝ) * Real.exp (beta * t z) := by
    refine ((Finset.sum_fiberwise Finset.univ f (fun x => Real.exp (beta * t (f x)))).symm).trans ?_
    refine Finset.sum_congr rfl fun z _ => ?_
    rw [Finset.sum_congr rfl (fun x hx => by rw [(Finset.mem_filter.mp hx).2] :
      ∀ x ∈ Finset.univ.filter (fun x => f x = z),
        Real.exp (beta * t (f x)) = Real.exp (beta * t z))]
    simp [mul_comm]
  rw [mergeWeights]
  rw [Finset.sum_congr rfl (fun x hx => by rw [scoreSoftmax, (Finset.mem_filter.mp hx).2] :
    ∀ x ∈ Finset.univ.filter (fun x => f x = y),
      scoreSoftmax beta (fun x => t (f x)) x
        = Real.exp (beta * t y) / ∑ x, Real.exp (beta * t (f x)))]
  rw [Finset.sum_const, hden, nsmul_eq_mul, ← mul_div_assoc]

end BookProof.ChapterAttentionCoarseGrain
