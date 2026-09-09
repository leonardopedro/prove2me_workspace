import Mathlib
import BookProof.ChapterAttentionEntropy

/-!
# Chapter "The Coherent State of Attention": how many keys is the head actually reading?

The Shannon entropy of `ChapterAttentionEntropy` measures the uncertainty of the
Born measurement in nats.  Practitioners usually want the same information as a
*count*: how many keys does a head effectively attend to?  The standard answer is
the **participation ratio** — the reciprocal of the collision probability

`P₂(p) = ∑ⱼ pⱼ²`,  `N_eff(p) = 1 / P₂(p)`,

which is the exponential of the Rényi-2 (collision) entropy `H₂ = −log P₂`.  This
module proves that this count behaves exactly as a count should.

* `collisionProb_le_one`, `inv_card_le_collisionProb` (Cauchy–Schwarz) —
  `1/m ≤ P₂ ≤ 1`, hence `one_le_effectiveSupport` and
  `effectiveSupport_le_card`: a head reads at least one and at most `m` keys.
* `collisionProb_uniform`, `effectiveSupport_uniform` — at infinite temperature
  the count is exactly `m`, and `effectiveSupport_scoreSoftmax_zero` says the same
  for the attention distribution at `β = 0`.
* `renyi2_le_shannonEntropy` — the Rényi-2 entropy never exceeds the Shannon
  entropy (a tangent-line/Jensen argument for `log`), so the participation ratio
  is a *conservative* count: `N_eff ≤ exp H`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionCollision

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterAttentionEntropy

variable {m : ℕ}

/-! ## The collision probability and the participation ratio -/

/-- The **collision probability** `P₂(p) = ∑ pⱼ²`: the chance that two independent
Born measurements return the same key. -/
def collisionProb (p : Fin m → ℝ) : ℝ := ∑ j, (p j) ^ 2

/-- The **participation ratio** `N_eff = 1/P₂`: the effective number of keys the
head is reading. -/
def effectiveSupport (p : Fin m → ℝ) : ℝ := 1 / collisionProb p

/-- The **Rényi-2 (collision) entropy** `H₂ = −log P₂`. -/
def renyi2 (p : Fin m → ℝ) : ℝ := -Real.log (collisionProb p)

theorem collisionProb_nonneg (p : Fin m → ℝ) : 0 ≤ collisionProb p :=
  Finset.sum_nonneg fun _ _ => sq_nonneg _

/-- For a probability vector the collision probability is at most `1`. -/
theorem collisionProb_le_one {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j) (hp1 : ∀ j, p j ≤ 1)
    (hsum : ∑ j, p j = 1) : collisionProb p ≤ 1 := by
  calc collisionProb p = ∑ j, p j * p j := by
        simp [collisionProb, sq]
    _ ≤ ∑ j, p j * 1 :=
        Finset.sum_le_sum fun j _ => by
          exact mul_le_mul_of_nonneg_left (hp1 j) (hp0 j)
    _ = 1 := by simpa using hsum

/-- **Cauchy–Schwarz**: the collision probability of a probability vector over `m`
keys is at least `1/m`, with equality for the uniform distribution. -/
theorem inv_card_le_collisionProb {p : Fin m → ℝ} (hsum : ∑ j, p j = 1) :
    (m : ℝ)⁻¹ ≤ collisionProb p := by
  have hcs : (∑ j, p j) ^ 2 ≤ (m : ℝ) * ∑ j, (p j) ^ 2 := by
    simpa using (sq_sum_le_card_mul_sum_sq (s := (Finset.univ : Finset (Fin m))) (f := p))
  rw [hsum] at hcs
  have hm : 0 < (m : ℝ) := by
    rcases Nat.eq_zero_or_pos m with hm0 | hm0
    · subst hm0
      simp at hsum
    · exact_mod_cast hm0
  rw [inv_le_iff_one_le_mul₀ hm]
  simpa [collisionProb, mul_comm] using hcs

theorem collisionProb_pos {p : Fin m → ℝ} (hsum : ∑ j, p j = 1) : 0 < collisionProb p := by
  have hm : 0 < (m : ℝ) := by
    rcases Nat.eq_zero_or_pos m with hm0 | hm0
    · subst hm0
      simp at hsum
    · exact_mod_cast hm0
  exact lt_of_lt_of_le (by positivity) (inv_card_le_collisionProb hsum)

/-- The participation ratio is at least `1`: a head always reads at least one key. -/
theorem one_le_effectiveSupport {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j) (hp1 : ∀ j, p j ≤ 1)
    (hsum : ∑ j, p j = 1) : 1 ≤ effectiveSupport p := by
  have hpos := collisionProb_pos hsum
  rw [effectiveSupport, le_div_iff₀ hpos, one_mul]
  exact collisionProb_le_one hp0 hp1 hsum

/-- The participation ratio never exceeds the number of keys. -/
theorem effectiveSupport_le_card {p : Fin m → ℝ} (hsum : ∑ j, p j = 1) :
    effectiveSupport p ≤ (m : ℝ) := by
  have hpos := collisionProb_pos hsum
  have h := inv_card_le_collisionProb hsum
  have hm : 0 < (m : ℝ) := by
    rcases Nat.eq_zero_or_pos m with hm0 | hm0
    · subst hm0
      simp at hsum
    · exact_mod_cast hm0
  rw [effectiveSupport, div_le_iff₀ hpos]
  calc (1 : ℝ) = (m : ℝ) * (m : ℝ)⁻¹ := by field_simp
    _ ≤ (m : ℝ) * collisionProb p := by
        exact mul_le_mul_of_nonneg_left h hm.le

/-- The uniform distribution has collision probability `1/m`. -/
theorem collisionProb_uniform (hm : 0 < m) :
    collisionProb (fun _ : Fin m => (1 : ℝ) / m) = (m : ℝ)⁻¹ := by
  have hm' : (m : ℝ) ≠ 0 := by positivity
  simp only [collisionProb, div_pow, one_pow, Finset.sum_const, Finset.card_univ,
    Fintype.card_fin, nsmul_eq_mul]
  field_simp

/-- The uniform distribution has participation ratio exactly `m`: every key is
being read. -/
theorem effectiveSupport_uniform (hm : 0 < m) :
    effectiveSupport (fun _ : Fin m => (1 : ℝ) / m) = (m : ℝ) := by
  have hm' : (m : ℝ) ≠ 0 := by positivity
  rw [effectiveSupport, collisionProb_uniform hm]
  field_simp

/-! ## Rényi-2 versus Shannon -/

/-- The tangent-line bound for the logarithm: `log x ≤ x/c + log c − 1`. -/
theorem log_le_div_add_log_sub_one {x c : ℝ} (hx : 0 < x) (hc : 0 < c) :
    Real.log x ≤ x / c + Real.log c - 1 := by
  have h : Real.log (x / c) ≤ x / c - 1 := Real.log_le_sub_one_of_pos (by positivity)
  rw [Real.log_div hx.ne' hc.ne'] at h
  linarith

/-- **The Rényi-2 entropy is a lower bound for the Shannon entropy.**  Equivalently
`∑ pⱼ log pⱼ ≤ log ∑ pⱼ²`, a Jensen inequality for the concave logarithm.  So the
participation ratio `N_eff = exp H₂` never overstates the number of keys read:
`N_eff ≤ exp H`. -/
theorem renyi2_le_shannonEntropy {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j)
    (hsum : ∑ j, p j = 1) : renyi2 p ≤ shannonEntropy p := by
  have hc : 0 < collisionProb p := collisionProb_pos hsum
  have key : ∀ j : Fin m, p j * Real.log (p j)
      ≤ p j * (p j / collisionProb p + Real.log (collisionProb p) - 1) := by
    intro j
    rcases (hp0 j).lt_or_eq with hpos | hzero
    · exact mul_le_mul_of_nonneg_left (log_le_div_add_log_sub_one hpos hc) hpos.le
    · simp [← hzero]
  have hsum_le : ∑ j, p j * Real.log (p j)
      ≤ ∑ j, p j * (p j / collisionProb p + Real.log (collisionProb p) - 1) :=
    Finset.sum_le_sum fun j _ => key j
  have hrhs : ∑ j, p j * (p j / collisionProb p + Real.log (collisionProb p) - 1)
      = Real.log (collisionProb p) := by
    have hexp : ∀ j : Fin m, p j * (p j / collisionProb p + Real.log (collisionProb p) - 1)
        = (p j) ^ 2 / collisionProb p + p j * (Real.log (collisionProb p) - 1) := by
      intro j; field_simp; ring
    rw [Finset.sum_congr rfl fun j _ => hexp j, Finset.sum_add_distrib, ← Finset.sum_div,
      ← Finset.sum_mul, hsum]
    rw [show ∑ j, (p j) ^ 2 = collisionProb p from rfl, div_self hc.ne']
    ring
  rw [hrhs] at hsum_le
  rw [renyi2, shannonEntropy]
  linarith

theorem renyi2_nonneg {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j) (hp1 : ∀ j, p j ≤ 1)
    (hsum : ∑ j, p j = 1) : 0 ≤ renyi2 p := by
  have h := collisionProb_le_one hp0 hp1 hsum
  have hpos := collisionProb_pos hsum
  have : Real.log (collisionProb p) ≤ 0 := Real.log_nonpos hpos.le h
  simpa [renyi2] using this

/-! ## The attention distribution -/

theorem collisionProb_scoreSoftmax_pos (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    0 < collisionProb (scoreSoftmax beta s) :=
  collisionProb_pos (scoreSoftmax_sum_one beta s i)

/-- The effective number of attended keys lies between `1` and `m`. -/
theorem effectiveSupport_scoreSoftmax_mem_Icc (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    effectiveSupport (scoreSoftmax beta s) ∈ Set.Icc (1 : ℝ) (m : ℝ) :=
  ⟨one_le_effectiveSupport (scoreSoftmax_nonneg beta s) (scoreSoftmax_le_one beta s)
      (scoreSoftmax_sum_one beta s i),
    effectiveSupport_le_card (scoreSoftmax_sum_one beta s i)⟩

/-- **At infinite temperature the head reads every key**: the participation ratio
at `β = 0` is exactly the number of keys. -/
theorem effectiveSupport_scoreSoftmax_zero (s : Fin m → ℝ) (i : Fin m) :
    effectiveSupport (scoreSoftmax 0 s) = (m : ℝ) := by
  have hm : 0 < m := Fin.pos i
  have : scoreSoftmax (0 : ℝ) s = fun _ : Fin m => (1 : ℝ) / m := by
    funext j; exact scoreSoftmax_zero s j
  rw [this, effectiveSupport_uniform hm]

/-- The collision entropy of the attention distribution is a lower bound for its
Shannon entropy. -/
theorem renyi2_scoreSoftmax_le_shannonEntropy (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    renyi2 (scoreSoftmax beta s) ≤ shannonEntropy (scoreSoftmax beta s) :=
  renyi2_le_shannonEntropy (scoreSoftmax_nonneg beta s) (scoreSoftmax_sum_one beta s i)

end BookProof.ChapterAttentionCollision

end
