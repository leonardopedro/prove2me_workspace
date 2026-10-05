-- Generated from ChapterF1.lean — solution of BookProof.ChapterF1.bargmann_creat_annih
import Mathlib
import Definitions.Def_ChapterF1
import Theorems.Thm_BookProof_ChapterF1_bargmann_monomial_left
import Theorems.Thm_BookProof_ChapterF1_bargmann_monomial
open BookProof.ChapterF1



open Polynomial Finset
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (m n : ℕ) :
    bargmann (creat (X ^ m)) (X ^ n) = bargmann (X ^ m) (annih (X ^ n)) := by

  simp [ bargmann_monomial_left ];
  norm_num [ ← pow_succ', Polynomial.coeff_derivative ];
  split_ifs <;> simp_all [ bargmann_monomial ];
  norm_cast ; simp [ ← ‹_›, Nat.factorial_succ, mul_comm ]
