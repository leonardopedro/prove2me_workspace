import Mathlib
import BookProof.ChapterSoftmaxSharpness

/-!
# Chapter "The Coherent State of Attention": the order structure of Softmax

`ChapterSoftmaxSharpness` describes the two *extremes* of the Softmax family — the
uniform distribution at infinite temperature and the winner-takes-all limit at zero
temperature.  In between, the chapter's reading of Softmax as a *measurement* rests
on two structural facts that this module proves.

* `scoreSoftmax_shift` — **gauge invariance.**  Adding a constant to every score
  leaves the distribution unchanged: only score *differences* are physical.  This
  is the abstract form of the cancellation of the query penalty `exp(-‖q‖²)` in
  `coherentBorn_cancel_q`.
* `scoreSoftmax_le_iff` / `scoreSoftmax_lt_iff` / `scoreSoftmax_inj_iff` — at any
  positive inverse temperature, Softmax is a strictly increasing reparametrization
  of the scores: it *reorders nothing*.  Hence `scoreSoftmax_argmax`: the maximizer
  of the scores is the maximizer of the attention weights, at every temperature.
* `scoreSoftmax_const` — a flat score profile gives the uniform distribution at
  every temperature, so sharpening requires genuine score contrast.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterSoftmaxOrder

open BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

/-! ## Positivity and normalization -/

/-- The Softmax denominator is positive as soon as there is at least one score. -/
theorem scoreSoftmax_denom_pos (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    0 < ∑ l, Real.exp (beta * s l) :=
  Finset.sum_pos (fun _ _ => Real.exp_pos _) ⟨i, Finset.mem_univ i⟩

theorem scoreSoftmax_pos (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    0 < scoreSoftmax beta s j :=
  div_pos (Real.exp_pos _) (scoreSoftmax_denom_pos beta s j)

theorem scoreSoftmax_nonneg (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    0 ≤ scoreSoftmax beta s j :=
  (scoreSoftmax_pos beta s j).le

/-- Softmax is a probability distribution over the scores. -/
theorem scoreSoftmax_sum_one (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    ∑ j, scoreSoftmax beta s j = 1 := by
  simp only [scoreSoftmax]
  rw [← Finset.sum_div, div_self (scoreSoftmax_denom_pos beta s i).ne']

theorem scoreSoftmax_le_one (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta s j ≤ 1 := by
  have hsum := scoreSoftmax_sum_one beta s j
  have hle : scoreSoftmax beta s j ≤ ∑ l, scoreSoftmax beta s l :=
    Finset.single_le_sum (f := fun l => scoreSoftmax beta s l)
      (fun l _ => scoreSoftmax_nonneg beta s l) (Finset.mem_univ j)
  linarith

/-! ## Gauge invariance: only score differences matter -/

/-- **Gauge invariance.**  Shifting every score by the same constant leaves the
Softmax distribution unchanged. -/
theorem scoreSoftmax_shift (beta c : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta (fun l => s l + c) j = scoreSoftmax beta s j := by
  have hexp : ∀ l, Real.exp (beta * (s l + c))
      = Real.exp (beta * c) * Real.exp (beta * s l) := by
    intro l
    rw [← Real.exp_add]
    ring_nf
  have hden : (∑ l, Real.exp (beta * (s l + c)))
      = Real.exp (beta * c) * ∑ l, Real.exp (beta * s l) := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun l _ => hexp l
  rw [scoreSoftmax, scoreSoftmax, hexp j, hden, mul_div_mul_left _ _ (Real.exp_ne_zero _)]

/-! ## Softmax preserves the order of the scores -/

/-- **Softmax reorders nothing.**  At positive inverse temperature the weight of
`i` is at most the weight of `j` exactly when its score is. -/
theorem scoreSoftmax_le_iff {beta : ℝ} (hbeta : 0 < beta) (s : Fin m → ℝ) (i j : Fin m) :
    scoreSoftmax beta s i ≤ scoreSoftmax beta s j ↔ s i ≤ s j := by
  rw [scoreSoftmax, scoreSoftmax,
    div_le_div_iff_of_pos_right (scoreSoftmax_denom_pos beta s i), Real.exp_le_exp,
    mul_le_mul_iff_of_pos_left hbeta]

/-- The strict form of `scoreSoftmax_le_iff`. -/
theorem scoreSoftmax_lt_iff {beta : ℝ} (hbeta : 0 < beta) (s : Fin m → ℝ) (i j : Fin m) :
    scoreSoftmax beta s i < scoreSoftmax beta s j ↔ s i < s j := by
  rw [← not_le, ← not_le, scoreSoftmax_le_iff hbeta]

/-- Softmax separates distinct scores: two keys share a weight exactly when they
share a score. -/
theorem scoreSoftmax_inj_iff {beta : ℝ} (hbeta : 0 < beta) (s : Fin m → ℝ) (i j : Fin m) :
    scoreSoftmax beta s i = scoreSoftmax beta s j ↔ s i = s j := by
  rw [le_antisymm_iff, le_antisymm_iff, scoreSoftmax_le_iff hbeta,
    scoreSoftmax_le_iff hbeta]

/-- **The argmax is temperature-independent.**  The maximizer of the scores is the
maximizer of the attention weights at every positive inverse temperature. -/
theorem scoreSoftmax_argmax {beta : ℝ} (hbeta : 0 < beta) (s : Fin m → ℝ) (j : Fin m)
    (hj : ∀ l, s l ≤ s j) (i : Fin m) :
    scoreSoftmax beta s i ≤ scoreSoftmax beta s j :=
  (scoreSoftmax_le_iff hbeta s i j).2 (hj i)

/-- **No contrast, no sharpening.**  A constant score profile is uniform at every
temperature. -/
theorem scoreSoftmax_const (beta c : ℝ) (j : Fin m) :
    scoreSoftmax beta (fun _ => c) j = 1 / m := by
  have hm : (m : ℝ) ≠ 0 := Nat.cast_ne_zero.2 (Fin.pos j).ne'
  simp only [scoreSoftmax, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  field_simp

/-! ## The attention weights inherit the order of the alignments -/

/-- The attention Softmax orders the keys by their alignment with the query. -/
theorem softmax_le_iff_inner_le {n : ℕ} {beta : ℝ} (hbeta : 0 < beta)
    (q : EuclideanSpace ℝ (Fin n)) (k : Fin m → EuclideanSpace ℝ (Fin n)) (i j : Fin m) :
    softmax beta q k i ≤ softmax beta q k j ↔
      (inner ℝ q (k i) : ℝ) ≤ inner ℝ q (k j) := by
  rw [softmax_eq_scoreSoftmax, softmax_eq_scoreSoftmax, scoreSoftmax_le_iff hbeta]

end BookProof.ChapterSoftmaxOrder

end
