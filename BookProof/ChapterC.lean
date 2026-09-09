import Mathlib

/-!
# Chapter C — Entropy and irreversible deterministic time-evolution coexist

This file formalizes the one rigorous mathematical nugget of Chapter C of `book.tex`
(the "vanishing probability of an invertible partition map"), as specified in
`FORMALIZATION_ROADMAP.md` §C.1.

Partition `[0,1]²` into `n²` equal squares; index rows/columns by `Fin n`.
A "discrete function" is any `f : Fin n → Fin n`; it is *invertible* iff it is a
bijection (a permutation).  Under the uniform measure on `(Fin n)^(Fin n)`
(all `nⁿ` functions equally likely), the probability that `f` is invertible is
`n!/nⁿ`, which is asymptotic to `√(2πn)·e⁻ⁿ` and tends to `0`.
-/

open scoped Nat
open Filter Asymptotics
open scoped Topology

namespace BookProof.ChapterC

/-
The number of invertible discrete maps `Fin n → Fin n` is `n!`.
-/
theorem card_invertible (n : ℕ) : Fintype.card (Equiv.Perm (Fin n)) = n ! := by
  simp [ Fintype.card_perm ]

/-
The number of all discrete maps `Fin n → Fin n` is `nⁿ`.
-/
theorem card_all (n : ℕ) : Fintype.card (Fin n → Fin n) = n ^ n := by
  simp [ Fintype.card_pi ]

/-
The probability that a uniformly random discrete map is invertible is `n!/nⁿ`.
-/
theorem prob_invertible (n : ℕ) :
    (Fintype.card (Equiv.Perm (Fin n)) : ℝ) / (Fintype.card (Fin n → Fin n) : ℝ)
      = (n ! : ℝ) / (n : ℝ) ^ n := by
  rw [ card_invertible, card_all ] ; norm_cast

/-
**Chapter C.1, asymptotic form.** `n!/nⁿ ~ √(2πn)·e⁻ⁿ` as `n → ∞`.
-/
theorem invertible_ratio_isEquivalent :
    (fun n : ℕ => (n ! : ℝ) / (n : ℝ) ^ n)
      ~[atTop] (fun n : ℕ => Real.sqrt (2 * Real.pi * n) * Real.exp (-(n : ℝ))) := by
  have := @Stirling.factorial_isEquivalent_stirling;
  have := this.div ( show ( fun n : ℕ => ( n : ℝ ) ^ n ) ~[atTop] ( fun n : ℕ => ( n : ℝ ) ^ n )
      from by rfl );
  refine this.congr' ?_ ?_;
  · filter_upwards [ Filter.eventually_gt_atTop 0 ] with n hn;
    norm_num [ div_pow, Real.exp_neg, mul_assoc, mul_comm, mul_left_comm, hn.ne' ];
    rw [ div_eq_iff ( by positivity ) ] ; ring;
  · filter_upwards [ Filter.eventually_gt_atTop 0 ] with n hn ;    norm_num [ Real.exp_neg, div_pow,
      mul_pow, mul_assoc, mul_comm, mul_left_comm, hn.ne' ];
    rw [ div_eq_iff ( by positivity ) ] ; ring

/-
**Chapter C.1.** The probability that a uniformly random discrete map
`Fin n → Fin n` is invertible tends to `0`.
-/
theorem invertible_ratio_tendsto_zero :
    Tendsto (fun n : ℕ => (n ! : ℝ) / (n : ℝ) ^ n) atTop (𝓝 0) := by
  grind +suggestions

end BookProof.ChapterC
