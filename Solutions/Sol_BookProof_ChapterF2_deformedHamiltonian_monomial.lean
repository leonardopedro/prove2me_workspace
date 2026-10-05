-- Generated from ChapterF2.lean — solution of BookProof.ChapterF2.deformedHamiltonian_monomial
import Mathlib
import Definitions.Def_ChapterF2
import Theorems.Thm_BookProof_ChapterF1_numberOp_monomial
open BookProof.ChapterF2



open Polynomial Finset
open scoped BigOperators


open BookProof.ChapterF1

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (c : ℂ) (n : ℕ) :
    deformedHamiltonian c (X ^ n) = (c * n) • X ^ n := by

  simp only [deformedHamiltonian, LinearMap.smul_apply, numberOp_monomial, smul_smul]
