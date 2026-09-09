import Mathlib
import BookProof.ChapterAttentionMarkov

/-!
# Chapter "The Coherent State of Attention": iterating the layer

`ChapterAttentionMarkov` shows that one attention layer is a Markov step which
contracts the `ℓ¹` distance between two beliefs about position.  Iterating that
estimate is the mixing statement for a deep stack.

* `pushIter_isProb`, `l1dist_pushIter_le` — after `n` layers two beliefs are within
  `(1 − mε)ⁿ` of their initial `ℓ¹` distance.
* `tendsto_l1dist_pushIter` — with a strictly positive floor `ε` the distance tends
  to `0`: **the stack forgets which belief it started from**.
* `eq_of_stationary` — and there is at most one stationary belief.
* `tendsto_l1dist_pushIter_attentionMatrix` — for a genuine attention layer at
  `β ≥ 0` whose row scores have spread at most `D`, the rate is `(1 − e^{−βD})ⁿ`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

open Filter Topology

noncomputable section

namespace BookProof.ChapterAttentionMixing

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterAttentionRetrieval BookProof.ChapterAttentionMarkov

variable {m : ℕ}

/-- The belief after `n` attention layers with the same kernel. -/
def pushIter (P : Fin m → Fin m → ℝ) (n : ℕ) (p : Fin m → ℝ) : Fin m → ℝ :=
  (push P)^[n] p

theorem pushIter_zero (P : Fin m → Fin m → ℝ) (p : Fin m → ℝ) : pushIter P 0 p = p := rfl

theorem pushIter_succ (P : Fin m → Fin m → ℝ) (n : ℕ) (p : Fin m → ℝ) :
    pushIter P (n + 1) p = push P (pushIter P n p) :=
  Function.iterate_succ_apply' _ _ _

theorem pushIter_isProb {P : Fin m → Fin m → ℝ} {p : Fin m → ℝ} (hP : IsStochastic P)
    (hp : IsProb p) (n : ℕ) : IsProb (pushIter P n p) := by
  induction n with
  | zero => exact hp
  | succ n ih => rw [pushIter_succ]; exact push_isProb hP ih

/-- An entrywise floor `ε` for a stochastic matrix forces `mε ≤ 1`. -/
theorem mul_min_le_one {P : Fin m → Fin m → ℝ} {eps : ℝ} (hP : IsStochastic P)
    (hmin : ∀ i j, eps ≤ P i j) (i : Fin m) : (m : ℝ) * eps ≤ 1 := by
  have h : ∑ _j : Fin m, eps ≤ ∑ j, P i j := Finset.sum_le_sum fun j _ => hmin i j
  rw [hP.2 i] at h
  simpa [Finset.card_univ, mul_comm] using h

/-- **The mixing estimate**: after `n` layers, two beliefs are `(1 − mε)ⁿ` times as
far apart as they started. -/
theorem l1dist_pushIter_le {P : Fin m → Fin m → ℝ} {p q : Fin m → ℝ} {eps : ℝ}
    (hP : IsStochastic P) (hmin : ∀ i j, eps ≤ P i j) (hp : IsProb p) (hq : IsProb q)
    (n : ℕ) :
    l1dist (pushIter P n p) (pushIter P n q) ≤ (1 - m * eps) ^ n * l1dist p q := by
  induction n with
  | zero => simp [pushIter_zero]
  | succ n ih =>
      rcases Nat.eq_zero_or_pos m with hm0 | hm0
      · subst hm0
        simp [l1dist]
      have hi : Fin m := ⟨0, hm0⟩
      have hc0 : 0 ≤ 1 - (m : ℝ) * eps := by
        have := mul_min_le_one hP hmin hi
        linarith
      have hstep := l1dist_push_le_of_min hP hmin (pushIter_isProb hP hp n)
        (pushIter_isProb hP hq n)
      rw [pushIter_succ, pushIter_succ]
      calc l1dist (push P (pushIter P n p)) (push P (pushIter P n q))
          ≤ (1 - m * eps) * l1dist (pushIter P n p) (pushIter P n q) := hstep
        _ ≤ (1 - m * eps) * ((1 - m * eps) ^ n * l1dist p q) :=
            mul_le_mul_of_nonneg_left ih hc0
        _ = (1 - m * eps) ^ (n + 1) * l1dist p q := by ring

/-- **The stack forgets its input**: with a strictly positive floor the beliefs
converge together. -/
theorem tendsto_l1dist_pushIter {P : Fin m → Fin m → ℝ} {p q : Fin m → ℝ} {eps : ℝ}
    (hP : IsStochastic P) (hmin : ∀ i j, eps ≤ P i j) (hp : IsProb p) (hq : IsProb q)
    (hpos : 0 < eps) (i : Fin m) :
    Tendsto (fun n => l1dist (pushIter P n p) (pushIter P n q)) atTop (𝓝 0) := by
  have hmpos : (0 : ℝ) < (m : ℝ) := by exact_mod_cast i.pos
  have hc0 : 0 ≤ 1 - (m : ℝ) * eps := by
    have := mul_min_le_one hP hmin i
    linarith
  have hc1 : 1 - (m : ℝ) * eps < 1 := by nlinarith
  have hlim : Tendsto (fun n : ℕ => (1 - (m : ℝ) * eps) ^ n * l1dist p q) atTop (𝓝 0) := by
    have := tendsto_pow_atTop_nhds_zero_of_lt_one hc0 hc1
    simpa using this.mul_const (l1dist p q)
  refine squeeze_zero (fun n => l1dist_nonneg _ _) (fun n => ?_) hlim
  exact l1dist_pushIter_le hP hmin hp hq n

/-- **At most one stationary belief.** -/
theorem eq_of_stationary {P : Fin m → Fin m → ℝ} {p q : Fin m → ℝ} {eps : ℝ}
    (hP : IsStochastic P) (hmin : ∀ i j, eps ≤ P i j) (hp : IsProb p) (hq : IsProb q)
    (hpos : 0 < eps) (i : Fin m) (hfp : push P p = p) (hfq : push P q = q) : p = q := by
  have hmpos : (0 : ℝ) < (m : ℝ) := by exact_mod_cast i.pos
  have hc1 : 1 - (m : ℝ) * eps < 1 := by nlinarith
  have hstep := l1dist_push_le_of_min hP hmin hp hq
  rw [hfp, hfq] at hstep
  have hnn : 0 ≤ l1dist p q := l1dist_nonneg p q
  have hzero : l1dist p q = 0 := by nlinarith
  funext j
  have habs : |p j - q j| = 0 := by
    refine le_antisymm ?_ (abs_nonneg _)
    calc |p j - q j| ≤ ∑ l, |p l - q l| :=
          Finset.single_le_sum (f := fun l => |p l - q l|) (fun l _ => abs_nonneg _)
            (Finset.mem_univ j)
      _ = 0 := hzero
  have := abs_eq_zero.mp habs
  linarith [sub_eq_zero.mp this]

/-! ## A genuine attention layer -/

/-- **A deep stack of one attention layer mixes at the rate `(1 − e^{−βD})ⁿ`.** -/
theorem tendsto_l1dist_pushIter_attentionMatrix {beta D : ℝ} (hb : 0 ≤ beta)
    {S : Fin m → Fin m → ℝ} {p q : Fin m → ℝ} (hp : IsProb p) (hq : IsProb q)
    (hD : ∀ i j l, S i l ≤ S i j + D) (i : Fin m) :
    Tendsto (fun n => l1dist (pushIter (attentionMatrix beta S) n p)
      (pushIter (attentionMatrix beta S) n q)) atTop (𝓝 0) := by
  have hmpos : (0 : ℝ) < (m : ℝ) := by exact_mod_cast i.pos
  have hmin : ∀ a b, Real.exp (-(beta * D)) / (m : ℝ) ≤ attentionMatrix beta S a b := by
    intro a b
    exact scoreSoftmax_ge_of_spread hb (S a) b (fun l => hD a b l)
  exact tendsto_l1dist_pushIter (attentionMatrix_isStochastic beta S) hmin hp hq
    (by positivity) i

end BookProof.ChapterAttentionMixing

end
