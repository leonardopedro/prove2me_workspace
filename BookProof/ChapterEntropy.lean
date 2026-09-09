import Mathlib

/-!
# Chapter — Entropy and an irreversible deterministic time-evolution coexist

Source: `book.tex`, chapter *"Entropy and an irreversible deterministic
time-evolution coexist"* (line ~9474), §"Irreversible deterministic
time-evolution".

The book rescales the joint sample space to the square `[0,1]×[0,1]`, partitions
it into `n²` equal cells, and observes that the probability that a uniformly
random *discrete* self-map of the `n` index cells is **invertible** (a bijection)
equals `n!/nⁿ`; that by Stirling this is asymptotic to `√(2πn) e^{-n}`; and that
it therefore **tends to `0`** as `n → ∞`.  Consequently a randomly sampled
time-evolution is almost surely a non-invertible map (injective but not
surjective) — an irreversible, dissipative deterministic dynamical system — which
is the book's mechanism for the arrow of time coexisting with time-symmetric
laws.

This file formalizes those self-contained mathematical claims:

* `card_selfMaps` / `card_bijections` — there are `nⁿ` self-maps and `n!`
  bijections of an `n`-element index set;
* `invertibleProb` — the invertibility probability, defined as the ratio of the
  two counts, and `invertibleProb_eq` — it equals `(n! : ℝ)/nⁿ`;
* `invertibleProb_nonneg` / `invertibleProb_le_one` — it is a genuine
  probability, lying in `[0,1]` (using `Nat.factorial_le_pow`);
* **headline** `invertibleProb_tendsto_zero` — it tends to `0`;
* `invertibleProb_isEquivalent_stirling` — the Stirling asymptotic
  `n!/nⁿ ~ √(2πn) e^{-n}` (the book's stated equivalent);
* `exists_injective_not_surjective` — on the countable index set `ℕ` there is a
  deterministic map that is injective (non-singular) but not surjective (not
  invertible): a concrete irreversible-dynamics / arrow-of-time witness.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

namespace BookProof.ChapterEntropy

open Filter Asymptotics
open scoped Topology

/-- The number of discrete self-maps of an `n`-element index set is `nⁿ`. -/
theorem card_selfMaps (n : ℕ) : Fintype.card (Fin n → Fin n) = n ^ n := by
  simp

/-- The number of *invertible* discrete self-maps (bijections) of an
`n`-element index set is `n!`. -/
theorem card_bijections (n : ℕ) : Fintype.card (Equiv.Perm (Fin n)) = Nat.factorial n := by
  simp [Fintype.card_perm]

/-- The probability that a uniformly random discrete self-map of the `n` index
cells is invertible: the number of bijections divided by the number of
self-maps. -/
noncomputable def invertibleProb (n : ℕ) : ℝ :=
  (Fintype.card (Equiv.Perm (Fin n)) : ℝ) / (Fintype.card (Fin n → Fin n) : ℝ)

/-- The invertibility probability equals `n!/nⁿ`, matching the book's formula. -/
theorem invertibleProb_eq (n : ℕ) :
    invertibleProb n = (Nat.factorial n : ℝ) / (n ^ n : ℝ) := by
  simp [invertibleProb, card_bijections]

/-- The invertibility probability is nonnegative (it is a genuine probability). -/
theorem invertibleProb_nonneg (n : ℕ) : 0 ≤ invertibleProb n := by
  rw [invertibleProb_eq]; positivity

/-- The invertibility probability is at most `1`: since `n! ≤ nⁿ`
(`Nat.factorial_le_pow`), the ratio `n!/nⁿ` is a genuine probability in `[0,1]`. -/
theorem invertibleProb_le_one (n : ℕ) : invertibleProb n ≤ 1 := by
  rw [invertibleProb_eq]
  rcases Nat.eq_zero_or_pos n with h | h
  · subst h; simp
  · rw [div_le_one (by positivity)]
    exact_mod_cast Nat.factorial_le_pow n

/-- **Headline.** The probability that a randomly sampled discrete
time-evolution is invertible tends to `0` as the partition is refined
(`n → ∞`).  Hence such an evolution is almost surely non-invertible, i.e.
irreversible. -/
theorem invertibleProb_tendsto_zero :
    Tendsto invertibleProb atTop (𝓝 0) := by
  refine tendsto_factorial_div_pow_self_atTop.congr (fun n => ?_)
  rw [invertibleProb_eq]

/-
The book's Stirling asymptotic for the invertibility probability:
`n!/nⁿ ~ √(2πn) e^{-n}` as `n → ∞`.  Obtained from Mathlib's Stirling formula
`Stirling.factorial_isEquivalent_stirling` by dividing through by `nⁿ` and
simplifying `(n/e)ⁿ / nⁿ = e^{-n}`.
-/
theorem invertibleProb_isEquivalent_stirling :
    invertibleProb ~[atTop]
      (fun n : ℕ => Real.sqrt (2 * Real.pi * n) * Real.exp (-(n : ℝ))) := by
  -- Stirling's approximation to the factorial function, with `2πn` reordered.
  have h_stirling :
      (fun n : ℕ => (Nat.factorial n : ℝ)) ~[atTop]
        (fun n : ℕ => Real.sqrt (2 * Real.pi * n) * (n / Real.exp 1) ^ n) := by
    convert Stirling.factorial_isEquivalent_stirling using 1
    ac_rfl
  -- Divide both sides by `nⁿ`.
  convert h_stirling.div
      (show (fun n : ℕ => (n ^ n : ℝ)) ~[atTop] (fun n : ℕ => (n ^ n : ℝ)) from ?_) using 1
  · ext n; simp [invertibleProb, card_bijections]
  · ext n
    norm_num [Real.exp_neg, div_pow]
    ring_nf
    by_cases h : (n : ℝ) = 0 <;> simp [h]
  · rfl

/-- A concrete irreversible deterministic dynamics on the countable index set
`ℕ`: the successor map is injective (non-singular) but not surjective (not
invertible).  This is the book's arrow-of-time witness — a deterministic map
that is one-to-one yet not onto, hence not reversible. -/
theorem exists_injective_not_surjective :
    ∃ f : ℕ → ℕ, Function.Injective f ∧ ¬ Function.Surjective f :=
  ⟨Nat.succ, Nat.succ_injective, fun h => by
    obtain ⟨x, hx⟩ := h 0
    exact (Nat.succ_ne_zero x) hx⟩

end BookProof.ChapterEntropy
