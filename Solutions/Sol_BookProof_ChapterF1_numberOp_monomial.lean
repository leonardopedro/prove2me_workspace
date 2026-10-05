-- Generated from ChapterF1.lean — solution of BookProof.ChapterF1.numberOp_monomial
import Mathlib
import Definitions.Def_ChapterF1
open BookProof.ChapterF1



open Polynomial Finset
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : numberOp (X ^ n) = (n : ℂ) • X ^ n := by

  induction n <;> simp_all [ pow_succ', numberOp ];
  simp [ add_smul, mul_add, add_comm ]
