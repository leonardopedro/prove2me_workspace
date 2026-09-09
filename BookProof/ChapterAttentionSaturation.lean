import Mathlib
import BookProof.ChapterSoftmaxJacobian

/-!
# Chapter "The Coherent State of Attention": a saturated head cannot learn

`ChapterSoftmaxJacobian` computes the derivative of the attention weights in the
scores, `∂pⱼ/∂sᵢ = β·pⱼ(δᵢⱼ − pᵢ)`.  This module reads that formula as a statement
about learning: the total size of the learning signal reaching key `i` is exactly
`2β·pᵢ(1 − pᵢ)`, a quantity that vanishes when the head is *saturated* — when it
has committed almost all of its weight to one key.

* `add_scoreSoftmax_le_one` — two distinct keys can never carry more than the whole
  attention;
* `abs_softmaxJacobian_le` — every Jacobian entry of row `i` is at most
  `β·pᵢ(1 − pᵢ)` in absolute value;
* **`sum_abs_softmaxJacobian_row`** — the headline identity: the row's total
  absolute response is exactly `2β·pᵢ(1 − pᵢ)`;
* `sum_abs_softmaxJacobian_le_half` — hence never more than `β/2`, whatever the
  scores: a single score cannot move the head arbitrarily fast;
* `sum_abs_softmaxJacobian_le_of_dominant`, `sum_abs_softmaxJacobian_le_of_small`
  and `sum_abs_softmaxJacobian_le_of_confident` — **saturation kills the gradient**:
  once some key carries `1 − ε` of the attention, *every* row of the Jacobian has
  total size at most `2βε`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionSaturation

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterSoftmaxFluctuation BookProof.ChapterSoftmaxJacobian

variable {m : ℕ}

/-! ## Two keys never carry more than the whole attention -/

/-- Distinct keys carry a total weight of at most `1`. -/
theorem add_scoreSoftmax_le_one (beta : ℝ) (s : Fin m → ℝ) {i j : Fin m} (hij : j ≠ i) :
    scoreSoftmax beta s i + scoreSoftmax beta s j ≤ 1 := by
  have hsum : ∑ l, scoreSoftmax beta s l = 1 := scoreSoftmax_sum_one beta s i
  have hpair : scoreSoftmax beta s i + scoreSoftmax beta s j
      = ∑ l ∈ ({i, j} : Finset (Fin m)), scoreSoftmax beta s l := by
    rw [Finset.sum_pair (Ne.symm hij)]
  rw [hpair, ← hsum]
  exact Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ _)
    fun l _ _ => (scoreSoftmax_pos beta s l).le

/-! ## The size of the learning signal -/

/-- Every entry of the `i`-th Jacobian row is bounded by `β·pᵢ(1 − pᵢ)`. -/
theorem abs_softmaxJacobian_le {beta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ) (i j : Fin m) :
    |softmaxJacobian beta s i j|
      ≤ beta * scoreSoftmax beta s i * (1 - scoreSoftmax beta s i) := by
  have hpi : 0 < scoreSoftmax beta s i := scoreSoftmax_pos beta s i
  have hpi1 : scoreSoftmax beta s i ≤ 1 := scoreSoftmax_le_one beta s i
  rcases eq_or_ne j i with hj | hj
  · subst hj
    rw [abs_of_nonneg (softmaxJacobian_diag_nonneg hb s j), softmaxJacobian, if_pos rfl]
  · have hpj : 0 < scoreSoftmax beta s j := scoreSoftmax_pos beta s j
    have hpair := add_scoreSoftmax_le_one beta s hj
    have heq : softmaxJacobian beta s i j
        = -(beta * scoreSoftmax beta s j * scoreSoftmax beta s i) := by
      simp only [softmaxJacobian, hj, if_false]
      ring
    rw [heq, abs_neg,
      abs_of_nonneg (mul_nonneg (mul_nonneg hb hpj.le) hpi.le)]
    have : scoreSoftmax beta s j ≤ 1 - scoreSoftmax beta s i := by linarith
    nlinarith [mul_nonneg hb hpi.le]

/-- **The learning signal of a key.**  The total absolute response of the attention
distribution to a nudge of the score of key `i` is exactly `2β·pᵢ(1 − pᵢ)`. -/
theorem sum_abs_softmaxJacobian_row {beta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ) (i : Fin m) :
    ∑ j, |softmaxJacobian beta s i j|
      = 2 * (beta * scoreSoftmax beta s i * (1 - scoreSoftmax beta s i)) := by
  have hdiag : softmaxJacobian beta s i i
      = beta * scoreSoftmax beta s i * (1 - scoreSoftmax beta s i) := by
    rw [softmaxJacobian, if_pos rfl]
  have hrow : ∑ j, softmaxJacobian beta s i j = 0 := softmaxJacobian_row_sum_zero beta s i
  have hsplit : |softmaxJacobian beta s i i|
      + ∑ j ∈ Finset.univ.erase i, |softmaxJacobian beta s i j|
      = ∑ j, |softmaxJacobian beta s i j| :=
    Finset.add_sum_erase Finset.univ (fun j => |softmaxJacobian beta s i j|)
      (Finset.mem_univ i)
  have hsplit' : softmaxJacobian beta s i i
      + ∑ j ∈ Finset.univ.erase i, softmaxJacobian beta s i j
      = ∑ j, softmaxJacobian beta s i j :=
    Finset.add_sum_erase Finset.univ (fun j => softmaxJacobian beta s i j)
      (Finset.mem_univ i)
  have hoff : ∑ j ∈ Finset.univ.erase i, |softmaxJacobian beta s i j|
      = -∑ j ∈ Finset.univ.erase i, softmaxJacobian beta s i j := by
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun j hj => ?_
    have hji : j ≠ i := (Finset.mem_erase.1 hj).1
    exact abs_of_nonpos (softmaxJacobian_offDiag_nonpos hb s hji)
  rw [← hsplit, hoff, abs_of_nonneg (softmaxJacobian_diag_nonneg hb s i)]
  rw [hrow] at hsplit'
  rw [hdiag] at hsplit' ⊢
  linarith

/-- Whatever the scores, one score can move the attention distribution at rate at
most `β/2` in `ℓ¹`. -/
theorem sum_abs_softmaxJacobian_le_half {beta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    (i : Fin m) :
    ∑ j, |softmaxJacobian beta s i j| ≤ beta / 2 := by
  rw [sum_abs_softmaxJacobian_row hb s i]
  nlinarith [sq_nonneg (scoreSoftmax beta s i - 1 / 2), hb]

/-! ## Saturation kills the gradient -/

/-- A key that already dominates the head receives almost no learning signal. -/
theorem sum_abs_softmaxJacobian_le_of_dominant {beta eps : ℝ} (hb : 0 ≤ beta)
    (s : Fin m → ℝ) (i : Fin m) (h : 1 - eps ≤ scoreSoftmax beta s i) :
    ∑ j, |softmaxJacobian beta s i j| ≤ 2 * beta * eps := by
  have hpi : 0 < scoreSoftmax beta s i := scoreSoftmax_pos beta s i
  have hpi1 : scoreSoftmax beta s i ≤ 1 := scoreSoftmax_le_one beta s i
  rw [sum_abs_softmaxJacobian_row hb s i]
  have hp : scoreSoftmax beta s i * (1 - scoreSoftmax beta s i) ≤ eps := by nlinarith
  nlinarith [mul_le_mul_of_nonneg_left hp hb]

/-- A key that has been all but ignored receives almost no learning signal either. -/
theorem sum_abs_softmaxJacobian_le_of_small {beta eps : ℝ} (hb : 0 ≤ beta)
    (s : Fin m → ℝ) (i : Fin m) (h : scoreSoftmax beta s i ≤ eps) :
    ∑ j, |softmaxJacobian beta s i j| ≤ 2 * beta * eps := by
  have hpi : 0 < scoreSoftmax beta s i := scoreSoftmax_pos beta s i
  have hpi1 : scoreSoftmax beta s i ≤ 1 := scoreSoftmax_le_one beta s i
  rw [sum_abs_softmaxJacobian_row hb s i]
  have hp : scoreSoftmax beta s i * (1 - scoreSoftmax beta s i) ≤ eps := by nlinarith
  nlinarith [mul_le_mul_of_nonneg_left hp hb]

/-- **A confident head has a vanishing gradient.**  If some key already carries
`1 − ε` of the attention, then *every* score has total influence at most `2βε`: a
head that has made up its mind is hard to teach. -/
theorem sum_abs_softmaxJacobian_le_of_confident {beta eps : ℝ} (hb : 0 ≤ beta)
    (s : Fin m → ℝ) {i₀ : Fin m} (h : 1 - eps ≤ scoreSoftmax beta s i₀) (i : Fin m) :
    ∑ j, |softmaxJacobian beta s i j| ≤ 2 * beta * eps := by
  rcases eq_or_ne i i₀ with rfl | hii
  · exact sum_abs_softmaxJacobian_le_of_dominant hb s i h
  · refine sum_abs_softmaxJacobian_le_of_small hb s i ?_
    have hpair := add_scoreSoftmax_le_one beta s (i := i₀) (j := i) hii
    linarith

end BookProof.ChapterAttentionSaturation

end
