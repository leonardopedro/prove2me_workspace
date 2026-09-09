import Mathlib
import BookProof.ChapterSoftmaxSharpness

/-!
# Chapter "The Coherent State of Attention", §"The Geometry of the Wave-packet"

`Book/CoherentState.lean` reads the coherent-state overlap geometrically: a key is
a *wave-packet* centred at its parameter, and the query interrogates the packets by
proximity.  `ChapterCoherentOverlap` already identifies the overlap with the
Gaussian kernel `exp (-‖q - k‖² / 2)`; this module turns that identification into
the order-theoretic statements the prose actually uses.

* `neg_two_mul_log_coherentOverlap` — the kernel is a *metric readout*:
  `-2 log ⟨q|k⟩ = ‖q - k‖²`.  Nothing is lost in passing from the distance to the
  overlap.
* `coherentOverlap_le_iff_dist_le` / `coherentOverlap_lt_iff_dist_lt` — the overlap
  is a strictly decreasing function of the distance between the parameters.
* `bornWeight_eq_scoreSoftmax_neg_dist_sq` — the **Born weight is a Softmax over
  minus the squared distances**, at inverse temperature `1`.  This is the geometric
  face of `coherentBorn_eq_softmax`: it needs no hypothesis on the key norms,
  because the key penalties are exactly what the squared distance absorbs.
* `bornWeight_le_iff_dist_le` — consequently the Born weights order the keys by
  proximity, and `bornWeight_max_of_nearest` / `bornWeight_lt_of_nearest`: the
  nearest key carries the largest attention weight (strictly, if it is strictly
  nearest).

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterCoherentGeometry

open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxBorn
  BookProof.ChapterSoftmaxSharpness

variable {n m : ℕ}

/-! ## The overlap is a readout of the distance -/

/-- **The kernel is a metric readout.**  Taking `-2 log` of the coherent overlap
returns exactly the squared distance between the two parameters. -/
theorem neg_two_mul_log_coherentOverlap (q k : EuclideanSpace ℝ (Fin n)) :
    -2 * Real.log (coherentOverlap q k) = ‖q - k‖ ^ 2 := by
  rw [coherentOverlap_eq_gaussian, Real.log_exp]
  ring

/-- **The overlap is antitone in the distance.** -/
theorem coherentOverlap_le_iff_dist_le (q k k' : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q k ≤ coherentOverlap q k' ↔ ‖q - k'‖ ≤ ‖q - k‖ := by
  rw [coherentOverlap_eq_gaussian, coherentOverlap_eq_gaussian, Real.exp_le_exp]
  constructor
  · intro h
    nlinarith [norm_nonneg (q - k), norm_nonneg (q - k')]
  · intro h
    nlinarith [norm_nonneg (q - k), norm_nonneg (q - k')]

/-- The strict form of `coherentOverlap_le_iff_dist_le`. -/
theorem coherentOverlap_lt_iff_dist_lt (q k k' : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q k < coherentOverlap q k' ↔ ‖q - k'‖ < ‖q - k‖ := by
  rw [← not_le, ← not_le, coherentOverlap_le_iff_dist_le]

/-! ## The Born numerator is the Gaussian weight of the distance -/

/-- The Born numerator is `exp (-‖q - k‖²)`: the squared Gaussian kernel. -/
theorem bornNumer_eq_exp_neg_dist_sq (q k : EuclideanSpace ℝ (Fin n)) :
    bornNumer q k = Real.exp (-‖q - k‖ ^ 2) := by
  rw [bornNumer, coherentOverlap_eq_gaussian, ← Real.exp_nat_mul]
  congr 1
  ring

/-- **The Born weight is a Softmax over minus the squared distances**, at inverse
temperature `1`.  Unlike `coherentBorn_eq_softmax`, this identity is
unconditional: the key-norm penalties are absorbed into the distances. -/
theorem bornWeight_eq_scoreSoftmax_neg_dist_sq (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) :
    bornWeight q k j = scoreSoftmax 1 (fun l => -‖q - k l‖ ^ 2) j := by
  rw [bornWeight, scoreSoftmax, bornNumer_eq_exp_neg_dist_sq]
  simp only [one_mul]
  exact congrArg _ (Finset.sum_congr rfl fun l _ => bornNumer_eq_exp_neg_dist_sq q (k l))

/-! ## The nearest key wins -/

/-- **The Born weights order the keys by proximity.** -/
theorem bornWeight_le_iff_dist_le (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (i j : Fin m) :
    bornWeight q k i ≤ bornWeight q k j ↔ ‖q - k j‖ ≤ ‖q - k i‖ := by
  have hden : 0 < ∑ l, bornNumer q (k l) := bornDenom_pos q k i
  have hi := coherentOverlap_pos q (k i)
  have hj := coherentOverlap_pos q (k j)
  rw [bornWeight, bornWeight, div_le_div_iff_of_pos_right hden, bornNumer, bornNumer]
  constructor
  · intro h
    exact (coherentOverlap_le_iff_dist_le q (k i) (k j)).1 (by nlinarith)
  · intro h
    have := (coherentOverlap_le_iff_dist_le q (k i) (k j)).2 h
    nlinarith

/-- **The nearest key carries the largest attention weight.** -/
theorem bornWeight_max_of_nearest (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m)
    (hj : ∀ l, ‖q - k j‖ ≤ ‖q - k l‖) (i : Fin m) :
    bornWeight q k i ≤ bornWeight q k j :=
  (bornWeight_le_iff_dist_le q k i j).2 (hj i)

/-- A strictly nearest key carries a strictly largest attention weight. -/
theorem bornWeight_lt_of_nearest (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (i j : Fin m)
    (hij : ‖q - k j‖ < ‖q - k i‖) :
    bornWeight q k i < bornWeight q k j := by
  rw [← not_le, bornWeight_le_iff_dist_le]
  exact not_le.2 hij

end BookProof.ChapterCoherentGeometry

end
