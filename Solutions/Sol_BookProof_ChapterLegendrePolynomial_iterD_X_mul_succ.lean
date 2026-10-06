-- Generated from ChapterLegendrePolynomial.lean — solution of BookProof.ChapterLegendrePolynomial.iterD_X_mul_succ
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
open BookProof.ChapterLegendrePolynomial




open Polynomial

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (f : ℝ[X]) :
    derivative^[k+1] (X * f) = X * derivative^[k+1] f + C ((k : ℝ) + 1) * derivative^[k] f := by

  induction k with
  | zero => simp [derivative_mul]; ring
  | succ k ih =>
      rw [Function.iterate_succ_apply' derivative (k+1) (X * f), ih, derivative_add,
        derivative_mul, derivative_mul, derivative_X, derivative_C, one_mul, zero_mul, zero_add,
        ← Function.iterate_succ_apply' derivative (k+1) f,
        ← Function.iterate_succ_apply' derivative k f]
      generalize derivative^[k+1] f = a
      generalize derivative^[k+1+1] f = b
      push_cast
      simp only [C_add, C_1]
      ring
