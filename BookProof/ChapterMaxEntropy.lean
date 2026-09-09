import Mathlib

/-!
# Chapter "Aligned deep learning as a random sampling method", §2
"Systematic uncertainties and Bayesian priors" / Chapter "Consciousness as a
representation of a Bayesian prior" — **the maximum-entropy characterization of
the uniform (non-informative) prior**

Source: `book.tex`.  The book repeatedly appeals to the *maximum-entropy* /
*non-informative prior* principle, e.g.

> *"tools and techniques of automated reasoning include … Bayesian inference,
> reasoning with **maximal entropy** and many less formal ad hoc techniques."*
> (`book.tex` line ~9772)

and it stresses that *"there are no non-informative priors and there are no
almost non-informative priors"* (`book.tex` lines ~9349, ~9451): the closest one
gets to a "non-informative" prior on a finite sample space is the **uniform**
distribution, and the precise sense in which it is the least informative is that
it **maximizes the Shannon entropy**.

This module formalizes that self-contained, classical mathematical fact,
entirely independent of the surrounding discussion.  For a finite probability
distribution `p` on a (nonempty) finite sample space `α` with `n = |α|` outcomes,
the Shannon entropy `H(p) = ∑ᵢ −pᵢ log pᵢ` satisfies

* `entropy_nonneg`   — `0 ≤ H(p)`;
* `entropy_le_log_card` — `H(p) ≤ log n` (the maximum-entropy bound, via the
  Gibbs inequality `log x ≤ x − 1`);
* `entropy_uniform`  — the uniform distribution attains it: `H(uniform) = log n`;
* HEADLINE `entropy_le_entropy_uniform` — hence the uniform distribution is the
  **maximum-entropy** distribution: `H(p) ≤ H(uniform)` for every distribution
  `p`;
* `entropy_eq_log_card_iff` — the uniform prior is the **unique** maximizer:
  `H(p) = log n` iff `p` is the uniform distribution (via the strict Gibbs
  inequality `log x < x − 1` for `x ≠ 1`).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Real BigOperators Finset

namespace BookProof.ChapterMaxEntropy

variable {α : Type*} [Fintype α]

/-- A finite probability distribution: nonnegative weights summing to one. -/
structure IsProb (p : α → ℝ) : Prop where
  nonneg : ∀ i, 0 ≤ p i
  sum_one : ∑ i, p i = 1

/-- The **Shannon entropy** of a finite distribution `p`, using Mathlib's
`Real.negMulLog x = -x * log x` (so `H(p) = ∑ᵢ −pᵢ log pᵢ`). -/
noncomputable def entropy (p : α → ℝ) : ℝ := ∑ i, Real.negMulLog (p i)

/-- The **uniform** distribution on `α`: every outcome carries weight `1/|α|`. -/
noncomputable def uniform (α : Type*) [Fintype α] : α → ℝ :=
  fun _ => (Fintype.card α : ℝ)⁻¹

/-- Each weight of a probability distribution is at most `1`. -/
lemma IsProb.le_one {p : α → ℝ} (hp : IsProb p) (i : α) : p i ≤ 1 := by
  rw [← hp.sum_one]
  exact Finset.single_le_sum (fun j _ => hp.nonneg j) (Finset.mem_univ i)

/-- **Entropy is nonnegative.**  Each summand `negMulLog (p i)` is `≥ 0` because
`0 ≤ p i ≤ 1`. -/
theorem entropy_nonneg {p : α → ℝ} (hp : IsProb p) : 0 ≤ entropy p := by
  unfold entropy
  apply Finset.sum_nonneg
  intro i _
  exact Real.negMulLog_nonneg (hp.nonneg i) (hp.le_one i)

/-- The pointwise **Gibbs / tangent-line bound**: for `0 ≤ x` and `0 < n`,
`negMulLog x - x * log n ≤ n⁻¹ - x`.  This is the per-term inequality that,
summed over the sample space, yields the maximum-entropy bound.  It follows from
`log t ≤ t - 1` applied to `t = (x·n)⁻¹`. -/
lemma negMulLog_sub_le (n : ℕ) (hn : 0 < n) {x : ℝ} (hx : 0 ≤ x) :
    Real.negMulLog x - x * Real.log n ≤ (n : ℝ)⁻¹ - x := by
  rcases eq_or_lt_of_le hx with h | h
  · subst h; simp [Real.negMulLog]
  · have hnR : (0 : ℝ) < n := by exact_mod_cast hn
    have key : Real.negMulLog x - x * Real.log n = x * Real.log ((x * n)⁻¹) := by
      rw [Real.negMulLog, Real.log_inv, Real.log_mul (ne_of_gt h) (ne_of_gt hnR)]; ring
    rw [key]
    have hlog : Real.log ((x * n)⁻¹) ≤ (x * n)⁻¹ - 1 :=
      Real.log_le_sub_one_of_pos (by positivity)
    calc x * Real.log ((x * n)⁻¹) ≤ x * ((x * n)⁻¹ - 1) :=
              mul_le_mul_of_nonneg_left hlog hx
      _ = (n : ℝ)⁻¹ - x := by field_simp

/-- **The maximum-entropy bound.**  For any finite probability distribution `p`
on a nonempty finite sample space with `n = |α|` outcomes, `H(p) ≤ log n`. -/
theorem entropy_le_log_card [Nonempty α] {p : α → ℝ} (hp : IsProb p) :
    entropy p ≤ Real.log (Fintype.card α) := by
  have hn : 0 < Fintype.card α := Fintype.card_pos
  have hnR : (Fintype.card α : ℝ) ≠ 0 := by exact_mod_cast hn.ne'
  have hsum : (∑ i, (Real.negMulLog (p i) - p i * Real.log (Fintype.card α)))
      ≤ ∑ i : α, ((Fintype.card α : ℝ)⁻¹ - p i) :=
    Finset.sum_le_sum (fun i _ => negMulLog_sub_le _ hn (hp.nonneg i))
  have lhs : (∑ i, (Real.negMulLog (p i) - p i * Real.log (Fintype.card α)))
      = entropy p - Real.log (Fintype.card α) := by
    rw [entropy, Finset.sum_sub_distrib, ← Finset.sum_mul, hp.sum_one, one_mul]
  have rhs : (∑ i : α, ((Fintype.card α : ℝ)⁻¹ - p i)) = 0 := by
    rw [Finset.sum_sub_distrib, hp.sum_one, Finset.sum_const, Finset.card_univ, nsmul_eq_mul,
      mul_inv_cancel₀ hnR, sub_self]
  rw [lhs, rhs] at hsum
  linarith

/-- The uniform distribution is a genuine probability distribution. -/
theorem isProb_uniform [Nonempty α] : IsProb (uniform α) := by
  constructor
  · intro i; unfold uniform; positivity
  · unfold uniform
    rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
    exact mul_inv_cancel₀ (by exact_mod_cast Fintype.card_pos.ne')

/-- **The uniform distribution attains the maximum-entropy bound**:
`H(uniform) = log |α|`. -/
theorem entropy_uniform [Nonempty α] :
    entropy (uniform α) = Real.log (Fintype.card α) := by
  unfold entropy uniform
  rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
  have hnR : (Fintype.card α : ℝ) ≠ 0 := by exact_mod_cast Fintype.card_pos.ne'
  rw [Real.negMulLog, Real.log_inv]
  field_simp

/-- **HEADLINE — the uniform prior is the maximum-entropy prior.**  Every finite
probability distribution has entropy at most that of the uniform distribution,
so the uniform ("non-informative") prior is the one of maximal entropy. -/
theorem entropy_le_entropy_uniform [Nonempty α] {p : α → ℝ} (hp : IsProb p) :
    entropy p ≤ entropy (uniform α) := by
  rw [entropy_uniform]
  exact entropy_le_log_card hp

/-- The **strict Gibbs bound**: equality in `negMulLog_sub_le` forces `x = n⁻¹`.
This is the equality case of `log t ≤ t - 1` (`log t < t - 1` for `t ≠ 1`),
applied to `t = (x·n)⁻¹`. -/
lemma negMulLog_sub_eq_imp (n : ℕ) (hn : 0 < n) {x : ℝ} (hx : 0 ≤ x)
    (heq : Real.negMulLog x - x * Real.log n = (n : ℝ)⁻¹ - x) : x = (n : ℝ)⁻¹ := by
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  rcases eq_or_lt_of_le hx with h | h
  · exfalso
    rw [← h] at heq
    simp [Real.negMulLog] at heq
    have : (0 : ℝ) < (n : ℝ)⁻¹ := by positivity
    linarith [heq]
  · by_contra hne
    have hxn : x * (n : ℝ) ≠ 1 := by
      intro hcontra
      apply hne
      field_simp at hcontra ⊢
      linarith [hcontra]
    have key : Real.negMulLog x - x * Real.log n = x * Real.log ((x * n)⁻¹) := by
      rw [Real.negMulLog, Real.log_inv, Real.log_mul (ne_of_gt h) (ne_of_gt hnR)]; ring
    have hstrict : Real.log ((x * n)⁻¹) < (x * n)⁻¹ - 1 :=
      Real.log_lt_sub_one_of_pos (by positivity) (by
        intro hc
        apply hxn
        field_simp at hc
        linarith [hc])
    have hlt : x * Real.log ((x * n)⁻¹) < x * ((x * n)⁻¹ - 1) :=
      mul_lt_mul_of_pos_left hstrict h
    rw [key] at heq
    have hval : x * ((x * n)⁻¹ - 1) = (n : ℝ)⁻¹ - x := by field_simp
    rw [hval] at hlt
    linarith [heq, hlt]

/-- **The uniform prior is the unique maximum-entropy prior.**  A finite
probability distribution attains the maximum-entropy bound `H(p) = log |α|` if
and only if it is the uniform distribution. -/
theorem entropy_eq_log_card_iff [Nonempty α] {p : α → ℝ} (hp : IsProb p) :
    entropy p = Real.log (Fintype.card α) ↔ p = uniform α := by
  have hn : 0 < Fintype.card α := Fintype.card_pos
  have hnR : (Fintype.card α : ℝ) ≠ 0 := by exact_mod_cast hn.ne'
  constructor
  · intro hE
    have hle : ∀ i ∈ (Finset.univ : Finset α),
        Real.negMulLog (p i) - p i * Real.log (Fintype.card α)
          ≤ (Fintype.card α : ℝ)⁻¹ - p i :=
      fun i _ => negMulLog_sub_le _ hn (hp.nonneg i)
    have lhs : (∑ i, (Real.negMulLog (p i) - p i * Real.log (Fintype.card α)))
        = entropy p - Real.log (Fintype.card α) := by
      rw [entropy, Finset.sum_sub_distrib, ← Finset.sum_mul, hp.sum_one, one_mul]
    have rhs : (∑ i : α, ((Fintype.card α : ℝ)⁻¹ - p i)) = 0 := by
      rw [Finset.sum_sub_distrib, hp.sum_one, Finset.sum_const, Finset.card_univ, nsmul_eq_mul,
        mul_inv_cancel₀ hnR, sub_self]
    have hsumeq : (∑ i, (Real.negMulLog (p i) - p i * Real.log (Fintype.card α)))
        = ∑ i : α, ((Fintype.card α : ℝ)⁻¹ - p i) := by rw [lhs, rhs, hE, sub_self]
    have hpt := (Finset.sum_eq_sum_iff_of_le hle).mp hsumeq
    funext i
    exact negMulLog_sub_eq_imp _ hn (hp.nonneg i) (hpt i (Finset.mem_univ i))
  · intro hp'; rw [hp']; exact entropy_uniform

end BookProof.ChapterMaxEntropy
