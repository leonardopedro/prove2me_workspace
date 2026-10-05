-- Generated from ChapterF2.lean — solution of BookProof.ChapterF2.hamiltonian_expectation_nonneg
import Mathlib
import Definitions.Def_ChapterF2
import Theorems.Thm_BookProof_ChapterF2_bargmann_numberOp_re
open BookProof.ChapterF2



open Polynomial Finset
open scoped BigOperators


open BookProof.ChapterF1

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p : ℂ[X]) :
    0 ≤ (bargmann p (numberOp p)).re := by

  rw [bargmann_numberOp_re]
  apply Finset.sum_nonneg
  intro n hn
  exact mul_nonneg (by positivity) (Complex.normSq_nonneg _)
