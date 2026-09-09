import Mathlib
import BookProof.ChapterAttentionEntropy

/-!
# Chapter "The Coherent State of Attention": turning the temperature knob

`ChapterSoftmaxSharpness` computes the two extreme temperatures (uniform at
`β = 0`, winner-takes-all as `β → ∞`) and `ChapterEntropyTemperature` differentiates
the entropy in `β`.  What is missing between the two ends is the elementary
*monotonicity* statement a practitioner actually uses: as the head is cooled, the
best key can only gain and the worst key can only lose, and the odds between any
two keys move as a pure exponential in the score gap.

* `scoreSoftmax_odds` — `pᵢ = e^{β(sᵢ−sⱼ)}·pⱼ`: the odds ratio of two keys depends
  on the scores only through their gap, and on the temperature only through `β`.
* `scoreSoftmax_monotone_of_isMax` / `scoreSoftmax_antitone_of_isMin` — the weight
  of a maximizing key is monotone in `β`, that of a minimizing key antitone; both
  are proved without calculus, from the normalized form
  `pⱼ(β) = 1/∑ₗ e^{β(sₗ−sⱼ)}`.
* `scoreSoftmax_strictMono_of_isMax` — the increase is *strict* as soon as some
  other key has a strictly smaller score.
* `inv_card_le_scoreSoftmax_of_isMax` / `scoreSoftmax_le_inv_card_of_isMin` — at any
  positive `β` the best key holds at least the uniform share `1/m` and the worst
  key at most `1/m`: cooling never hurts the winner.
* `scoreSoftmax_le_of_spread` and `log_card_sub_le_shannonEntropy` — the converse
  side: if the scores span at most `D`, then every weight is at most `e^{βD}/m` and
  the attention entropy is at least `log m − βD`.  A head with bounded scores
  cannot be sharp at a finite temperature.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionTemperature

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterAttentionEntropy

variable {m : ℕ}

/-! ## Odds ratios -/

/-- **The odds of two keys are a pure exponential of their score gap.** -/
theorem scoreSoftmax_odds (beta : ℝ) (s : Fin m → ℝ) (i j : Fin m) :
    scoreSoftmax beta s i = Real.exp (beta * (s i - s j)) * scoreSoftmax beta s j := by
  rw [scoreSoftmax, scoreSoftmax, mul_div_assoc', ← Real.exp_add]
  ring_nf

/-! ## Monotonicity in the inverse temperature -/

/-- The normalizing sum `∑ₗ e^{β(sₗ−sⱼ)}` is positive. -/
theorem shifted_denom_pos (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    0 < ∑ l, Real.exp (beta * (s l - s j)) :=
  Finset.sum_pos (fun _ _ => Real.exp_pos _) ⟨j, Finset.mem_univ j⟩

/-- **Cooling helps the winner.**  If `j` maximizes the scores, its attention
weight is a monotone function of the inverse temperature. -/
theorem scoreSoftmax_monotone_of_isMax {s : Fin m → ℝ} {j : Fin m} (hj : ∀ l, s l ≤ s j) :
    Monotone fun beta => scoreSoftmax beta s j := by
  intro b₁ b₂ hb
  simp only [scoreSoftmax_eq_inv_sum]
  refine one_div_le_one_div_of_le (shifted_denom_pos b₂ s j) ?_
  refine Finset.sum_le_sum fun l _ => ?_
  exact Real.exp_le_exp.mpr (mul_le_mul_of_nonpos_right hb (sub_nonpos.mpr (hj l)))

/-- **Cooling hurts the loser.**  If `j` minimizes the scores, its attention weight
is antitone in the inverse temperature. -/
theorem scoreSoftmax_antitone_of_isMin {s : Fin m → ℝ} {j : Fin m} (hj : ∀ l, s j ≤ s l) :
    Antitone fun beta => scoreSoftmax beta s j := by
  intro b₁ b₂ hb
  simp only [scoreSoftmax_eq_inv_sum]
  refine one_div_le_one_div_of_le (shifted_denom_pos b₁ s j) ?_
  refine Finset.sum_le_sum fun l _ => ?_
  exact Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_right hb (sub_nonneg.mpr (hj l)))

/-- The gain of the winner is **strict** whenever some other key scores strictly
lower. -/
theorem scoreSoftmax_strictMono_of_isMax {s : Fin m → ℝ} {j : Fin m} (hj : ∀ l, s l ≤ s j)
    (hlt : ∃ i, s i < s j) :
    StrictMono fun beta => scoreSoftmax beta s j := by
  obtain ⟨i, hi⟩ := hlt
  intro b₁ b₂ hb
  simp only [scoreSoftmax_eq_inv_sum]
  refine one_div_lt_one_div_of_lt (shifted_denom_pos b₂ s j) ?_
  refine Finset.sum_lt_sum (fun l _ =>
    Real.exp_le_exp.mpr (mul_le_mul_of_nonpos_right hb.le (sub_nonpos.mpr (hj l)))) ?_
  refine ⟨i, Finset.mem_univ i, ?_⟩
  refine Real.exp_lt_exp.mpr ?_
  have hneg : s i - s j < 0 := sub_neg.mpr hi
  nlinarith

/-- At any `β ≥ 0` the best key holds at least the uniform share `1/m`. -/
theorem inv_card_le_scoreSoftmax_of_isMax {beta : ℝ} (hb : 0 ≤ beta) {s : Fin m → ℝ}
    {j : Fin m} (hj : ∀ l, s l ≤ s j) :
    1 / (m : ℝ) ≤ scoreSoftmax beta s j := by
  have h := scoreSoftmax_monotone_of_isMax hj hb
  simpa [scoreSoftmax_zero] using h

/-- At any `β ≥ 0` the worst key holds at most the uniform share `1/m`. -/
theorem scoreSoftmax_le_inv_card_of_isMin {beta : ℝ} (hb : 0 ≤ beta) {s : Fin m → ℝ}
    {j : Fin m} (hj : ∀ l, s j ≤ s l) :
    scoreSoftmax beta s j ≤ 1 / (m : ℝ) := by
  have h := scoreSoftmax_antitone_of_isMin hj hb
  simpa [scoreSoftmax_zero] using h

/-! ## Bounded scores keep the head warm -/

/-- If the scores span at most `D`, no weight exceeds `e^{βD}/m`. -/
theorem scoreSoftmax_le_of_spread {beta D : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    (hD : ∀ i l, s i - s l ≤ D) (j : Fin m) :
    scoreSoftmax beta s j ≤ Real.exp (beta * D) / m := by
  have hlow : ∀ l : Fin m, Real.exp (-(beta * D)) ≤ Real.exp (beta * (s l - s j)) := by
    intro l
    refine Real.exp_le_exp.mpr ?_
    have : s j - s l ≤ D := hD j l
    nlinarith
  have hsum : (m : ℝ) * Real.exp (-(beta * D)) ≤ ∑ l, Real.exp (beta * (s l - s j)) := by
    calc (m : ℝ) * Real.exp (-(beta * D))
        = ∑ _l : Fin m, Real.exp (-(beta * D)) := by
          simp
      _ ≤ ∑ l, Real.exp (beta * (s l - s j)) := Finset.sum_le_sum fun l _ => hlow l
  have hm : (0 : ℝ) < m := by
    have : (0 : ℕ) < m := Fin.pos j
    exact_mod_cast this
  have hpos : (0 : ℝ) < (m : ℝ) * Real.exp (-(beta * D)) := by positivity
  rw [scoreSoftmax_eq_inv_sum]
  rw [div_le_div_iff₀ (shifted_denom_pos beta s j) hm]
  calc (1 : ℝ) * (m : ℝ) = (m : ℝ) * Real.exp (-(beta * D)) * Real.exp (beta * D) := by
        rw [mul_assoc, ← Real.exp_add]
        simp
    _ ≤ (∑ l, Real.exp (beta * (s l - s j))) * Real.exp (beta * D) :=
        mul_le_mul_of_nonneg_right hsum (Real.exp_pos _).le
    _ = Real.exp (beta * D) * ∑ l, Real.exp (beta * (s l - s j)) := mul_comm _ _

/-- **The entropy floor of a bounded head.**  If the scores span at most `D`, the
attention entropy is at least `log m − βD`: with bounded scores a head cannot be
sharp unless the temperature is driven to zero. -/
theorem log_card_sub_le_shannonEntropy {beta D : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    (hD : ∀ i l, s i - s l ≤ D) (i : Fin m) :
    Real.log m - beta * D ≤ shannonEntropy (scoreSoftmax beta s) := by
  have hm : (0 : ℝ) < m := by
    have : (0 : ℕ) < m := Fin.pos i
    exact_mod_cast this
  have hbound : ∀ j : Fin m,
      scoreSoftmax beta s j * Real.log (scoreSoftmax beta s j)
        ≤ scoreSoftmax beta s j * (beta * D - Real.log m) := by
    intro j
    refine mul_le_mul_of_nonneg_left ?_ (scoreSoftmax_nonneg beta s j)
    have h := scoreSoftmax_le_of_spread hb s hD j
    have hlog := Real.log_le_log (scoreSoftmax_pos beta s j) h
    have : Real.log (Real.exp (beta * D) / m) = beta * D - Real.log m := by
      rw [Real.log_div (Real.exp_ne_zero _) (ne_of_gt hm), Real.log_exp]
    linarith [this ▸ hlog]
  have hsum : ∑ j, scoreSoftmax beta s j * Real.log (scoreSoftmax beta s j)
      ≤ ∑ j, scoreSoftmax beta s j * (beta * D - Real.log m) :=
    Finset.sum_le_sum fun j _ => hbound j
  have hone : ∑ j, scoreSoftmax beta s j * (beta * D - Real.log m)
      = beta * D - Real.log m := by
    rw [← Finset.sum_mul, scoreSoftmax_sum_one beta s i, one_mul]
  rw [shannonEntropy]
  rw [hone] at hsum
  linarith

end BookProof.ChapterAttentionTemperature
