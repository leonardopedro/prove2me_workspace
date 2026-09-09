import Mathlib
import BookProof.ChapterSoftmaxMaxEntropy
import BookProof.ChapterAttentionEntropy

/-!
# Chapter "The Coherent State of Attention": the free energy is a soft maximum

The Softmax head is named after the operation its free energy performs on the
alignment scores: `(1/β)·log Z(β)` is a *smoothed maximum*.  This module makes the
smoothing quantitative and shows that the smoothing error is entirely an entropy
term, of size at most `log m / β`.

* `le_logPartition` — every score is a lower bound: `β·sⱼ ≤ log Z(β)`;
* `logPartition_le` — and `log Z(β) ≤ log m + β·M` for any upper bound `M` of the
  scores, at `β ≥ 0`;
* `abs_logPartition_div_sub_le` — **the headline**: when the maximum `M` is
  attained, the free energy per unit inverse temperature is the maximum score up to
  `log m / β`;
* `meanScore_le` and `sub_meanScore_le` — the attention-weighted mean score never
  exceeds the maximum and is within `log m / β` of it: at a low temperature the
  head reads (almost) the best-matching key;
* `tendsto_meanScore_atTop` and `tendsto_logPartition_div_atTop` — hence both
  converge to the maximum score as `β → ∞`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionFreeEnergy

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterSoftmaxFluctuation BookProof.ChapterAttentionEntropy
  BookProof.ChapterSoftmaxMaxEntropy

variable {m : ℕ}

/-! ## The free energy squeezes the maximum score -/

/-- Every score is a lower bound for the free energy: `β·sⱼ ≤ log Z(β)`. -/
theorem le_logPartition (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    beta * s j ≤ logPartition beta s := by
  have hle : Real.exp (beta * s j) ≤ partition beta s :=
    Finset.single_le_sum (f := fun l => Real.exp (beta * s l))
      (fun l _ => (Real.exp_pos _).le) (Finset.mem_univ j)
  have := Real.log_le_log (Real.exp_pos _) hle
  simpa [logPartition, Real.log_exp] using this

/-- An upper bound `M` on the scores bounds the free energy by `log m + β·M`. -/
theorem logPartition_le {beta : ℝ} (hb : 0 ≤ beta) {s : Fin m → ℝ} {M : ℝ}
    (i : Fin m) (hM : ∀ l, s l ≤ M) :
    logPartition beta s ≤ Real.log m + beta * M := by
  have hm : (0 : ℝ) < m := by
    have : 0 < m := Fin.pos i
    exact_mod_cast this
  have hle : partition beta s ≤ (m : ℝ) * Real.exp (beta * M) := by
    have : partition beta s ≤ ∑ _l : Fin m, Real.exp (beta * M) :=
      Finset.sum_le_sum fun l _ => by
        exact Real.exp_le_exp.2 (mul_le_mul_of_nonneg_left (hM l) hb)
    simpa [Finset.sum_const, nsmul_eq_mul] using this
  have hpos : (0 : ℝ) < partition beta s := partition_pos beta s i
  have := Real.log_le_log hpos hle
  rwa [Real.log_mul (ne_of_gt hm) (Real.exp_ne_zero _), Real.log_exp] at this

/-- **The free energy is a soft maximum.**  If `M` is the largest score, then
`log Z(β)/β` differs from `M` by at most `log m / β`: the head's free energy is the
maximum score plus an entropy correction that vanishes as the temperature drops. -/
theorem abs_logPartition_div_sub_le {beta : ℝ} (hb : 0 < beta) {s : Fin m → ℝ} {M : ℝ}
    {j : Fin m} (hj : s j = M) (hM : ∀ l, s l ≤ M) :
    |logPartition beta s / beta - M| ≤ Real.log m / beta := by
  have hlow : beta * M ≤ logPartition beta s := by
    have := le_logPartition beta s j
    rwa [hj] at this
  have hhigh : logPartition beta s ≤ Real.log m + beta * M := logPartition_le hb.le j hM
  have hm1 : (1 : ℝ) ≤ (m : ℝ) := by exact_mod_cast Nat.succ_le_of_lt (Fin.pos j)
  have hlogm : 0 ≤ Real.log m := Real.log_nonneg hm1
  have h1 : M ≤ logPartition beta s / beta := (le_div_iff₀ hb).2 (by linarith)
  have h2 : logPartition beta s / beta ≤ Real.log m / beta + M := by
    rw [div_le_iff₀ hb]
    field_simp
    linarith
  have h3 : 0 ≤ Real.log m / beta := div_nonneg hlogm hb.le
  rw [abs_le]
  constructor <;> linarith

/-! ## The mean score converges to the maximum -/

/-- The attention-weighted mean score never exceeds the largest score. -/
theorem meanScore_le (beta : ℝ) {s : Fin m → ℝ} {M : ℝ} (i : Fin m) (hM : ∀ l, s l ≤ M) :
    meanScore beta s ≤ M := by
  have hsum : ∑ l, scoreSoftmax beta s l = 1 := scoreSoftmax_sum_one beta s i
  have : meanScore beta s ≤ ∑ l, scoreSoftmax beta s l * M :=
    Finset.sum_le_sum fun l _ =>
      mul_le_mul_of_nonneg_left (hM l) (scoreSoftmax_nonneg beta s l)
  rwa [← Finset.sum_mul, hsum, one_mul] at this

/-- **The head reads (almost) the best key.**  The attention-weighted mean score is
within `log m / β` of the maximum score. -/
theorem sub_meanScore_le {beta : ℝ} (hb : 0 < beta) {s : Fin m → ℝ} {M : ℝ}
    {j : Fin m} (hj : s j = M) :
    M - meanScore beta s ≤ Real.log m / beta := by
  have hfe := softmax_free_energy_eq beta s j
  have hH : shannonEntropy (scoreSoftmax beta s) ≤ Real.log m :=
    shannonEntropy_scoreSoftmax_le_log_card beta s j
  have hlow : beta * M ≤ logPartition beta s := by
    have := le_logPartition beta s j
    rwa [hj] at this
  have hmean : (∑ l, scoreSoftmax beta s l * s l) = meanScore beta s := rfl
  rw [hmean] at hfe
  rw [le_div_iff₀ hb]
  nlinarith [hfe, hH, hlow]

theorem tendsto_log_card_div_atTop :
    Filter.Tendsto (fun beta : ℝ => Real.log m / beta) Filter.atTop (nhds 0) :=
  Filter.Tendsto.div_atTop tendsto_const_nhds Filter.tendsto_id

/-- **Winner-takes-all in the energy.**  As the temperature drops the mean score
read by the head converges to the maximum score. -/
theorem tendsto_meanScore_atTop {s : Fin m → ℝ} {M : ℝ} {j : Fin m} (hj : s j = M)
    (hM : ∀ l, s l ≤ M) :
    Filter.Tendsto (fun beta : ℝ => meanScore beta s) Filter.atTop (nhds M) := by
  have hlow : Filter.Tendsto (fun beta : ℝ => M - Real.log m / beta) Filter.atTop (nhds M) := by
    simpa using tendsto_const_nhds.sub (tendsto_log_card_div_atTop (m := m))
  refine tendsto_of_tendsto_of_tendsto_of_le_of_le' hlow tendsto_const_nhds ?_ ?_
  · filter_upwards [Filter.eventually_gt_atTop (0 : ℝ)] with beta hbeta
    have := sub_meanScore_le hbeta hj (M := M)
    linarith
  · filter_upwards with beta using meanScore_le beta j hM

/-- The same statement for the free energy itself: `log Z(β)/β → max s`. -/
theorem tendsto_logPartition_div_atTop {s : Fin m → ℝ} {M : ℝ} {j : Fin m} (hj : s j = M)
    (hM : ∀ l, s l ≤ M) :
    Filter.Tendsto (fun beta : ℝ => logPartition beta s / beta) Filter.atTop (nhds M) := by
  have hlow : Filter.Tendsto (fun beta : ℝ => M - Real.log m / beta) Filter.atTop (nhds M) := by
    simpa using tendsto_const_nhds.sub (tendsto_log_card_div_atTop (m := m))
  have hhigh : Filter.Tendsto (fun beta : ℝ => M + Real.log m / beta) Filter.atTop (nhds M) := by
    simpa using tendsto_const_nhds.add (tendsto_log_card_div_atTop (m := m))
  refine tendsto_of_tendsto_of_tendsto_of_le_of_le' hlow hhigh ?_ ?_ <;>
  · filter_upwards [Filter.eventually_gt_atTop (0 : ℝ)] with beta hbeta
    have := abs_le.1 (abs_logPartition_div_sub_le hbeta hj hM)
    linarith [this.1, this.2]

end BookProof.ChapterAttentionFreeEnergy

end
