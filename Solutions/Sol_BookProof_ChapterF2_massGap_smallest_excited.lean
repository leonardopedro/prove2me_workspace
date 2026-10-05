-- Generated from ChapterF2.lean — solution of BookProof.ChapterF2.massGap_smallest_excited
import Mathlib
import Definitions.Def_ChapterF2
import Theorems.Thm_BookProof_ChapterF1_numberOp_monomial
open BookProof.ChapterF2



open Polynomial Finset
open scoped BigOperators


open BookProof.ChapterF1

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (hn : n ≠ 0) :
    hamiltonian (X ^ n) = (n : ℂ) • X ^ n ∧ (1 : ℕ) ≤ n := ⟨numberOp_monomial n, Nat.one_le_iff_ne_zero.mpr hn⟩
