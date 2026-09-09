import Mathlib
import BookProof.ChapterSoftmaxOrder

/-!
# Chapter "The Coherent State of Attention" — masking is conditioning

A transformer head almost never attends to all of its keys: a *mask* restricts
the sum to an admissible set `S` of keys (the causal mask `{l ≤ i}` being the
standard example).  This module proves that masking is not an extra ingredient
but the **Bayesian conditioning** of the unmasked attention distribution on the
event "the key lies in `S`".

Deliverables (all `sorry`-free, `axiom`-free):

* `maskedSoftmax β s S` — Softmax restricted to the admissible keys;
* `maskedSoftmax_sum_one`, `maskedSoftmax_nonneg`, `maskedSoftmax_pos_of_mem`,
  `maskedSoftmax_eq_zero_of_not_mem` — it is a probability distribution supported
  exactly on `S`;
* `maskedSoftmax_univ` — the empty mask is ordinary Softmax;
* **`maskedSoftmax_eq_conditional`** — the headline: on `S` the masked weight is
  the unmasked weight renormalized by the total unmasked weight of `S`, i.e.
  `p(j | S) = p(j)/p(S)`;
* `maskedSoftmax_odds` — masking leaves every odds ratio inside `S` untouched: it
  removes keys, it does not re-rank them;
* `maskedSoftmax_le_iff` — and hence preserves the score order on `S`;
* `maskedSoftmax_restrict` — the tower property: conditioning on `T ⊆ S` a
  distribution already conditioned on `S` gives conditioning on `T`, so a
  composite mask is a single mask;
* `causalMask` — the causal (autoregressive) mask, its monotonicity, and
  `causalSoftmax_eq_zero_of_lt`: no weight on the future.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionMasking

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

/-! ## The masked attention distribution -/

/-- **Masked Softmax**: attention restricted to the admissible key set `S`. -/
def maskedSoftmax (beta : ℝ) (s : Fin m → ℝ) (S : Finset (Fin m)) (j : Fin m) : ℝ :=
  if j ∈ S then Real.exp (beta * s j) / ∑ l ∈ S, Real.exp (beta * s l) else 0

theorem maskedDenom_pos (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)} (hS : S.Nonempty) :
    0 < ∑ l ∈ S, Real.exp (beta * s l) := by
  obtain ⟨i, hi⟩ := hS
  exact Finset.sum_pos' (fun l _ => le_of_lt (Real.exp_pos _)) ⟨i, hi, Real.exp_pos _⟩

theorem maskedSoftmax_of_mem (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)} {j : Fin m}
    (hj : j ∈ S) :
    maskedSoftmax beta s S j = Real.exp (beta * s j) / ∑ l ∈ S, Real.exp (beta * s l) := by
  rw [maskedSoftmax, if_pos hj]

theorem maskedSoftmax_eq_zero_of_not_mem (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)}
    {j : Fin m} (hj : j ∉ S) : maskedSoftmax beta s S j = 0 := by
  rw [maskedSoftmax, if_neg hj]

theorem maskedSoftmax_pos_of_mem (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)} {j : Fin m}
    (hj : j ∈ S) : 0 < maskedSoftmax beta s S j := by
  rw [maskedSoftmax_of_mem beta s hj]
  exact div_pos (Real.exp_pos _) (maskedDenom_pos beta s ⟨j, hj⟩)

theorem maskedSoftmax_nonneg (beta : ℝ) (s : Fin m → ℝ) (S : Finset (Fin m)) (j : Fin m) :
    0 ≤ maskedSoftmax beta s S j := by
  by_cases hj : j ∈ S
  · exact le_of_lt (maskedSoftmax_pos_of_mem beta s hj)
  · rw [maskedSoftmax_eq_zero_of_not_mem beta s hj]

/-- The masked weights are a probability distribution over the keys. -/
theorem maskedSoftmax_sum_one (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)}
    (hS : S.Nonempty) : ∑ j, maskedSoftmax beta s S j = 1 := by
  have hne := ne_of_gt (maskedDenom_pos beta s hS)
  rw [← Finset.sum_subset (Finset.subset_univ S)
    (fun x _ hx => maskedSoftmax_eq_zero_of_not_mem beta s hx)]
  rw [Finset.sum_congr rfl fun j hj => maskedSoftmax_of_mem beta s hj, ← Finset.sum_div,
    div_self hne]

/-- The trivial mask is ordinary Softmax. -/
theorem maskedSoftmax_univ (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    maskedSoftmax beta s Finset.univ j = scoreSoftmax beta s j := by
  rw [maskedSoftmax, if_pos (Finset.mem_univ j), scoreSoftmax]

/-! ## Masking is Bayesian conditioning -/

/-- **HEADLINE — masking is conditioning.**  For an admissible key `j`, the masked
attention weight is the unmasked weight of `j` divided by the total unmasked
weight of the admissible set: `p(j | S) = p(j)/p(S)`. -/
theorem maskedSoftmax_eq_conditional (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)}
    {j : Fin m} (hj : j ∈ S) :
    maskedSoftmax beta s S j = scoreSoftmax beta s j / ∑ l ∈ S, scoreSoftmax beta s l := by
  have hZ : (0 : ℝ) < ∑ l, Real.exp (beta * s l) := scoreSoftmax_denom_pos beta s j
  have hS : (0 : ℝ) < ∑ l ∈ S, Real.exp (beta * s l) := maskedDenom_pos beta s ⟨j, hj⟩
  have hsum : ∑ l ∈ S, scoreSoftmax beta s l
      = (∑ l ∈ S, Real.exp (beta * s l)) / ∑ l, Real.exp (beta * s l) := by
    rw [Finset.sum_div]
    exact Finset.sum_congr rfl fun l _ => rfl
  rw [maskedSoftmax_of_mem beta s hj, hsum, scoreSoftmax,
    div_div_div_cancel_right₀ (ne_of_gt hZ)]

/-- **Masking does not re-rank.**  The odds between two admissible keys are the
same masked and unmasked. -/
theorem maskedSoftmax_odds (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)} {i j : Fin m}
    (hi : i ∈ S) (hj : j ∈ S) :
    maskedSoftmax beta s S j * scoreSoftmax beta s i
      = maskedSoftmax beta s S i * scoreSoftmax beta s j := by
  have hS : (0 : ℝ) < ∑ l ∈ S, Real.exp (beta * s l) := maskedDenom_pos beta s ⟨j, hj⟩
  rw [maskedSoftmax_of_mem beta s hj, maskedSoftmax_of_mem beta s hi, scoreSoftmax, scoreSoftmax]
  field_simp

/-- Consequently masking preserves the score order on the admissible set. -/
theorem maskedSoftmax_le_iff {beta : ℝ} (hbeta : 0 < beta) (s : Fin m → ℝ)
    {S : Finset (Fin m)} {i j : Fin m} (hi : i ∈ S) (hj : j ∈ S) :
    maskedSoftmax beta s S i ≤ maskedSoftmax beta s S j ↔ s i ≤ s j := by
  have hS : (0 : ℝ) < ∑ l ∈ S, Real.exp (beta * s l) := maskedDenom_pos beta s ⟨j, hj⟩
  rw [maskedSoftmax_of_mem beta s hi, maskedSoftmax_of_mem beta s hj,
    div_le_div_iff_of_pos_right hS, Real.exp_le_exp,
    mul_le_mul_iff_of_pos_left hbeta]

/-- **The tower property of masks.**  Conditioning an already masked head on a
smaller admissible set `T ⊆ S` is the same as masking by `T` directly, so a
composition of masks is a single mask. -/
theorem maskedSoftmax_restrict (beta : ℝ) (s : Fin m → ℝ) {S T : Finset (Fin m)}
    (hTS : T ⊆ S) {j : Fin m} (hj : j ∈ T) :
    maskedSoftmax beta s T j
      = maskedSoftmax beta s S j / ∑ l ∈ T, maskedSoftmax beta s S l := by
  have hS : (0 : ℝ) < ∑ l ∈ S, Real.exp (beta * s l) := maskedDenom_pos beta s ⟨j, hTS hj⟩
  have hT : (0 : ℝ) < ∑ l ∈ T, Real.exp (beta * s l) := maskedDenom_pos beta s ⟨j, hj⟩
  have hsum : ∑ l ∈ T, maskedSoftmax beta s S l
      = (∑ l ∈ T, Real.exp (beta * s l)) / ∑ l ∈ S, Real.exp (beta * s l) := by
    rw [Finset.sum_div]
    exact Finset.sum_congr rfl fun l hl => maskedSoftmax_of_mem beta s (hTS hl)
  rw [hsum, maskedSoftmax_of_mem beta s (hTS hj), maskedSoftmax_of_mem beta s hj,
    div_div_div_cancel_right₀ (ne_of_gt hS)]

/-! ## The causal mask -/

/-- The **causal (autoregressive) mask**: position `i` may attend only to
positions `l ≤ i`. -/
def causalMask (m : ℕ) (i : Fin m) : Finset (Fin m) := Finset.univ.filter fun l => l ≤ i

theorem mem_causalMask {i l : Fin m} : l ∈ causalMask m i ↔ l ≤ i := by
  simp [causalMask]

theorem causalMask_nonempty (i : Fin m) : (causalMask m i).Nonempty :=
  ⟨i, mem_causalMask.2 le_rfl⟩

/-- Causal attention puts no weight on the future. -/
theorem causalSoftmax_eq_zero_of_lt (beta : ℝ) (s : Fin m → ℝ) {i j : Fin m} (hij : i < j) :
    maskedSoftmax beta s (causalMask m i) j = 0 :=
  maskedSoftmax_eq_zero_of_not_mem beta s (by simp [mem_causalMask, not_le.2 hij])

/-- The causal masks grow with the position: attention windows are nested. -/
theorem causalMask_subset {i i' : Fin m} (h : i ≤ i') : causalMask m i ⊆ causalMask m i' :=
  fun _ hl => mem_causalMask.2 (le_trans (mem_causalMask.1 hl) h)

/-- Causal attention is the conditioning of full attention on the past. -/
theorem causalSoftmax_eq_conditional (beta : ℝ) (s : Fin m → ℝ) {i j : Fin m} (hij : j ≤ i) :
    maskedSoftmax beta s (causalMask m i) j
      = scoreSoftmax beta s j / ∑ l ∈ causalMask m i, scoreSoftmax beta s l :=
  maskedSoftmax_eq_conditional beta s (mem_causalMask.2 hij)

end BookProof.ChapterAttentionMasking

end
