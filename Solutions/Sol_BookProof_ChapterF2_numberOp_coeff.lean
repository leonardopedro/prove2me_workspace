-- Generated from ChapterF2.lean — solution of BookProof.ChapterF2.numberOp_coeff
import Mathlib
import Definitions.Def_ChapterF2
open BookProof.ChapterF2



open Polynomial Finset
open scoped BigOperators


open BookProof.ChapterF1

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p : ℂ[X]) (n : ℕ) :
    (numberOp p).coeff n = (n : ℂ) * p.coeff n := by

  simp only [numberOp, LinearMap.comp_apply, creat_apply, annih_apply]
  cases n with
  | zero => simp
  | succ m => rw [Polynomial.coeff_X_mul, Polynomial.coeff_derivative]; push_cast; ring
