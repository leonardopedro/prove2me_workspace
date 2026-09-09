import Mathlib
import BookProof.ChapterSoftmaxOrder

/-!
# Chapter "The Coherent State of Attention": the entropy of the attention
distribution

The chapter describes the pre-measurement token as a "high-entropy superposition"
that the attention measurement collapses into a definite output.  `ChapterSoftmaxSharpness`
proves the two limiting shapes of the Softmax distribution; this module measures
them, with the Shannon entropy.

* `shannonEntropy` — `H(p) = -∑ⱼ pⱼ log pⱼ`, and `shannonEntropy_nonneg`.
* `shannonEntropy_le_log_card` — **Gibbs' inequality**: any distribution over `m`
  outcomes has entropy at most `log m`, proved from `log x ≤ x - 1`.
* `shannonEntropy_uniform` — the uniform distribution attains the bound, so
  `log m` is the maximal uncertainty available to a query.
* `shannonEntropy_scoreSoftmax_zero` — at infinite temperature (`β = 0`) attention
  is at maximal entropy `log m`: the query resolves nothing.
* `tendsto_shannonEntropy_scoreSoftmax` — **the collapse.**  If the scores have a
  strict maximizer then the entropy of the attention distribution tends to `0` as
  `β → ∞`: the measurement returns a definite outcome.
* `tendsto_shannonEntropy_bornWeight_smul_query` — the same collapse for the
  coherent-state Born weights as the query is amplified, which is the chapter's
  reading of the measurement.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionEntropy

open Filter Topology BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness
  BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

/-! ## Shannon entropy of a finite distribution -/

/-- The **Shannon entropy** `H(p) = -∑ⱼ pⱼ log pⱼ` of a finite family of weights
(with the usual convention `0 log 0 = 0`, which holds definitionally in Lean since
`Real.log 0 = 0`). -/
def shannonEntropy (p : Fin m → ℝ) : ℝ := -∑ j, p j * Real.log (p j)

/-- Entropy is nonnegative on any sub-probability profile. -/
theorem shannonEntropy_nonneg {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j) (hp1 : ∀ j, p j ≤ 1) :
    0 ≤ shannonEntropy p := by
  rw [shannonEntropy, neg_nonneg]
  refine Finset.sum_nonpos fun j _ => ?_
  rcases eq_or_lt_of_le (hp0 j) with h | h
  · simp [← h]
  · exact mul_nonpos_of_nonneg_of_nonpos h.le (Real.log_nonpos h.le (hp1 j))

/-- **Gibbs' inequality.**  A probability distribution over `m` outcomes has
entropy at most `log m`. -/
theorem shannonEntropy_le_log_card {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j)
    (hsum : ∑ j, p j = 1) : shannonEntropy p ≤ Real.log m := by
  have hm : 0 < m := by
    by_contra hcon
    have : m = 0 := by omega
    subst this
    simp at hsum
  have hmR : (0 : ℝ) < m := by exact_mod_cast hm
  have hterm : ∀ j ∈ Finset.univ,
      -(p j * Real.log (p j)) - p j * Real.log m ≤ 1 / m - p j := by
    intro j _
    rcases eq_or_lt_of_le (hp0 j) with h | h
    · simp [← h]
    · have hx : 0 < 1 / ((m : ℝ) * p j) := by positivity
      have hlog := Real.log_le_sub_one_of_pos hx
      have hrw : Real.log (1 / ((m : ℝ) * p j))
          = -(Real.log m + Real.log (p j)) := by
        rw [one_div, Real.log_inv, Real.log_mul (ne_of_gt hmR) (ne_of_gt h)]
      rw [hrw] at hlog
      have hmul : p j * (-(Real.log m + Real.log (p j)))
          ≤ p j * (1 / ((m : ℝ) * p j) - 1) := by
        exact mul_le_mul_of_nonneg_left hlog h.le
      have hsimp : p j * (1 / ((m : ℝ) * p j) - 1) = 1 / m - p j := by
        field_simp
      rw [hsimp] at hmul
      nlinarith [hmul]
  have hsum' := Finset.sum_le_sum hterm
  have hleft : ∑ j, (-(p j * Real.log (p j)) - p j * Real.log m)
      = shannonEntropy p - Real.log m := by
    rw [Finset.sum_sub_distrib, shannonEntropy, ← Finset.sum_neg_distrib,
      ← Finset.sum_mul, hsum, one_mul]
  have hright : ∑ j : Fin m, ((1 : ℝ) / m - p j) = 0 := by
    rw [Finset.sum_sub_distrib, hsum, Finset.sum_const, Finset.card_univ,
      Fintype.card_fin, nsmul_eq_mul]
    rw [mul_one_div, div_self (ne_of_gt hmR), sub_self]
  rw [hleft, hright] at hsum'
  linarith

/-- The uniform distribution attains the Gibbs bound. -/
theorem shannonEntropy_uniform (hm : 0 < m) :
    shannonEntropy (fun _ : Fin m => (1 : ℝ) / m) = Real.log m := by
  have hmR : (0 : ℝ) < m := by exact_mod_cast hm
  rw [shannonEntropy]
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul,
    one_div, Real.log_inv]
  field_simp

/-! ## The attention distribution at the two extremes -/

/-- **Infinite temperature is maximal uncertainty.**  At `β = 0` the attention
distribution is uniform, so its entropy is the largest available, `log m`. -/
theorem shannonEntropy_scoreSoftmax_zero (s : Fin m → ℝ) (hm : 0 < m) :
    shannonEntropy (fun j => scoreSoftmax 0 s j) = Real.log m := by
  have hfun : (fun j : Fin m => scoreSoftmax 0 s j) = fun _ : Fin m => (1 : ℝ) / m :=
    funext fun j => scoreSoftmax_zero s j
  rw [hfun, shannonEntropy_uniform hm]

/-- The attention distribution never exceeds the maximal entropy `log m`. -/
theorem shannonEntropy_scoreSoftmax_le_log_card (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    shannonEntropy (fun j => scoreSoftmax beta s j) ≤ Real.log m :=
  shannonEntropy_le_log_card (fun j => scoreSoftmax_nonneg beta s j)
    (scoreSoftmax_sum_one beta s i)

/-- **The collapse.**  If the scores have a strict maximizer, the entropy of the
attention distribution tends to `0` as the temperature goes to zero: the
measurement returns a definite outcome. -/
theorem tendsto_shannonEntropy_scoreSoftmax (s : Fin m → ℝ) (j : Fin m)
    (hmax : ∀ l, l ≠ j → s l < s j) :
    Tendsto (fun b : ℝ => shannonEntropy (fun l => scoreSoftmax b s l)) atTop (𝓝 0) := by
  have hterm : ∀ l : Fin m,
      Tendsto (fun b : ℝ => scoreSoftmax b s l * Real.log (scoreSoftmax b s l))
        atTop (𝓝 0) := by
    intro l
    by_cases hl : l = j
    · subst hl
      have h := (Real.continuous_mul_log.tendsto 1).comp (tendsto_scoreSoftmax_max s l hmax)
      simpa [Function.comp] using h
    · have h := (Real.continuous_mul_log.tendsto 0).comp (tendsto_scoreSoftmax_ne s j l hmax hl)
      simpa [Function.comp] using h
  have hsum : Tendsto
      (fun b : ℝ => ∑ l, scoreSoftmax b s l * Real.log (scoreSoftmax b s l)) atTop (𝓝 0) := by
    have h := tendsto_finset_sum (Finset.univ : Finset (Fin m))
      (fun l _ => hterm l)
    simpa using h
  simpa [shannonEntropy] using hsum.neg

/-- **The collapse for the coherent Born rule.**  For keys of a common norm, the
entropy of the Born attention distribution tends to `0` as the query is
amplified. -/
theorem tendsto_shannonEntropy_bornWeight_smul_query {n : ℕ}
    (q : EuclideanSpace ℝ (Fin n)) (k : Fin m → EuclideanSpace ℝ (Fin n)) (r : ℝ)
    (hk : ∀ l, ‖k l‖ = r) (j : Fin m)
    (hmax : ∀ l, l ≠ j → (inner ℝ q (k l) : ℝ) < inner ℝ q (k j)) :
    Tendsto (fun c : ℝ => shannonEntropy (fun l => bornWeight (c • q) k l)) atTop (𝓝 0) := by
  have hrewrite : ∀ c : ℝ, (fun l => bornWeight (c • q) k l)
      = fun l => scoreSoftmax (2 * c) (fun i => inner ℝ q (k i)) l := by
    intro c
    funext l
    rw [coherentBorn_eq_softmax (c • q) k r hk l, softmax_smul_query, softmax_eq_scoreSoftmax]
  have hscale : Tendsto (fun c : ℝ => 2 * c) atTop atTop :=
    Filter.tendsto_id.const_mul_atTop (by norm_num)
  have hlim := (tendsto_shannonEntropy_scoreSoftmax (fun i => inner ℝ q (k i)) j hmax).comp hscale
  simpa [Function.comp, hrewrite] using hlim

end BookProof.ChapterAttentionEntropy

end
