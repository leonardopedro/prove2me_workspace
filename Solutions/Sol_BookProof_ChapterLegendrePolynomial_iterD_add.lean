-- Generated from ChapterLegendrePolynomial.lean — solution of BookProof.ChapterLegendrePolynomial.iterD_add
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
open BookProof.ChapterLegendrePolynomial




open Polynomial

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (p q : ℝ[X]) :
    derivative^[k] (p + q) = derivative^[k] p + derivative^[k] q := by

  induction k generalizing p q with
  | zero => simp
  | succ k ih =>
      rw [Function.iterate_succ_apply, Function.iterate_succ_apply, Function.iterate_succ_apply,
        derivative_add, ih]
