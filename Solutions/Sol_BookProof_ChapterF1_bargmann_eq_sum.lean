-- Generated from ChapterF1.lean — solution of BookProof.ChapterF1.bargmann_eq_sum
import Mathlib
import Definitions.Def_ChapterF1
open BookProof.ChapterF1



open Polynomial Finset
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p q : ℂ[X]) {s : Finset ℕ}
    (hp : p.support ⊆ s) (hq : q.support ⊆ s) :
    bargmann p q = ∑ n ∈ s, (n.factorial : ℂ) * (starRingEnd ℂ) (p.coeff n) * q.coeff n := by

  convert Finset.sum_subset ( Finset.union_subset hp hq ) _ using 1
  all_goals first
    | aesop
    | (intro x _ hnp; simp_all [Finset.mem_union, Polynomial.mem_support_iff])
