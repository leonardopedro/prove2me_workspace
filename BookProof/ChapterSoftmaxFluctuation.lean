import Mathlib
import BookProof.ChapterSoftmaxOrder
import BookProof.ChapterAttentionEntropy

/-!
# Chapter "The Coherent State of Attention" — the fluctuation–response law of
attention

`ChapterAttentionEntropy` studies the attention distribution `scoreSoftmax β s`
at a *fixed* inverse temperature.  This module differentiates in `β`, and proves
the standard statistical-mechanics dictionary for the attention head:

* `partition` `Z(β) = ∑ⱼ exp (β sⱼ)` and `logPartition` `= log Z`;
* `hasDerivAt_logPartition` / `deriv_logPartition` — **the first response law**:
  `d/dβ log Z(β) = ⟨s⟩_β`, the attention-weighted mean score;
* `hasDerivAt_scoreSoftmax` — the response of a single attention weight,
  `d/dβ pⱼ(β) = pⱼ(β)·(sⱼ − ⟨s⟩_β)`: a key gains weight exactly when its score
  beats the current average;
* `hasDerivAt_meanScore` / `deriv_meanScore` — **the fluctuation–response law**:
  `d/dβ ⟨s⟩_β = Var_β(s) ≥ 0`.  Sharpening the attention (raising `β`, lowering the
  temperature) can only *increase* the mean score, and it does so at a rate equal
  to the variance of the scores under the current attention distribution;
* `varScore_eq_sub_sq` — `Var = ⟨s²⟩ − ⟨s⟩²`; `varScore_nonneg`;
* `varScore_eq_zero_iff`, `varScore_eq_zero_of_const`, `varScore_pos_of_ne` — the
  response vanishes exactly when every score already equals the mean, and is
  strictly positive as soon as two scores differ;
* `meanScore_monotone`, `meanScore_le_max` — the mean score is monotone in `β` and
  never exceeds the best score, so the response saturates.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterSoftmaxFluctuation

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

/-! ## The partition function -/

/-- The **partition function** of the attention head. -/
def partition (beta : ℝ) (s : Fin m → ℝ) : ℝ := ∑ l, Real.exp (beta * s l)

/-- The **log-partition (free energy) function**. -/
def logPartition (beta : ℝ) (s : Fin m → ℝ) : ℝ := Real.log (partition beta s)

/-- The **attention-weighted mean score** `⟨s⟩_β`. -/
def meanScore (beta : ℝ) (s : Fin m → ℝ) : ℝ := ∑ l, scoreSoftmax beta s l * s l

/-- The **attention-weighted variance of the scores** `Var_β(s)`. -/
def varScore (beta : ℝ) (s : Fin m → ℝ) : ℝ :=
  ∑ l, scoreSoftmax beta s l * (s l - meanScore beta s) ^ 2

theorem partition_pos (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) : 0 < partition beta s :=
  scoreSoftmax_denom_pos beta s i

theorem partition_ne_zero (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) : partition beta s ≠ 0 :=
  ne_of_gt (partition_pos beta s i)

theorem scoreSoftmax_eq_div (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta s j = Real.exp (beta * s j) / partition beta s := rfl

/-! ## Differentiating the partition function -/

theorem hasDerivAt_exp_mul (beta c : ℝ) :
    HasDerivAt (fun b : ℝ => Real.exp (b * c)) (c * Real.exp (beta * c)) beta := by
  have h : HasDerivAt (fun b : ℝ => b * c) c beta := by
    simpa using (hasDerivAt_id beta).mul_const c
  simpa [mul_comm] using h.exp

theorem hasDerivAt_partition (beta : ℝ) (s : Fin m → ℝ) :
    HasDerivAt (fun b : ℝ => partition b s)
      (∑ l, s l * Real.exp (beta * s l)) beta :=
  HasDerivAt.fun_sum fun l _ => hasDerivAt_exp_mul beta (s l)

/-- **The first response law**: the derivative of the free energy is the mean
score. -/
theorem hasDerivAt_logPartition (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    HasDerivAt (fun b : ℝ => logPartition b s) (meanScore beta s) beta := by
  have hZ := hasDerivAt_partition beta s
  have hne := partition_ne_zero beta s i
  have h := hZ.log hne
  refine h.congr_deriv ?_
  rw [meanScore, Finset.sum_div]
  exact Finset.sum_congr rfl fun l _ => by
    rw [scoreSoftmax_eq_div, div_mul_eq_mul_div, mul_comm (Real.exp (beta * s l)) (s l)]

theorem deriv_logPartition (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    deriv (fun b : ℝ => logPartition b s) beta = meanScore beta s :=
  (hasDerivAt_logPartition beta s i).deriv

/-! ## Differentiating a single attention weight -/

/-- **The response of a single attention weight.**  A key gains attention as the
temperature drops exactly when its score exceeds the current mean score. -/
theorem hasDerivAt_scoreSoftmax (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    HasDerivAt (fun b : ℝ => scoreSoftmax b s j)
      (scoreSoftmax beta s j * (s j - meanScore beta s)) beta := by
  have hZ := hasDerivAt_partition beta s
  have hne := partition_ne_zero beta s j
  have hpos := partition_pos beta s j
  have hnum := hasDerivAt_exp_mul beta (s j)
  have h := hnum.div hZ hne
  refine h.congr_deriv ?_
  have hmean : meanScore beta s = (∑ l, s l * Real.exp (beta * s l)) / partition beta s := by
    rw [meanScore, Finset.sum_div]
    exact Finset.sum_congr rfl fun l _ => by
      rw [scoreSoftmax_eq_div, div_mul_eq_mul_div, mul_comm (Real.exp (beta * s l)) (s l)]
  rw [hmean, scoreSoftmax_eq_div]
  field_simp

/-! ## The fluctuation–response law -/

/-- `Var = ⟨s²⟩ − ⟨s⟩²`. -/
theorem varScore_eq_sub_sq (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    varScore beta s = (∑ l, scoreSoftmax beta s l * s l ^ 2) - meanScore beta s ^ 2 := by
  have hsum : ∑ l, scoreSoftmax beta s l = 1 := scoreSoftmax_sum_one beta s i
  have hexp : ∀ l : Fin m, scoreSoftmax beta s l * (s l - meanScore beta s) ^ 2
      = scoreSoftmax beta s l * s l ^ 2
        - 2 * meanScore beta s * (scoreSoftmax beta s l * s l)
        + meanScore beta s ^ 2 * scoreSoftmax beta s l := by
    intro l; ring
  rw [varScore, Finset.sum_congr rfl fun l _ => hexp l, Finset.sum_add_distrib,
    Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.mul_sum, hsum, ← meanScore]
  ring

theorem varScore_nonneg (beta : ℝ) (s : Fin m → ℝ) : 0 ≤ varScore beta s :=
  Finset.sum_nonneg fun l _ =>
    mul_nonneg (scoreSoftmax_nonneg beta s l) (sq_nonneg _)

/-- **The fluctuation–response law**: the derivative of the mean score with
respect to the inverse temperature is the variance of the scores under the
attention distribution. -/
theorem hasDerivAt_meanScore (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    HasDerivAt (fun b : ℝ => meanScore b s) (varScore beta s) beta := by
  have h : HasDerivAt (fun b : ℝ => ∑ l, scoreSoftmax b s l * s l)
      (∑ l, scoreSoftmax beta s l * (s l - meanScore beta s) * s l) beta :=
    HasDerivAt.fun_sum fun l _ => (hasDerivAt_scoreSoftmax beta s l).mul_const (s l)
  refine h.congr_deriv ?_
  rw [varScore_eq_sub_sq beta s i]
  have hsum : ∑ l, scoreSoftmax beta s l = 1 := scoreSoftmax_sum_one beta s i
  have hexp : ∀ l : Fin m, scoreSoftmax beta s l * (s l - meanScore beta s) * s l
      = scoreSoftmax beta s l * s l ^ 2
        - meanScore beta s * (scoreSoftmax beta s l * s l) := by
    intro l; ring
  rw [Finset.sum_congr rfl fun l _ => hexp l, Finset.sum_sub_distrib, ← Finset.mul_sum,
    ← meanScore]
  ring

theorem deriv_meanScore (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    deriv (fun b : ℝ => meanScore b s) beta = varScore beta s :=
  (hasDerivAt_meanScore beta s i).deriv

/-- **Sharpening attention never lowers the mean score.**  The mean score is a
monotone function of the inverse temperature. -/
theorem meanScore_monotone (s : Fin m → ℝ) (i : Fin m) :
    Monotone fun b : ℝ => meanScore b s := by
  have hdiff : Differentiable ℝ fun b : ℝ => meanScore b s := fun b =>
    (hasDerivAt_meanScore b s i).differentiableAt
  refine monotone_of_deriv_nonneg hdiff fun b => ?_
  rw [deriv_meanScore b s i]
  exact varScore_nonneg b s

/-- The mean score never exceeds the best score: the response saturates. -/
theorem meanScore_le_max (beta : ℝ) (s : Fin m → ℝ) (i : Fin m)
    (hmax : ∀ l, s l ≤ s i) : meanScore beta s ≤ s i := by
  have hsum : ∑ l, scoreSoftmax beta s l = 1 := scoreSoftmax_sum_one beta s i
  calc meanScore beta s ≤ ∑ l, scoreSoftmax beta s l * s i :=
        Finset.sum_le_sum fun l _ =>
          mul_le_mul_of_nonneg_left (hmax l) (scoreSoftmax_nonneg beta s l)
    _ = s i := by rw [← Finset.sum_mul, hsum, one_mul]

/-! ## The variance vanishes exactly on constant scores -/

/-- The response vanishes exactly when every score already equals the mean. -/
theorem varScore_eq_zero_iff (beta : ℝ) (s : Fin m → ℝ) :
    varScore beta s = 0 ↔ ∀ l, s l = meanScore beta s := by
  constructor
  · intro h l
    have hterm : ∀ j ∈ (Finset.univ : Finset (Fin m)),
        scoreSoftmax beta s j * (s j - meanScore beta s) ^ 2 = 0 :=
      (Finset.sum_eq_zero_iff_of_nonneg fun j _ =>
        mul_nonneg (scoreSoftmax_nonneg beta s j) (sq_nonneg _)).1 h
    have := hterm l (Finset.mem_univ l)
    rcases mul_eq_zero.1 this with hp | hsq
    · exact absurd hp (ne_of_gt (scoreSoftmax_pos beta s l))
    · have : s l - meanScore beta s = 0 := by
        simpa using pow_eq_zero_iff (n := 2) two_ne_zero |>.1 hsq
      linarith
  · intro h
    refine Finset.sum_eq_zero fun l _ => ?_
    rw [h l, sub_self]
    simp

/-- Constant scores give a zero response: attention is temperature-independent. -/
theorem varScore_eq_zero_of_const {s : Fin m → ℝ} {c : ℝ} (hs : ∀ l, s l = c)
    (beta : ℝ) (i : Fin m) : varScore beta s = 0 := by
  refine (varScore_eq_zero_iff beta s).2 fun l => ?_
  have hmean : meanScore beta s = c := by
    rw [meanScore, Finset.sum_congr rfl fun j _ => by rw [hs j], ← Finset.sum_mul,
      scoreSoftmax_sum_one beta s i, one_mul]
  rw [hs l, hmean]

/-- If two scores differ, the response is strictly positive. -/
theorem varScore_pos_of_ne {beta : ℝ} {s : Fin m → ℝ} {a b : Fin m} (hab : s a ≠ s b) :
    0 < varScore beta s := by
  rcases lt_or_eq_of_le (varScore_nonneg beta s) with h | h
  · exact h
  · exfalso
    have hall := (varScore_eq_zero_iff beta s).1 h.symm
    exact hab ((hall a).trans (hall b).symm)

end BookProof.ChapterSoftmaxFluctuation

end
