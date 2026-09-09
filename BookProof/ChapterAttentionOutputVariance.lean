import Mathlib
import BookProof.ChapterAttentionOutput

/-!
# Chapter "The Coherent State of Attention": the uncertainty of the output

The attention output is the expectation value of the contextual observable, so it
carries the second moment of a measurement as well as the first.  This module
proves the elementary facts about that spread.

* `sum_dist_sq_eq` — the **bias–variance decomposition**: for any reference point
  `c`, `∑ⱼ pⱼ‖vⱼ − c‖² = Var(p,v) + ‖o − c‖²`, where `o` is the attention output.
* `observableExpectation_minimizes` — hence the head output is the *least-squares
  summary* of the values it is reading: no other vector is closer to the values in
  the attention-weighted mean-square sense.
* `outputVariance_eq_sub` (König–Huygens) and `norm_observableExpectation_sq_le` —
  `Var = ∑ pⱼ‖vⱼ‖² − ‖o‖² ≥ 0`, the Jensen inequality for the output norm.
* `outputVariance_eq_zero_iff_of_pos` — at a finite temperature every weight is
  positive, so the output carries *no* uncertainty exactly when all the values
  agree; `outputVariance_scoreSoftmax_eq_zero_iff` states this for the head.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators RealInnerProductSpace

noncomputable section

namespace BookProof.ChapterAttentionOutputVariance

open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness
  BookProof.ChapterSoftmaxOrder BookProof.ChapterAttentionOutput

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-- The attention-weighted variance of the values around the output. -/
def outputVariance (p : Fin m → ℝ) (v : Fin m → E) : ℝ :=
  ∑ j, p j * ‖v j - observableExpectation p v‖ ^ 2

theorem outputVariance_nonneg {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j) (v : Fin m → E) :
    0 ≤ outputVariance p v :=
  Finset.sum_nonneg fun j _ => mul_nonneg (hp0 j) (sq_nonneg _)

/-- The mean-square spread of the values around an arbitrary reference point. -/
theorem sum_dist_sq_expand {p : Fin m → ℝ} (hp : ∑ j, p j = 1) (v : Fin m → E) (c : E) :
    ∑ j, p j * ‖v j - c‖ ^ 2
      = (∑ j, p j * ‖v j‖ ^ 2) - 2 * ⟪observableExpectation p v, c⟫ + ‖c‖ ^ 2 := by
  have hexp : ∀ j : Fin m, p j * ‖v j - c‖ ^ 2
      = p j * ‖v j‖ ^ 2 - 2 * (p j * ⟪v j, c⟫) + p j * ‖c‖ ^ 2 := by
    intro j
    rw [@norm_sub_sq_real]
    ring
  have hinner : ⟪observableExpectation p v, c⟫ = ∑ j, p j * ⟪v j, c⟫ := by
    rw [observableExpectation, sum_inner]
    exact Finset.sum_congr rfl fun j _ => real_inner_smul_left _ _ _
  rw [Finset.sum_congr rfl fun j _ => hexp j]
  rw [Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.sum_mul, hp,
    one_mul, hinner]

/-- **The bias–variance decomposition of the attention output.** -/
theorem sum_dist_sq_eq {p : Fin m → ℝ} (hp : ∑ j, p j = 1) (v : Fin m → E) (c : E) :
    ∑ j, p j * ‖v j - c‖ ^ 2
      = outputVariance p v + ‖observableExpectation p v - c‖ ^ 2 := by
  have h1 := sum_dist_sq_expand hp v c
  have h2 := sum_dist_sq_expand hp v (observableExpectation p v)
  have h3 : ⟪observableExpectation p v, observableExpectation p v⟫
      = ‖observableExpectation p v‖ ^ 2 := real_inner_self_eq_norm_sq _
  have h4 : ‖observableExpectation p v - c‖ ^ 2
      = ‖observableExpectation p v‖ ^ 2 - 2 * ⟪observableExpectation p v, c⟫ + ‖c‖ ^ 2 :=
    norm_sub_sq_real _ _
  rw [h1, outputVariance, h2, h3, h4]
  ring

/-- **The attention output is the least-squares summary of the values.** -/
theorem observableExpectation_minimizes {p : Fin m → ℝ} (hp : ∑ j, p j = 1) (v : Fin m → E)
    (c : E) :
    ∑ j, p j * ‖v j - observableExpectation p v‖ ^ 2 ≤ ∑ j, p j * ‖v j - c‖ ^ 2 := by
  rw [sum_dist_sq_eq hp v c, ← outputVariance]
  nlinarith [sq_nonneg ‖observableExpectation p v - c‖]

/-- **König–Huygens**: the variance is the mean square minus the square of the mean. -/
theorem outputVariance_eq_sub {p : Fin m → ℝ} (hp : ∑ j, p j = 1) (v : Fin m → E) :
    outputVariance p v = (∑ j, p j * ‖v j‖ ^ 2) - ‖observableExpectation p v‖ ^ 2 := by
  have h := sum_dist_sq_eq hp v 0
  simp only [sub_zero] at h
  linarith [h]

/-- **Jensen for the output norm**: `‖o‖² ≤ ∑ pⱼ‖vⱼ‖²`. -/
theorem norm_observableExpectation_sq_le {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j)
    (hp : ∑ j, p j = 1) (v : Fin m → E) :
    ‖observableExpectation p v‖ ^ 2 ≤ ∑ j, p j * ‖v j‖ ^ 2 := by
  have h := outputVariance_eq_sub hp v
  have hv := outputVariance_nonneg hp0 v
  linarith

theorem outputVariance_const (p : Fin m → ℝ) (hp : ∑ j, p j = 1) (w : E) :
    outputVariance p (fun _ => w) = 0 := by
  rw [outputVariance, observableExpectation_const p hp w]
  simp

/-- With every weight strictly positive, a certain output means the values agree. -/
theorem outputVariance_eq_zero_iff_of_pos {p : Fin m → ℝ} (hp0 : ∀ j, 0 < p j)
    (v : Fin m → E) :
    outputVariance p v = 0 ↔ ∀ j, v j = observableExpectation p v := by
  constructor
  · intro h j
    have hterm : ∀ i ∈ (Finset.univ : Finset (Fin m)),
        0 ≤ p i * ‖v i - observableExpectation p v‖ ^ 2 :=
      fun i _ => mul_nonneg (hp0 i).le (sq_nonneg _)
    have hzero := (Finset.sum_eq_zero_iff_of_nonneg hterm).mp h j (Finset.mem_univ j)
    have hn : ‖v j - observableExpectation p v‖ ^ 2 = 0 := by
      rcases mul_eq_zero.mp hzero with hp | hn
      · exact absurd hp (hp0 j).ne'
      · exact hn
    have : ‖v j - observableExpectation p v‖ = 0 := by
      exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp hn
    exact sub_eq_zero.mp (norm_eq_zero.mp this)
  · intro h
    rw [outputVariance]
    refine Finset.sum_eq_zero fun j _ => ?_
    rw [h j]
    simp

/-! ## The attention head -/

theorem outputVariance_scoreSoftmax_nonneg (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) :
    0 ≤ outputVariance (scoreSoftmax beta s) v :=
  outputVariance_nonneg (scoreSoftmax_nonneg beta s) v

/-- The head output is the least-squares summary of the values it reads. -/
theorem headOutput_minimizes (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) (i : Fin m) (c : E) :
    ∑ j, scoreSoftmax beta s j * ‖v j - headOutput beta s v‖ ^ 2
      ≤ ∑ j, scoreSoftmax beta s j * ‖v j - c‖ ^ 2 :=
  observableExpectation_minimizes (scoreSoftmax_sum_one beta s i) v c

/-- **At a finite temperature the output is certain only if the values agree.** -/
theorem outputVariance_scoreSoftmax_eq_zero_iff (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) :
    outputVariance (scoreSoftmax beta s) v = 0 ↔ ∀ j, v j = headOutput beta s v :=
  outputVariance_eq_zero_iff_of_pos (fun j => scoreSoftmax_pos beta s j) v

end BookProof.ChapterAttentionOutputVariance

end
