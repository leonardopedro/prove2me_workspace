-- Generated from ChapterLegendrePolynomial.lean — solution of BookProof.ChapterLegendrePolynomial.coeff_iterD_two
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
open BookProof.ChapterLegendrePolynomial




open Polynomial

set_option maxHeartbeats 1000000 in
theorem solution (Y : ℝ[X]) (j : ℕ) :
    (derivative^[2] Y).coeff j = (((j : ℝ) + 2) * ((j : ℝ) + 1)) * Y.coeff (j + 2) := by

  rw [coeff_iterate_derivative]
  have h : (j + 2).descFactorial 2 = (j + 2) * (j + 1) := by
    simp [Nat.descFactorial]; ring
  rw [h]
  push_cast
  ring
