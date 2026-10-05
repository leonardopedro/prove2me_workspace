-- Generated from ChapterF2.lean — solution of BookProof.ChapterF2.bargmann_numberOp_re
import Mathlib
import Definitions.Def_ChapterF2
import Theorems.Thm_BookProof_ChapterF2_numberOp_coeff
import Theorems.Thm_BookProof_ChapterF2_numberOp_support
import Theorems.Thm_BookProof_ChapterF1_bargmann_eq_sum
open BookProof.ChapterF2



open Polynomial Finset
open scoped BigOperators


open BookProof.ChapterF1

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p : ℂ[X]) :
    (bargmann p (numberOp p)).re
      = ∑ n ∈ p.support, ((n : ℝ) * n.factorial) * Complex.normSq (p.coeff n) := by

  rw [bargmann_eq_sum p (numberOp p) (Finset.Subset.refl _) (numberOp_support p), Complex.re_sum]
  apply Finset.sum_congr rfl
  intro n hn
  rw [numberOp_coeff]
  have : (n.factorial : ℂ) * (starRingEnd ℂ) (p.coeff n) * ((n : ℂ) * p.coeff n)
      = ((n : ℂ) * n.factorial) * (p.coeff n * (starRingEnd ℂ) (p.coeff n)) := by ring
  rw [this, Complex.mul_conj]; simp
