-- Generated from ChapterLegendrePolynomial.lean — solution of BookProof.ChapterLegendrePolynomial.iterD_X_mul
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
import Theorems.Thm_BookProof_ChapterLegendrePolynomial_iterD_X_mul_succ
open BookProof.ChapterLegendrePolynomial




open Polynomial

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (f : ℝ[X]) :
    derivative^[k] (X * f) = X * derivative^[k] f + C (k : ℝ) * derivative^[k-1] f := by

  cases k with
  | zero => simp
  | succ k => simpa using iterD_X_mul_succ k f
