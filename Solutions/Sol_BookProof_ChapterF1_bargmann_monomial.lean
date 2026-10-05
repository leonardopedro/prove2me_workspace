-- Generated from ChapterF1.lean — solution of BookProof.ChapterF1.bargmann_monomial
import Mathlib
import Definitions.Def_ChapterF1
import Theorems.Thm_BookProof_ChapterF1_bargmann_monomial_left
open BookProof.ChapterF1



open Polynomial Finset
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (m n : ℕ) :
    bargmann (X ^ m) (X ^ n) = if m = n then (n.factorial : ℂ) else 0 := by

  convert bargmann_monomial_left m ( X ^ n ) using 1 ; aesop
