-- Generated from ChapterF1.lean — solution of BookProof.ChapterF1.bargmann_monomial_left
import Mathlib
import Definitions.Def_ChapterF1
open BookProof.ChapterF1



open Polynomial Finset
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ) (q : ℂ[X]) :
    bargmann (X ^ m) q = (m.factorial : ℂ) * q.coeff m := by

  unfold bargmann;
  rw [ Finset.sum_eq_single m ] <;> simp_all [ Polynomial.coeff_X_pow ]
