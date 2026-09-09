import Mathlib
import BookProof.ChapterSoftmaxMaxEntropy

/-!
# Chapter "The Coherent State of Attention" — the divergence between two attention
distributions

`ChapterSoftmaxMaxEntropy` proves Gibbs' inequality in the entropy/cross-entropy
form.  This module packages the same content as a **relative entropy**
(Kullback–Leibler divergence) and computes it explicitly for two attention
distributions built from the *same* alignment scores at two different inverse
temperatures.

* `klDiv p q = ∑ⱼ pⱼ log (pⱼ / qⱼ)`, `klDiv_eq_crossEntropy_sub_shannonEntropy`;
* `klDiv_nonneg` — Gibbs' inequality; `klDiv_self` — a distribution is at zero
  divergence from itself;
* `klDiv_scoreSoftmax` — **the headline**: the divergence between the attention
  distributions at inverse temperatures `β` and `γ` is the *Bregman divergence of
  the log-partition function*,
  `KL(p_β ‖ p_γ) = log Z(γ) − log Z(β) − (γ − β)·⟨s⟩_β`;
* `logPartition_tangent_le` — consequently `log Z` lies above each of its tangent
  lines, the analytic shadow of the nonnegativity of the divergence;
* `fisherInformation` and `fisherInformation_eq_varScore` — the Fisher information
  of the attention family in the inverse temperature is exactly the score
  variance, i.e. the fluctuation of `ChapterSoftmaxFluctuation`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterSoftmaxDivergence

open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness
  BookProof.ChapterSoftmaxOrder BookProof.ChapterSoftmaxFluctuation
  BookProof.ChapterSoftmaxMaxEntropy

variable {m : ℕ}

/-! ## The Kullback–Leibler divergence -/

/-- The **Kullback–Leibler divergence** (relative entropy) of `p` from `q`. -/
def klDiv (p q : Fin m → ℝ) : ℝ := ∑ j, p j * Real.log (p j / q j)

/-- The divergence is the cross entropy minus the Shannon entropy. -/
theorem klDiv_eq_crossEntropy_sub_shannonEntropy {p q : Fin m → ℝ}
    (hq0 : ∀ j, 0 < q j) :
    klDiv p q = crossEntropy p q - shannonEntropy p := by
  have hterm : ∀ j : Fin m,
      p j * Real.log (p j / q j) = -(p j * Real.log (q j)) + p j * Real.log (p j) := by
    intro j
    rcases eq_or_ne (p j) 0 with h | h
    · simp [h]
    · rw [Real.log_div h (ne_of_gt (hq0 j))]; ring
  rw [klDiv, Finset.sum_congr rfl fun j _ => hterm j, Finset.sum_add_distrib,
    crossEntropy, shannonEntropy, Finset.sum_neg_distrib]
  ring

/-- **Gibbs' inequality, divergence form.**  The relative entropy of a probability
vector from a strictly positive sub-probability vector is nonnegative. -/
theorem klDiv_nonneg {p q : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j) (hpsum : ∑ j, p j = 1)
    (hq0 : ∀ j, 0 < q j) (hqsum : ∑ j, q j ≤ 1) : 0 ≤ klDiv p q := by
  have := shannonEntropy_le_crossEntropy hp0 hpsum hq0 hqsum
  rw [klDiv_eq_crossEntropy_sub_shannonEntropy hq0]
  linarith

/-- A distribution is at zero divergence from itself. -/
@[simp] theorem klDiv_self (p : Fin m → ℝ) : klDiv p p = 0 := by
  refine Finset.sum_eq_zero fun j _ => ?_
  rcases eq_or_ne (p j) 0 with h | h
  · simp [h]
  · rw [div_self h]; simp

/-! ## The divergence between two attention temperatures -/

/-- **The divergence of attention distributions is the Bregman divergence of the
log-partition function.**  For the same alignment scores at inverse temperatures
`β` and `γ`,
`KL(p_β ‖ p_γ) = log Z(γ) − log Z(β) − (γ − β)·⟨s⟩_β`. -/
theorem klDiv_scoreSoftmax (beta gamma : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    klDiv (scoreSoftmax beta s) (scoreSoftmax gamma s)
      = logPartition gamma s - logPartition beta s
          - (gamma - beta) * meanScore beta s := by
  have hq0 : ∀ j, 0 < scoreSoftmax gamma s j := fun j => scoreSoftmax_pos gamma s j
  rw [klDiv_eq_crossEntropy_sub_shannonEntropy hq0,
    crossEntropy_scoreSoftmax gamma s (scoreSoftmax_sum_one beta s i),
    shannonEntropy_scoreSoftmax beta s i, ← meanScore]
  ring

/-- **The log-partition function lies above each of its tangent lines.**  This is
the nonnegativity of the divergence, read as an analytic statement about
`β ↦ log Z(β)`. -/
theorem logPartition_tangent_le (beta gamma : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    logPartition beta s + (gamma - beta) * meanScore beta s ≤ logPartition gamma s := by
  have hnn : 0 ≤ klDiv (scoreSoftmax beta s) (scoreSoftmax gamma s) :=
    klDiv_nonneg (fun j => scoreSoftmax_nonneg beta s j) (scoreSoftmax_sum_one beta s i)
      (fun j => scoreSoftmax_pos gamma s j) (le_of_eq (scoreSoftmax_sum_one gamma s i))
  rw [klDiv_scoreSoftmax beta gamma s i] at hnn
  linarith

/-- Two attention distributions built from the same scores at the same inverse
temperature are at zero divergence. -/
theorem klDiv_scoreSoftmax_self (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    klDiv (scoreSoftmax beta s) (scoreSoftmax beta s) = 0 := by
  rw [klDiv_scoreSoftmax beta beta s i]; ring

/-! ## Fisher information -/

/-- The **Fisher information** of the attention family `β ↦ scoreSoftmax β s`,
`I(β) = ∑ⱼ pⱼ (∂_β log pⱼ)²`, written out with the Boltzmann score
`∂_β log pⱼ = sⱼ − ⟨s⟩_β`. -/
def fisherInformation (beta : ℝ) (s : Fin m → ℝ) : ℝ :=
  ∑ l, scoreSoftmax beta s l * (s l - meanScore beta s) ^ 2

/-- **The Fisher information of the attention family is the score variance.**  The
statistical curvature of the family and the physical fluctuation coincide. -/
theorem fisherInformation_eq_varScore (beta : ℝ) (s : Fin m → ℝ) :
    fisherInformation beta s = varScore beta s := rfl

/-- Fisher information is nonnegative. -/
theorem fisherInformation_nonneg (beta : ℝ) (s : Fin m → ℝ) :
    0 ≤ fisherInformation beta s := varScore_nonneg beta s

/-- The Fisher information is the derivative of the mean score in the inverse
temperature — the fluctuation–response law in information-geometric form. -/
theorem deriv_meanScore_eq_fisherInformation (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    deriv (fun b : ℝ => meanScore b s) beta = fisherInformation beta s :=
  deriv_meanScore beta s i

end BookProof.ChapterSoftmaxDivergence

end
