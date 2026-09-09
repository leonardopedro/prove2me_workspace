import Mathlib
import BookProof.ChapterAttentionEntropy
import BookProof.ChapterSoftmaxFluctuation

/-!
# Chapter "The Coherent State of Attention" — Softmax as the maximum-entropy
attention

`ChapterAttentionEntropy` bounds the entropy of the attention distribution by
`log m` and computes its two extreme limits.  This module proves the *variational
characterisation* which explains why Softmax is the attention rule and not merely
a convenient one:

> Among **all** attention distributions with a prescribed mean alignment score,
> the Softmax distribution is the one of maximal Shannon entropy — it is the
> least committed distribution consistent with the observed alignment.

Deliverables:

* `crossEntropy` and `shannonEntropy_le_crossEntropy` — **Gibbs' inequality** in
  its general form: `H(p) ≤ -∑ⱼ pⱼ log qⱼ` for any probability vector `p` and any
  strictly positive sub-probability vector `q`.  (`ChapterAttentionEntropy`'s
  `shannonEntropy_le_log_card` is the uniform case.)
* `log_scoreSoftmax` — the Boltzmann form `log pⱼ(β) = β sⱼ − log Z(β)`;
* `shannonEntropy_scoreSoftmax` — the **thermodynamic identity**
  `H(β) = log Z(β) − β ⟨s⟩_β`;
* `shannonEntropy_le_of_meanScore_eq` — **the headline**: every probability
  distribution with the same mean score as `scoreSoftmax β s` has entropy at most
  `H(scoreSoftmax β s)`;
* `crossEntropy_scoreSoftmax` and `softmax_free_energy_le` — the equivalent free
  energy statement: Softmax minimises `β·⟨s⟩_p − H(p)` over all distributions `p`,
  the minimum being `−log Z(β)`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterSoftmaxMaxEntropy

open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness
  BookProof.ChapterSoftmaxOrder BookProof.ChapterSoftmaxFluctuation

variable {m : ℕ}

/-! ## Gibbs' inequality -/

/-- The **cross entropy** `-∑ⱼ pⱼ log qⱼ` of `p` relative to `q`. -/
def crossEntropy (p q : Fin m → ℝ) : ℝ := -∑ j, p j * Real.log (q j)

/-- **Gibbs' inequality.**  The Shannon entropy of a probability vector never
exceeds its cross entropy against any strictly positive sub-probability vector;
equivalently the Kullback–Leibler divergence is nonnegative. -/
theorem shannonEntropy_le_crossEntropy {p q : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j)
    (hpsum : ∑ j, p j = 1) (hq0 : ∀ j, 0 < q j) (hqsum : ∑ j, q j ≤ 1) :
    shannonEntropy p ≤ crossEntropy p q := by
  have hterm : ∀ j ∈ (Finset.univ : Finset (Fin m)),
      -(p j * Real.log (p j)) + p j * Real.log (q j) ≤ q j - p j := by
    intro j _
    rcases eq_or_lt_of_le (hp0 j) with h | h
    · rw [← h]
      simpa using (hq0 j).le
    · have hratio : 0 < q j / p j := div_pos (hq0 j) h
      have hlog := Real.log_le_sub_one_of_pos hratio
      rw [Real.log_div (ne_of_gt (hq0 j)) (ne_of_gt h)] at hlog
      have hmul : p j * (Real.log (q j) - Real.log (p j))
          ≤ p j * (q j / p j - 1) := mul_le_mul_of_nonneg_left hlog h.le
      have hsimp : p j * (q j / p j - 1) = q j - p j := by field_simp
      rw [hsimp] at hmul
      nlinarith [hmul]
  have hsum := Finset.sum_le_sum hterm
  have hleft : ∑ j, (-(p j * Real.log (p j)) + p j * Real.log (q j))
      = shannonEntropy p - crossEntropy p q := by
    rw [Finset.sum_add_distrib, shannonEntropy, crossEntropy, ← Finset.sum_neg_distrib]
    ring
  have hright : ∑ j, (q j - p j) = (∑ j, q j) - 1 := by
    rw [Finset.sum_sub_distrib, hpsum]
  rw [hleft, hright] at hsum
  linarith

/-! ## The Boltzmann form of the attention weights -/

/-- The **Boltzmann form**: `log pⱼ(β) = β sⱼ − log Z(β)`. -/
theorem log_scoreSoftmax (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    Real.log (scoreSoftmax beta s j) = beta * s j - logPartition beta s := by
  rw [scoreSoftmax_eq_div, Real.log_div (Real.exp_ne_zero _) (partition_ne_zero beta s j),
    Real.log_exp, logPartition]

/-- The **thermodynamic identity** for the attention head:
`H(β) = log Z(β) − β ⟨s⟩_β`. -/
theorem shannonEntropy_scoreSoftmax (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    shannonEntropy (scoreSoftmax beta s) = logPartition beta s - beta * meanScore beta s := by
  have hsum : ∑ l, scoreSoftmax beta s l = 1 := scoreSoftmax_sum_one beta s i
  have hterm : ∀ l : Fin m, scoreSoftmax beta s l * Real.log (scoreSoftmax beta s l)
      = beta * (scoreSoftmax beta s l * s l) - logPartition beta s * scoreSoftmax beta s l := by
    intro l; rw [log_scoreSoftmax]; ring
  rw [shannonEntropy, Finset.sum_congr rfl fun l _ => hterm l, Finset.sum_sub_distrib,
    ← Finset.mul_sum, ← Finset.mul_sum, hsum, ← meanScore]
  ring

/-- The cross entropy against the Softmax distribution depends on `p` only through
its mean score. -/
theorem crossEntropy_scoreSoftmax (beta : ℝ) (s : Fin m → ℝ) {p : Fin m → ℝ}
    (hpsum : ∑ j, p j = 1) :
    crossEntropy p (scoreSoftmax beta s) = logPartition beta s - beta * ∑ j, p j * s j := by
  have hterm : ∀ j : Fin m, p j * Real.log (scoreSoftmax beta s j)
      = beta * (p j * s j) - logPartition beta s * p j := by
    intro j; rw [log_scoreSoftmax]; ring
  rw [crossEntropy, Finset.sum_congr rfl fun j _ => hterm j, Finset.sum_sub_distrib,
    ← Finset.mul_sum, ← Finset.mul_sum, hpsum]
  ring

/-! ## The maximum-entropy principle -/

/-- **Softmax is the maximum-entropy attention at a given mean score.**  Any
probability distribution over the keys whose mean alignment score equals that of
`scoreSoftmax β s` has entropy at most `H(scoreSoftmax β s)`. -/
theorem shannonEntropy_le_of_meanScore_eq (beta : ℝ) (s : Fin m → ℝ) (i : Fin m)
    {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j) (hpsum : ∑ j, p j = 1)
    (hmean : ∑ j, p j * s j = meanScore beta s) :
    shannonEntropy p ≤ shannonEntropy (scoreSoftmax beta s) := by
  have hq0 : ∀ j, 0 < scoreSoftmax beta s j := fun j => scoreSoftmax_pos beta s j
  have hqsum : ∑ j, scoreSoftmax beta s j ≤ 1 := le_of_eq (scoreSoftmax_sum_one beta s i)
  have hgibbs := shannonEntropy_le_crossEntropy hp0 hpsum hq0 hqsum
  rw [crossEntropy_scoreSoftmax beta s hpsum, hmean,
    ← shannonEntropy_scoreSoftmax beta s i] at hgibbs
  exact hgibbs

/-- **The free-energy form of the same statement.**  Softmax minimises
`β·⟨s⟩_p − H(p)` over all probability distributions `p`, and the minimum value is
`−log Z(β)`. -/
theorem softmax_free_energy_le (beta : ℝ) (s : Fin m → ℝ) (i : Fin m)
    {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j) (hpsum : ∑ j, p j = 1) :
    -logPartition beta s ≤ -(beta * ∑ j, p j * s j) - shannonEntropy p := by
  have hq0 : ∀ j, 0 < scoreSoftmax beta s j := fun j => scoreSoftmax_pos beta s j
  have hqsum : ∑ j, scoreSoftmax beta s j ≤ 1 := le_of_eq (scoreSoftmax_sum_one beta s i)
  have hgibbs := shannonEntropy_le_crossEntropy hp0 hpsum hq0 hqsum
  rw [crossEntropy_scoreSoftmax beta s hpsum] at hgibbs
  linarith

/-- The Softmax distribution attains the free-energy minimum. -/
theorem softmax_free_energy_eq (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    -(beta * ∑ j, scoreSoftmax beta s j * s j) - shannonEntropy (scoreSoftmax beta s)
      = -logPartition beta s := by
  rw [shannonEntropy_scoreSoftmax beta s i, ← meanScore]
  ring

end BookProof.ChapterSoftmaxMaxEntropy

end
