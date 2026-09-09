import Mathlib

/-!
# Chapter — A deterministic theory compatible with relativistic Quantum Mechanics

Source: `book.tex`, chapter *"Reconstructing the classical trajectory of any isolated
quantum system"*, §*"A deterministic theory compatible with relativistic Quantum
Mechanics"* (line ~2952).

The book answers, constructively, the question *"Does a deterministic theory —
consistent with the non-deterministic time evolution of Quantum Mechanics —
exist?"* with **yes**, exhibiting one such theory built on the
**inverse-transform sampling** method:

> *"In an experimental setting, we always have a discrete set of possible outcomes
> and thus Quantum Mechanics always predicts a cumulative distribution function.
> This allows us to apply the inverse-transform sampling method for generating
> pseudo-random numbers consistently with the probability distribution predicted
> by Quantum Mechanics."*

This file formalizes the mathematical backbone of that construction: for a
discrete probability distribution `p : ℕ → ℝ` on the outcomes `0, …, n-1`
(`p i ≥ 0`, `∑_{i<n} p i = 1`), the **cumulative distribution function**
`cdf p k = ∑_{i<k} p i` partitions the seed interval `[0,1)` into the half-open
"seed" intervals `seedSet k = [cdf p k, cdf p (k+1))`, one per outcome, such that:

* `seedSet_measure`  — the Lebesgue measure of `seedSet k` is exactly `p k`, so a
  **uniformly** drawn seed produces outcome `k` with probability `p k`: the
  deterministic decoder reproduces the quantum probability distribution;
* `seedSet_disjoint` — the seed intervals are pairwise disjoint (each seed yields
  at most one outcome);
* `seedSet_cover`    — the seed intervals for `k < n` cover `[0,1)` exactly (each
  seed yields at least one outcome);
* `seedSet_total_measure` — the seed intervals carry total measure `1`.

Together these say that `seed ↦ (the unique k < n with seed ∈ seedSet k)` is a
well-defined *deterministic* map `[0,1) → {0,…,n-1}` whose pushforward of the
uniform seed distribution is precisely the quantum distribution `p` — a
deterministic theory experimentally indistinguishable from Quantum Mechanics, as
the book claims. (The physical/metaphysical discussion around the construction is
prose and out of scope.)
-/

namespace BookProof.InverseTransform

open MeasureTheory Set Function

variable {n : ℕ} (p : ℕ → ℝ)

/-- The **cumulative distribution function** of the discrete distribution `p`:
`cdf p k = ∑_{i<k} p i`.  This is the CDF the book says Quantum Mechanics always
predicts in an experimental setting with discretely many outcomes. -/
def cdf (k : ℕ) : ℝ := ∑ i ∈ Finset.range k, p i

/-- The **seed interval** for outcome `k`: the half-open interval of uniform seeds
`u ∈ [0,1)` that the inverse-transform decoder maps to outcome `k`. -/
def seedSet (k : ℕ) : Set ℝ := Set.Ico (cdf p k) (cdf p (k + 1))

/-- `cdf p 0 = 0`. -/
theorem cdf_zero : cdf p 0 = 0 := by
  simp [cdf]

/-- The increment of the CDF over one step is the corresponding probability:
`cdf p (k+1) - cdf p k = p k`. -/
theorem cdf_succ_sub (k : ℕ) : cdf p (k + 1) - cdf p k = p k := by
  unfold cdf
  rw [Finset.sum_range_succ]
  ring

/-- With nonnegative probabilities the CDF is monotone. -/
theorem cdf_monotone (hp : ∀ i, 0 ≤ p i) : Monotone (cdf p) :=
  fun _ _ hij =>
    Finset.sum_le_sum_of_subset_of_nonneg (Finset.range_mono hij) fun i _ _ => hp i

/-- **Inverse-transform sampling reproduces the quantum distribution.**
The Lebesgue measure of the seed interval for outcome `k` is exactly `p k`:
a uniformly drawn seed `u ∈ [0,1)` lands in `seedSet k` with probability `p k`. -/
theorem seedSet_measure (k : ℕ) :
    volume (seedSet p k) = ENNReal.ofReal (p k) := by
  rw [← cdf_succ_sub p k, seedSet, Real.volume_Ico]

/-- **The seed intervals are pairwise disjoint.** Each seed yields at most one
outcome, so the decoder is well-defined. -/
theorem seedSet_disjoint (hp : ∀ i, 0 ≤ p i) :
    Pairwise (Disjoint on seedSet p) :=
  (cdf_monotone p hp).pairwise_disjoint_on_Ico_succ

/-- **The seed intervals cover the whole seed space `[0,1)`.**
Using `cdf p 0 = 0` and `cdf p n = ∑_{i<n} p i = 1`, the seed intervals for the
`n` outcomes exactly tile `[0,1)`: every seed yields at least one outcome. -/
theorem seedSet_cover (hp : ∀ i, 0 ≤ p i) (hsum : cdf p n = 1) :
    (⋃ k ∈ Finset.range n, seedSet p k) = Set.Ico (0 : ℝ) 1 := by
  apply Set.ext
  intro x
  constructor
  · simp only [seedSet, Set.mem_iUnion, Set.mem_Ico, Finset.mem_range]
    rintro ⟨k, hkn, hlo, hhi⟩
    refine ⟨?_, ?_⟩
    · linarith [show 0 ≤ cdf p k from Finset.sum_nonneg fun i _ => hp i]
    · have : cdf p (k + 1) ≤ cdf p n := cdf_monotone p hp (by omega)
      linarith
  · intro hx
    obtain ⟨k, hkn, hkx⟩ : ∃ k, k < n ∧ x < cdf p (k + 1) := by
      cases n with
      | zero => simp [cdf] at hsum
      | succ m => exact ⟨m, Nat.lt_succ_self m, hx.2.trans_le hsum.ge⟩
    clear hsum
    revert hkn hkx
    induction k with
    | zero =>
      intro hkn hkx
      refine Set.mem_biUnion (Finset.mem_range.mpr hkn) ?_
      simp only [seedSet, Set.mem_Ico]
      exact ⟨by simpa [cdf_zero] using hx.1, hkx⟩
    | succ k ih =>
      intro hkn hkx
      by_cases h : x < cdf p (k + 1)
      · exact ih (Nat.lt_of_succ_lt hkn) h
      · refine Set.mem_biUnion (Finset.mem_range.mpr hkn) ?_
        simp only [seedSet, Set.mem_Ico]
        exact ⟨not_lt.mp h, hkx⟩

/-- **Total probability is `1`.** Summing the seed-interval measures over the `n`
outcomes gives `1` — the decoder produces *some* outcome with certainty. -/
theorem seedSet_total_measure (hp : ∀ i, 0 ≤ p i) (hsum : cdf p n = 1) :
    ∑ k ∈ Finset.range n, volume (seedSet p k) = 1 := by
  rw [Finset.sum_congr rfl fun k _ => seedSet_measure p k,
    ← ENNReal.ofReal_sum_of_nonneg fun i _ => hp i]
  have : ∑ i ∈ Finset.range n, p i = 1 := hsum
  rw [this, ENNReal.ofReal_one]

end BookProof.InverseTransform
