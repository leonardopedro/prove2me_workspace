import Mathlib
import BookProof.ChapterAttentionCollision

/-!
# Chapter "The Coherent State of Attention": how concentrated can the Born measurement be?

`ChapterAttentionRetrieval` bounds the attention weights from the *scores*.  This
module bounds them from the *distribution alone*, by the elementary counting
arguments that make "how many keys dominate?" a well-posed question.

* `mul_card_filter_le_one` / `card_filter_le_inv` — a **Markov bound for
  attention**: at most `1/t` keys can carry weight `t` or more.  Only a handful of
  keys can ever be important at once, however the scores are arranged.
* `exists_inv_card_le` — some key always carries at least the uniform share `1/m`.
* `neg_log_le_shannonEntropy` — the **min-entropy bound** `−log pₘₐₓ ≤ H`: the
  dominant weight is never smaller than `e^{−H}` (`exp_neg_shannonEntropy_le`), so
  a low-entropy head really does have a dominant key, and conversely a head with a
  dominant key has low entropy only in the sense this inequality allows.
* `collisionProb_le_max` / `inv_le_effectiveSupport` — the participation ratio of
  `ChapterAttentionCollision` is at least `1/pₘₐₓ`: the effective key count and the
  dominant weight are reciprocal notions.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionConcentration

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterAttentionEntropy BookProof.ChapterAttentionCollision

variable {m : ℕ}

/-! ## A Markov bound: only a few keys can be important -/

/-- **Markov's inequality for attention.**  If `t` of the probability mass is
required of a key, then at most `1/t` keys can qualify. -/
theorem mul_card_filter_le_one {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j) (hsum : ∑ j, p j = 1)
    {t : ℝ} :
    t * ((Finset.univ.filter fun j => t ≤ p j).card : ℝ) ≤ 1 := by
  classical
  set S : Finset (Fin m) := Finset.univ.filter fun j => t ≤ p j with hS
  have h1 : t * (S.card : ℝ) = ∑ _j ∈ S, t := by
    simp [mul_comm]
  have h2 : ∑ _j ∈ S, t ≤ ∑ j ∈ S, p j := by
    refine Finset.sum_le_sum fun j hj => ?_
    have := Finset.mem_filter.mp (hS ▸ hj)
    exact this.2
  have h3 : ∑ j ∈ S, p j ≤ ∑ j, p j :=
    Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ S) fun j _ _ => hp0 j
  rw [h1]
  linarith [hsum ▸ h3]

theorem card_filter_le_inv {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j) (hsum : ∑ j, p j = 1)
    {t : ℝ} (ht : 0 < t) :
    ((Finset.univ.filter fun j => t ≤ p j).card : ℝ) ≤ 1 / t := by
  have h := mul_card_filter_le_one hp0 hsum (t := t)
  rw [le_div_iff₀ ht, mul_comm]
  exact h

/-! ## Some key always carries the uniform share -/

/-- Some key carries at least `1/m` of the attention. -/
theorem exists_inv_card_le {p : Fin m → ℝ} (hsum : ∑ j, p j = 1) :
    ∃ j : Fin m, (m : ℝ)⁻¹ ≤ p j := by
  by_contra hcon
  push_neg at hcon
  have hm : 0 < m := by
    rcases Nat.eq_zero_or_pos m with hm0 | hm0
    · subst hm0; simp at hsum
    · exact hm0
  have hlt : ∑ j, p j < ∑ _j : Fin m, (m : ℝ)⁻¹ :=
    Finset.sum_lt_sum_of_nonempty
      (Finset.univ_nonempty_iff.mpr (Fin.pos_iff_nonempty.mp hm)) fun j _ => hcon j
  have hm' : (m : ℝ) ≠ 0 := by positivity
  have hone : ∑ _j : Fin m, (m : ℝ)⁻¹ = 1 := by
    simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
    field_simp
  rw [hsum, hone] at hlt
  exact lt_irrefl 1 hlt

/-- If `M` bounds every weight then `1/m ≤ M`: no distribution can be flatter than
the uniform one. -/
theorem inv_card_le_of_le {p : Fin m → ℝ} {M : ℝ} (hM : ∀ j, p j ≤ M)
    (hsum : ∑ j, p j = 1) : (m : ℝ)⁻¹ ≤ M := by
  obtain ⟨j, hj⟩ := exists_inv_card_le hsum
  exact hj.trans (hM j)

theorem pos_of_le {p : Fin m → ℝ} {M : ℝ} (hM : ∀ j, p j ≤ M) (hsum : ∑ j, p j = 1) :
    0 < M := by
  have hm : 0 < m := by
    rcases Nat.eq_zero_or_pos m with hm0 | hm0
    · subst hm0; simp at hsum
    · exact hm0
  have hm' : (0 : ℝ) < (m : ℝ) := by exact_mod_cast hm
  exact lt_of_lt_of_le (by positivity) (inv_card_le_of_le hM hsum)

/-! ## The min-entropy bound -/

/-- **The min-entropy is a lower bound for the Shannon entropy.**  If no key
carries more than `M` of the attention then `−log M ≤ H`. -/
theorem neg_log_le_shannonEntropy {p : Fin m → ℝ} {M : ℝ} (hp0 : ∀ j, 0 ≤ p j)
    (hM : ∀ j, p j ≤ M) (hsum : ∑ j, p j = 1) :
    -Real.log M ≤ shannonEntropy p := by
  have hMpos : 0 < M := pos_of_le hM hsum
  have key : ∀ j : Fin m, p j * Real.log M ≥ p j * Real.log (p j) := by
    intro j
    rcases (hp0 j).lt_or_eq with hpos | hzero
    · exact mul_le_mul_of_nonneg_left (Real.log_le_log hpos (hM j)) hpos.le
    · simp [← hzero]
  have hsum_le : ∑ j, p j * Real.log (p j) ≤ ∑ j, p j * Real.log M :=
    Finset.sum_le_sum fun j _ => key j
  rw [← Finset.sum_mul, hsum, one_mul] at hsum_le
  rw [shannonEntropy]
  linarith

/-- Equivalently: the dominant attention weight is at least `e^{−H}`. -/
theorem exp_neg_shannonEntropy_le {p : Fin m → ℝ} {M : ℝ} (hp0 : ∀ j, 0 ≤ p j)
    (hM : ∀ j, p j ≤ M) (hsum : ∑ j, p j = 1) :
    Real.exp (-shannonEntropy p) ≤ M := by
  have hMpos : 0 < M := pos_of_le hM hsum
  have h := neg_log_le_shannonEntropy hp0 hM hsum
  have : -shannonEntropy p ≤ Real.log M := by linarith
  calc Real.exp (-shannonEntropy p) ≤ Real.exp (Real.log M) := Real.exp_le_exp.mpr this
    _ = M := Real.exp_log hMpos

/-! ## Dominant weight versus participation ratio -/

/-- The collision probability is at most the dominant weight. -/
theorem collisionProb_le_max {p : Fin m → ℝ} {M : ℝ} (hp0 : ∀ j, 0 ≤ p j)
    (hM : ∀ j, p j ≤ M) (hsum : ∑ j, p j = 1) : collisionProb p ≤ M := by
  calc collisionProb p = ∑ j, p j * p j := by simp [collisionProb, sq]
    _ ≤ ∑ j, p j * M := Finset.sum_le_sum fun j _ => mul_le_mul_of_nonneg_left (hM j) (hp0 j)
    _ = M := by rw [← Finset.sum_mul, hsum, one_mul]

/-- **The effective number of attended keys is at least `1/pₘₐₓ`.** -/
theorem inv_le_effectiveSupport {p : Fin m → ℝ} {M : ℝ} (hp0 : ∀ j, 0 ≤ p j)
    (hM : ∀ j, p j ≤ M) (hsum : ∑ j, p j = 1) : M⁻¹ ≤ effectiveSupport p := by
  have hMpos : 0 < M := pos_of_le hM hsum
  have hc : 0 < collisionProb p := collisionProb_pos hsum
  have h := collisionProb_le_max hp0 hM hsum
  rw [effectiveSupport, one_div]
  exact inv_anti₀ hc h

/-! ## The attention distribution -/

/-- At most `1/t` keys receive attention weight `t` or more. -/
theorem card_filter_scoreSoftmax_le_inv (beta : ℝ) (s : Fin m → ℝ) (i : Fin m)
    {t : ℝ} (ht : 0 < t) :
    ((Finset.univ.filter fun j => t ≤ scoreSoftmax beta s j).card : ℝ) ≤ 1 / t :=
  card_filter_le_inv (scoreSoftmax_nonneg beta s) (scoreSoftmax_sum_one beta s i) ht

/-- Some key always receives at least the uniform share of the attention. -/
theorem exists_scoreSoftmax_ge_inv_card (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    ∃ j : Fin m, (m : ℝ)⁻¹ ≤ scoreSoftmax beta s j :=
  exists_inv_card_le (scoreSoftmax_sum_one beta s i)

/-- A low-entropy attention head has a dominant key. -/
theorem exp_neg_shannonEntropy_scoreSoftmax_le (beta : ℝ) (s : Fin m → ℝ) (i : Fin m)
    {M : ℝ} (hM : ∀ j, scoreSoftmax beta s j ≤ M) :
    Real.exp (-shannonEntropy (scoreSoftmax beta s)) ≤ M :=
  exp_neg_shannonEntropy_le (scoreSoftmax_nonneg beta s) hM (scoreSoftmax_sum_one beta s i)

end BookProof.ChapterAttentionConcentration

end
