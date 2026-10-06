-- Generated from ChapterLegendrePolynomial.lean — solution of BookProof.ChapterLegendrePolynomial.iterD_Xsq_mul
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
import Theorems.Thm_BookProof_ChapterLegendrePolynomial_iterD_X_mul
open BookProof.ChapterLegendrePolynomial




open Polynomial

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (f : ℝ[X]) :
    derivative^[k] (X ^ 2 * f)
      = X ^ 2 * derivative^[k] f + C (2 * (k : ℝ)) * X * derivative^[k-1] f
        + C ((k : ℝ) * ((k : ℝ) - 1)) * derivative^[k-2] f := by

  have h1 : X ^ 2 * f = X * (X * f) := by ring
  rw [h1, iterD_X_mul k (X * f), iterD_X_mul k f, iterD_X_mul (k-1) f]
  match k with
  | 0 => simp; ring
  | 1 => simp; push_cast; simp only [C_add, C_1, C_mul, map_ofNat]; ring
  | (n+2) =>
      have e1 : n + 2 - 1 = n + 1 := rfl
      have e2 : n + 2 - 2 = n := rfl
      have e3 : n + 1 - 1 = n := rfl
      rw [e1, e2, e3]
      push_cast
      simp only [C_sub, C_add, C_mul, C_1, map_ofNat]
      ring
