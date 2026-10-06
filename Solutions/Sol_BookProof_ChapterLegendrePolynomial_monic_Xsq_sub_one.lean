-- Generated from ChapterLegendrePolynomial.lean — solution of BookProof.ChapterLegendrePolynomial.monic_Xsq_sub_one
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
open BookProof.ChapterLegendrePolynomial




open Polynomial

set_option maxHeartbeats 1000000 in
theorem solution : (X ^ 2 - 1 : ℝ[X]).Monic := by

  have h : (X ^ 2 - 1 : ℝ[X]) = X ^ 2 - C 1 := by simp
  rw [h]
  exact monic_X_pow_sub_C 1 (by norm_num)
