-- Generated from ChapterLegendrePolynomial.lean — solution of BookProof.ChapterLegendrePolynomial.natDegree_Xsq_sub_one
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
open BookProof.ChapterLegendrePolynomial




open Polynomial

set_option maxHeartbeats 1000000 in
theorem solution : (X ^ 2 - 1 : ℝ[X]).natDegree = 2 := by

  have h : (X ^ 2 - 1 : ℝ[X]) = X ^ 2 - C 1 := by simp
  rw [h, natDegree_X_pow_sub_C]
