import Mathlib
import BookProof.ChapterAttentionRetrieval

/-!
# Chapter "The Coherent State of Attention": attention is a Markov kernel

Read row-wise, an attention layer is a **stochastic matrix**: the row `i` is the
Born distribution of the query at position `i` over the keys.  Pushing a
distribution over positions through the layer is therefore a Markov step, and
stacking layers composes the kernels.  This module proves that the picture is
consistent and that it *contracts*.

* `attentionMatrix_isStochastic` — the rows are strictly positive and sum to one.
* `push_isProb`, `compose_isStochastic`, `push_compose` — pushing a probability
  vector through a layer gives a probability vector, composing two layers gives a
  layer, and the composite acts as the composition of the two steps.
* `l1dist_push_le` — a Markov step is `ℓ¹`-nonexpansive: attention never
  *increases* the discrepancy between two beliefs about position.
* `l1dist_push_le_of_min` — **Doeblin contraction**: if every entry of the layer
  is at least `ε`, one step contracts the `ℓ¹` distance by the factor `1 − mε`.
* `l1dist_push_attentionMatrix_le` — combined with the finite-temperature lower
  bound `scoreSoftmax_ge_of_spread` of `ChapterAttentionRetrieval`, a layer whose
  scores have spread at most `D` contracts by the factor `1 − e^{−βD} < 1`:
  **stacked attention forgets its input geometrically fast** unless the scores are
  allowed to spread with depth.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionMarkov

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterAttentionRetrieval

variable {m : ℕ}

/-! ## Stochastic matrices -/

/-- A matrix is **stochastic** when its entries are nonnegative and each row sums
to one. -/
def IsStochastic (P : Fin m → Fin m → ℝ) : Prop :=
  (∀ i j, 0 ≤ P i j) ∧ ∀ i, ∑ j, P i j = 1

/-- A vector is a **probability vector** when it is nonnegative and sums to one. -/
def IsProb (p : Fin m → ℝ) : Prop := (∀ j, 0 ≤ p j) ∧ ∑ j, p j = 1

/-- The **attention kernel**: row `i` is the Softmax of the score row `S i`. -/
def attentionMatrix (beta : ℝ) (S : Fin m → Fin m → ℝ) (i j : Fin m) : ℝ :=
  scoreSoftmax beta (S i) j

/-- Pushing a distribution over positions forward through a kernel. -/
def push (P : Fin m → Fin m → ℝ) (p : Fin m → ℝ) (j : Fin m) : ℝ := ∑ i, p i * P i j

/-- Composition of two kernels (the two-layer kernel). -/
def compose (P Q : Fin m → Fin m → ℝ) (i j : Fin m) : ℝ := ∑ k, P i k * Q k j

/-- The `ℓ¹` (total-variation-like) distance between two vectors. -/
def l1dist (p q : Fin m → ℝ) : ℝ := ∑ j, |p j - q j|

/-! ## The attention kernel is stochastic -/

theorem attentionMatrix_pos (beta : ℝ) (S : Fin m → Fin m → ℝ) (i j : Fin m) :
    0 < attentionMatrix beta S i j := scoreSoftmax_pos beta (S i) j

/-- **Attention is a Markov kernel.** -/
theorem attentionMatrix_isStochastic (beta : ℝ) (S : Fin m → Fin m → ℝ) :
    IsStochastic (attentionMatrix beta S) :=
  ⟨fun i j => (attentionMatrix_pos beta S i j).le,
    fun i => scoreSoftmax_sum_one beta (S i) i⟩

/-! ## A Markov step preserves probability -/

theorem push_nonneg {P : Fin m → Fin m → ℝ} {p : Fin m → ℝ} (hP : IsStochastic P)
    (hp : ∀ j, 0 ≤ p j) (j : Fin m) : 0 ≤ push P p j :=
  Finset.sum_nonneg fun i _ => mul_nonneg (hp i) (hP.1 i j)

theorem push_sum_one {P : Fin m → Fin m → ℝ} {p : Fin m → ℝ} (hP : IsStochastic P)
    (hp : ∑ j, p j = 1) : ∑ j, push P p j = 1 := by
  calc ∑ j, push P p j = ∑ i, ∑ j, p i * P i j := by
        simp only [push]
        exact Finset.sum_comm
    _ = ∑ i, p i := by
        refine Finset.sum_congr rfl fun i _ => ?_
        rw [← Finset.mul_sum, hP.2 i, mul_one]
    _ = 1 := hp

theorem push_isProb {P : Fin m → Fin m → ℝ} {p : Fin m → ℝ} (hP : IsStochastic P)
    (hp : IsProb p) : IsProb (push P p) :=
  ⟨fun j => push_nonneg hP hp.1 j, push_sum_one hP hp.2⟩

/-! ## Stacking layers -/

theorem compose_isStochastic {P Q : Fin m → Fin m → ℝ} (hP : IsStochastic P)
    (hQ : IsStochastic Q) : IsStochastic (compose P Q) := by
  refine ⟨fun i j => Finset.sum_nonneg fun k _ => mul_nonneg (hP.1 i k) (hQ.1 k j), fun i => ?_⟩
  calc ∑ j, compose P Q i j = ∑ k, ∑ j, P i k * Q k j := by
        simp only [compose]
        exact Finset.sum_comm
    _ = ∑ k, P i k := by
        refine Finset.sum_congr rfl fun k _ => ?_
        rw [← Finset.mul_sum, hQ.2 k, mul_one]
    _ = 1 := hP.2 i

/-- Two layers act as the composite kernel. -/
theorem push_compose (P Q : Fin m → Fin m → ℝ) (p : Fin m → ℝ) (j : Fin m) :
    push (compose P Q) p j = push Q (push P p) j := by
  simp only [push, compose, Finset.mul_sum, Finset.sum_mul]
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun i _ => by ring

/-! ## Contraction -/

theorem l1dist_nonneg (p q : Fin m → ℝ) : 0 ≤ l1dist p q :=
  Finset.sum_nonneg fun _ _ => abs_nonneg _

/-- **A Markov step is `ℓ¹`-nonexpansive.** -/
theorem l1dist_push_le {P : Fin m → Fin m → ℝ} (hP : IsStochastic P) (p q : Fin m → ℝ) :
    l1dist (push P p) (push P q) ≤ l1dist p q := by
  have hstep : ∀ j : Fin m, |push P p j - push P q j| ≤ ∑ i, |p i - q i| * P i j := by
    intro j
    have hdiff : push P p j - push P q j = ∑ i, (p i - q i) * P i j := by
      simp only [push, ← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun i _ => by ring
    rw [hdiff]
    refine (Finset.abs_sum_le_sum_abs _ _).trans (le_of_eq ?_)
    exact Finset.sum_congr rfl fun i _ => by
      rw [abs_mul, abs_of_nonneg (hP.1 i j)]
  calc l1dist (push P p) (push P q) ≤ ∑ j, ∑ i, |p i - q i| * P i j :=
        Finset.sum_le_sum fun j _ => hstep j
    _ = ∑ i, |p i - q i| := by
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun i _ => ?_
        rw [← Finset.mul_sum, hP.2 i, mul_one]
    _ = l1dist p q := rfl

/-- **Doeblin contraction.**  If every entry of the kernel is at least `ε`, one
Markov step contracts the `ℓ¹` distance between probability vectors by `1 − mε`. -/
theorem l1dist_push_le_of_min {P : Fin m → Fin m → ℝ} {p q : Fin m → ℝ} {eps : ℝ}
    (hP : IsStochastic P) (hmin : ∀ i j, eps ≤ P i j) (hp : IsProb p) (hq : IsProb q) :
    l1dist (push P p) (push P q) ≤ (1 - m * eps) * l1dist p q := by
  have hzero : ∑ i, (p i - q i) = 0 := by
    rw [Finset.sum_sub_distrib, hp.2, hq.2, sub_self]
  have hstep : ∀ j : Fin m,
      |push P p j - push P q j| ≤ ∑ i, |p i - q i| * (P i j - eps) := by
    intro j
    have hdiff : push P p j - push P q j = ∑ i, (p i - q i) * (P i j - eps) := by
      have h1 : ∑ i, (p i - q i) * (P i j - eps)
          = (∑ i, (p i - q i) * P i j) - (∑ i, (p i - q i)) * eps := by
        rw [Finset.sum_mul, ← Finset.sum_sub_distrib]
        exact Finset.sum_congr rfl fun i _ => by ring
      rw [h1, hzero, zero_mul, sub_zero]
      simp only [push, ← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun i _ => by ring
    rw [hdiff]
    refine (Finset.abs_sum_le_sum_abs _ _).trans (le_of_eq ?_)
    exact Finset.sum_congr rfl fun i _ => by
      rw [abs_mul, abs_of_nonneg (by linarith [hmin i j] : (0 : ℝ) ≤ P i j - eps)]
  calc l1dist (push P p) (push P q) ≤ ∑ j, ∑ i, |p i - q i| * (P i j - eps) :=
        Finset.sum_le_sum fun j _ => hstep j
    _ = ∑ i, |p i - q i| * (1 - m * eps) := by
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun i _ => ?_
        rw [← Finset.mul_sum]
        congr 1
        rw [Finset.sum_sub_distrib, hP.2 i]
        simp [Finset.card_univ, mul_comm]
    _ = (1 - m * eps) * l1dist p q := by
        rw [l1dist, Finset.mul_sum]
        exact Finset.sum_congr rfl fun i _ => by ring

/-- **Stacked attention mixes.**  If the scores of every row have spread at most
`D`, one attention layer contracts the `ℓ¹` distance between two beliefs about
position by the factor `1 − e^{−βD}`, which is `< 1` at every finite temperature. -/
theorem l1dist_push_attentionMatrix_le {beta D : ℝ} (hb : 0 ≤ beta)
    {S : Fin m → Fin m → ℝ} {p q : Fin m → ℝ} (hp : IsProb p) (hq : IsProb q)
    (hD : ∀ i j l, S i l ≤ S i j + D) :
    l1dist (push (attentionMatrix beta S) p) (push (attentionMatrix beta S) q)
      ≤ (1 - Real.exp (-(beta * D))) * l1dist p q := by
  rcases Nat.eq_zero_or_pos m with hm0 | hm0
  · subst hm0
    have := hp.2
    simp at this
  have hmpos : (0 : ℝ) < (m : ℝ) := by exact_mod_cast hm0
  have hmin : ∀ i j, Real.exp (-(beta * D)) / (m : ℝ) ≤ attentionMatrix beta S i j := by
    intro i j
    exact scoreSoftmax_ge_of_spread hb (S i) j (fun l => hD i j l)
  have h := l1dist_push_le_of_min (attentionMatrix_isStochastic beta S) hmin hp hq
  have hfac : (m : ℝ) * (Real.exp (-(beta * D)) / (m : ℝ)) = Real.exp (-(beta * D)) := by
    field_simp
  rwa [hfac] at h

end BookProof.ChapterAttentionMarkov

end
