import Mathlib

/-!
# Chapter "Entropy and an irreversible deterministic time-evolution coexist",
§"Irreversible deterministic time-evolution" — the probability that a random
discrete map on an `n`-cell partition is invertible

Source: `book.tex`, chapter *"Entropy and an irreversible deterministic
time-evolution coexist"*, §*"Irreversible deterministic time-evolution"*
(`book.tex` line ~9540):

> *"We rescale the square to `[0,1]×[0,1]`. If we partition the square in `n²`
> smaller equal sized squares, then the probability of an invertible discrete
> function (whose domain and image is the index of an interval in the partition)
> is `n!/nⁿ ∼ √(2πn) e^{-n}` (as `n` goes to infinity, the ratio between the left
> and right sides approaches one in the limit). Thus it converges to `0` when
> `n → +∞`."*

The self-contained mathematical content, independent of the surrounding physics,
is a discrete-probability / asymptotics fact.  A "discrete function" on the
`n`-cell index set is an arbitrary map `Fin n → Fin n`; it is "invertible" iff it
is a bijection.  Choosing such a map uniformly at random, the probability of
landing on a bijection is

  `(number of bijections) / (number of functions) = n! / nⁿ`,

and the book asserts (i) this equals `n!/nⁿ`, (ii) it is asymptotically
`√(2πn) e^{-n}` (Stirling), and (iii) it converges to `0`.

## Deliverables

* `card_fun_fin` — there are `nⁿ` functions `Fin n → Fin n`.
* `card_bijective_fin` — there are `n!` bijective functions `Fin n → Fin n`.
* `bijProb` — the probability `n!/nⁿ`.
* `bijProb_eq_card_ratio` — `bijProb n` is the ratio (bijections)/(functions).
* `factorial_succ_le` — the elementary bound `(n+1)! ≤ (n+1)ⁿ`.
* `bijProb_nonneg`, `bijProb_le_one_div` — `0 ≤ bijProb n ≤ 1/n`.
* `bijProb_tendsto_zero` — **the book's "converges to `0`"**: `bijProb n → 0`.
* `bijProb_isEquivalent_stirling` — **the book's `∼ √(2πn) e^{-n}`**:
  `bijProb` is asymptotically equivalent to `n ↦ √(2πn) · e^{-n}` (from
  Mathlib's Stirling formula).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped Nat
open Filter Asymptotics

namespace BookProof.ChapterBijectionProbability

/-- There are `nⁿ` "discrete functions" `Fin n → Fin n` on the `n`-cell index
set of the partition. -/
theorem card_fun_fin (n : ℕ) : Fintype.card (Fin n → Fin n) = n ^ n := by
  simp

/-- The invertible ("bijective") discrete functions `Fin n → Fin n` correspond
bijectively to the permutations of `Fin n`. -/
noncomputable def permEquivBijective (n : ℕ) :
    Equiv.Perm (Fin n) ≃ {f : Fin n → Fin n // Function.Bijective f} where
  toFun σ := ⟨σ, σ.bijective⟩
  invFun f := Equiv.ofBijective f.1 f.2
  left_inv σ := by ext x; rfl
  right_inv f := by ext x; rfl

/-- There are exactly `n!` invertible (bijective) discrete functions
`Fin n → Fin n`. -/
theorem card_bijective_fin (n : ℕ) :
    Fintype.card {f : Fin n → Fin n // Function.Bijective f} = n ! := by
  rw [← Fintype.card_congr (permEquivBijective n), Fintype.card_perm, Fintype.card_fin]

/-- The probability that a uniformly random discrete function `Fin n → Fin n`
is invertible: `n!/nⁿ`. -/
noncomputable def bijProb (n : ℕ) : ℝ := (n ! : ℝ) / (n : ℝ) ^ n

/-- `bijProb n` is the ratio (number of invertible functions)/(number of
functions) — the uniform probability the book describes. -/
theorem bijProb_eq_card_ratio (n : ℕ) :
    bijProb n =
      (Fintype.card {f : Fin n → Fin n // Function.Bijective f} : ℝ)
        / (Fintype.card (Fin n → Fin n) : ℝ) := by
  rw [card_bijective_fin, card_fun_fin, bijProb]
  push_cast
  ring

/-- Elementary bound `(n+1)! ≤ (n+1)ⁿ`: the factorial keeps the leading factor
`1`, so only `n` of the `n+1` factors need to be bounded by `n+1`. -/
theorem factorial_succ_le (n : ℕ) : (n + 1)! ≤ (n + 1) ^ n := by
  induction n with
  | zero => simp
  | succ m ih =>
    calc (m + 2)! = (m + 2) * (m + 1)! := by rw [Nat.factorial_succ]
      _ ≤ (m + 2) * (m + 1) ^ m := Nat.mul_le_mul_left _ ih
      _ ≤ (m + 2) * (m + 2) ^ m := Nat.mul_le_mul_left _ (Nat.pow_le_pow_left (by omega) m)
      _ = (m + 2) ^ (m + 1) := by ring

/-- The probability is nonnegative. -/
theorem bijProb_nonneg (n : ℕ) : 0 ≤ bijProb n := by
  unfold bijProb; positivity

/-- The probability is at most `1/n` (for `n ≥ 1`); this is the quantitative
step behind the book's "converges to `0`". -/
theorem bijProb_le_one_div (n : ℕ) (hn : 1 ≤ n) : bijProb n ≤ 1 / (n : ℝ) := by
  cases n with
  | zero => omega
  | succ m =>
    have hpos : (0 : ℝ) < (m : ℝ) + 1 := by positivity
    have hcast : ((m + 1)! : ℝ) ≤ ((m : ℝ) + 1) ^ m := by
      have := factorial_succ_le m
      calc ((m + 1)! : ℝ) ≤ (((m + 1) ^ m : ℕ) : ℝ) := by exact_mod_cast this
        _ = ((m : ℝ) + 1) ^ m := by push_cast; ring
    simp only [bijProb]
    rw [div_le_div_iff₀ (by push_cast; positivity) (by push_cast; positivity)]
    push_cast
    calc ((m + 1)! : ℝ) * ((m : ℝ) + 1) ≤ ((m : ℝ) + 1) ^ m * ((m : ℝ) + 1) :=
          mul_le_mul_of_nonneg_right hcast (le_of_lt hpos)
      _ = 1 * ((m : ℝ) + 1) ^ (m + 1) := by ring

/-- **The book's "converges to `0`".** The probability that a random discrete
function is invertible tends to `0` as the partition is refined (`n → ∞`). -/
theorem bijProb_tendsto_zero : Tendsto bijProb atTop (nhds 0) := by
  apply squeeze_zero' (f := bijProb) (g := fun n : ℕ => 1 / (n : ℝ))
  · exact Eventually.of_forall bijProb_nonneg
  · filter_upwards [eventually_ge_atTop 1] with n hn using bijProb_le_one_div n hn
  · exact tendsto_one_div_atTop_nhds_zero_nat

/-- **The book's `n!/nⁿ ∼ √(2πn) e^{-n}`.** The invertibility probability is
asymptotically equivalent, as `n → ∞`, to `√(2πn) · e^{-n}`. This is Stirling's
formula (`Stirling.factorial_isEquivalent_stirling`) divided by `nⁿ`. -/
theorem bijProb_isEquivalent_stirling :
    IsEquivalent atTop bijProb
      (fun n => Real.sqrt (2 * n * Real.pi) * Real.exp (-(n : ℝ))) := by
  have hb : bijProb = (fun n : ℕ => (n ! : ℝ)) / (fun n : ℕ => (n : ℝ) ^ n) := rfl
  rw [hb]
  have hstir := Stirling.factorial_isEquivalent_stirling
  have hpow : IsEquivalent atTop (fun n : ℕ => (n : ℝ) ^ n) (fun n : ℕ => (n : ℝ) ^ n) :=
    IsEquivalent.refl
  refine (hstir.div hpow).congr_right ?_
  filter_upwards [eventually_ge_atTop 1] with n hn
  have hn0 : (n : ℝ) ≠ 0 := by positivity
  have hnn : ((n : ℝ) ^ n) ≠ 0 := pow_ne_zero _ hn0
  simp only [Pi.div_apply]
  rw [mul_div_assoc]
  congr 1
  rw [div_pow, div_right_comm, div_self hnn, one_div, Real.exp_one_pow, ← Real.exp_neg]

end BookProof.ChapterBijectionProbability
