import Mathlib
import BookProof.ChapterAttentionEntropy

/-!
# Chapter "The Coherent State of Attention" — independent modes factorize

A multi-mode coherent state is a product state, and the alignment score of a
product key is the *sum* of the per-mode scores.  This module proves what that
does to the attention distribution: it factorizes, exactly.

Deliverables (all `sorry`-free, `axiom`-free):

* `prodSoftmax β s₁ s₂` — Softmax over the product key set `Fin m₁ × Fin m₂` with
  additive scores `s(a,b) = s₁(a) + s₂(b)`;
* **`prodSoftmax_eq_mul`** — the headline: `p(a,b) = p₁(a)·p₂(b)`, a product
  measure.  Independent modes never entangle the attention distribution;
* `prodSoftmax_sum_one`, `prodSoftmax_pos` — it is a probability distribution;
* `prodSoftmax_marginal_left` / `prodSoftmax_marginal_right` — its marginals are
  the single-mode attention distributions, so ignoring a mode costs nothing;
* `shannonEntropy_prodSoftmax` — **the attention entropy is additive over
  independent modes**, the informational counterpart of the factorization.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionFactorization

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterAttentionEntropy

variable {m₁ m₂ : ℕ}

/-! ## Attention over a product of modes -/

/-- Softmax over a product key set with **additive** alignment scores. -/
def prodSoftmax (beta : ℝ) (s₁ : Fin m₁ → ℝ) (s₂ : Fin m₂ → ℝ) (j : Fin m₁ × Fin m₂) : ℝ :=
  Real.exp (beta * (s₁ j.1 + s₂ j.2)) /
    ∑ l : Fin m₁ × Fin m₂, Real.exp (beta * (s₁ l.1 + s₂ l.2))

/-- **Independent modes factorize.**  With additive scores the joint attention
distribution is the product of the two single-mode distributions. -/
theorem prodSoftmax_eq_mul (beta : ℝ) (s₁ : Fin m₁ → ℝ) (s₂ : Fin m₂ → ℝ)
    (j : Fin m₁ × Fin m₂) :
    prodSoftmax beta s₁ s₂ j = scoreSoftmax beta s₁ j.1 * scoreSoftmax beta s₂ j.2 := by
  have hZ₁ : (0 : ℝ) < ∑ a, Real.exp (beta * s₁ a) := scoreSoftmax_denom_pos beta s₁ j.1
  have hZ₂ : (0 : ℝ) < ∑ b, Real.exp (beta * s₂ b) := scoreSoftmax_denom_pos beta s₂ j.2
  have hden : ∑ l : Fin m₁ × Fin m₂, Real.exp (beta * (s₁ l.1 + s₂ l.2))
      = (∑ a, Real.exp (beta * s₁ a)) * ∑ b, Real.exp (beta * s₂ b) := by
    rw [Finset.sum_mul_sum, Fintype.sum_prod_type]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    rw [← Real.exp_add]
    ring_nf
  rw [prodSoftmax, hden, scoreSoftmax, scoreSoftmax, div_mul_div_comm, ← Real.exp_add]
  congr 2
  ring

/-- The factorization in pointwise form. -/
theorem prodSoftmax_apply (beta : ℝ) (s₁ : Fin m₁ → ℝ) (s₂ : Fin m₂ → ℝ)
    (a : Fin m₁) (b : Fin m₂) :
    prodSoftmax beta s₁ s₂ (a, b) = scoreSoftmax beta s₁ a * scoreSoftmax beta s₂ b :=
  prodSoftmax_eq_mul beta s₁ s₂ (a, b)

theorem prodSoftmax_pos (beta : ℝ) (s₁ : Fin m₁ → ℝ) (s₂ : Fin m₂ → ℝ)
    (j : Fin m₁ × Fin m₂) : 0 < prodSoftmax beta s₁ s₂ j := by
  rw [prodSoftmax_eq_mul]
  exact mul_pos (scoreSoftmax_pos beta s₁ j.1) (scoreSoftmax_pos beta s₂ j.2)

theorem prodSoftmax_sum_one (beta : ℝ) (s₁ : Fin m₁ → ℝ) (s₂ : Fin m₂ → ℝ)
    (i₁ : Fin m₁) (i₂ : Fin m₂) : ∑ j : Fin m₁ × Fin m₂, prodSoftmax beta s₁ s₂ j = 1 := by
  have h₁ : ∑ a, scoreSoftmax beta s₁ a = 1 := scoreSoftmax_sum_one beta s₁ i₁
  have h₂ : ∑ b, scoreSoftmax beta s₂ b = 1 := scoreSoftmax_sum_one beta s₂ i₂
  rw [Fintype.sum_prod_type]
  rw [Finset.sum_congr rfl fun a _ => (by
    rw [Finset.sum_congr rfl fun b _ => prodSoftmax_apply beta s₁ s₂ a b, ← Finset.mul_sum,
      h₂, mul_one] :
      ∑ b, prodSoftmax beta s₁ s₂ (a, b) = scoreSoftmax beta s₁ a), h₁]

/-- Marginalizing out the second mode returns the first mode's attention. -/
theorem prodSoftmax_marginal_left (beta : ℝ) (s₁ : Fin m₁ → ℝ) (s₂ : Fin m₂ → ℝ)
    (i₂ : Fin m₂) (a : Fin m₁) :
    ∑ b, prodSoftmax beta s₁ s₂ (a, b) = scoreSoftmax beta s₁ a := by
  rw [Finset.sum_congr rfl fun b _ => prodSoftmax_apply beta s₁ s₂ a b, ← Finset.mul_sum,
    scoreSoftmax_sum_one beta s₂ i₂, mul_one]

/-- Marginalizing out the first mode returns the second mode's attention. -/
theorem prodSoftmax_marginal_right (beta : ℝ) (s₁ : Fin m₁ → ℝ) (s₂ : Fin m₂ → ℝ)
    (i₁ : Fin m₁) (b : Fin m₂) :
    ∑ a, prodSoftmax beta s₁ s₂ (a, b) = scoreSoftmax beta s₂ b := by
  rw [Finset.sum_congr rfl fun a _ => prodSoftmax_apply beta s₁ s₂ a b, ← Finset.sum_mul,
    scoreSoftmax_sum_one beta s₁ i₁, one_mul]

/-! ## Additivity of the attention entropy -/

/-- Shannon entropy of a distribution over a product key set. -/
def shannonEntropyProd (p : Fin m₁ × Fin m₂ → ℝ) : ℝ :=
  -∑ j : Fin m₁ × Fin m₂, p j * Real.log (p j)

/-- **The attention entropy is additive over independent modes.** -/
theorem shannonEntropy_prodSoftmax (beta : ℝ) (s₁ : Fin m₁ → ℝ) (s₂ : Fin m₂ → ℝ)
    (i₁ : Fin m₁) (i₂ : Fin m₂) :
    shannonEntropyProd (prodSoftmax beta s₁ s₂)
      = shannonEntropy (scoreSoftmax beta s₁) + shannonEntropy (scoreSoftmax beta s₂) := by
  have h₁ : ∑ a, scoreSoftmax beta s₁ a = 1 := scoreSoftmax_sum_one beta s₁ i₁
  have h₂ : ∑ b, scoreSoftmax beta s₂ b = 1 := scoreSoftmax_sum_one beta s₂ i₂
  have hterm : ∀ (a : Fin m₁) (b : Fin m₂),
      prodSoftmax beta s₁ s₂ (a, b) * Real.log (prodSoftmax beta s₁ s₂ (a, b))
        = (scoreSoftmax beta s₁ a * Real.log (scoreSoftmax beta s₁ a)) * scoreSoftmax beta s₂ b
          + scoreSoftmax beta s₁ a
            * (scoreSoftmax beta s₂ b * Real.log (scoreSoftmax beta s₂ b)) := by
    intro a b
    rw [prodSoftmax_apply, Real.log_mul (ne_of_gt (scoreSoftmax_pos beta s₁ a))
      (ne_of_gt (scoreSoftmax_pos beta s₂ b))]
    ring
  have hrow : ∀ a : Fin m₁,
      ∑ b, prodSoftmax beta s₁ s₂ (a, b) * Real.log (prodSoftmax beta s₁ s₂ (a, b))
        = scoreSoftmax beta s₁ a * Real.log (scoreSoftmax beta s₁ a)
          + scoreSoftmax beta s₁ a
            * ∑ b, scoreSoftmax beta s₂ b * Real.log (scoreSoftmax beta s₂ b) := by
    intro a
    rw [Finset.sum_congr rfl fun b _ => hterm a b, Finset.sum_add_distrib, ← Finset.mul_sum,
      ← Finset.mul_sum, h₂, mul_one]
  rw [shannonEntropyProd, Fintype.sum_prod_type, Finset.sum_congr rfl fun a _ => hrow a,
    Finset.sum_add_distrib, ← Finset.sum_mul, h₁, one_mul, shannonEntropy, shannonEntropy]
  ring

end BookProof.ChapterAttentionFactorization

end
