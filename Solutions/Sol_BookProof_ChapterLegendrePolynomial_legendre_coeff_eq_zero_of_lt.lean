-- Generated from ChapterLegendrePolynomial.lean — solution of BookProof.ChapterLegendrePolynomial.legendre_coeff_eq_zero_of_lt
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
import Theorems.Thm_BookProof_ChapterLegendrePolynomial_legendre_natDegree_le
open BookProof.ChapterLegendrePolynomial




open Polynomial

set_option maxHeartbeats 1000000 in
theorem solution (l k : ℕ) (h : l < k) : (legendre l).coeff k = 0 := coeff_eq_zero_of_natDegree_lt (lt_of_le_of_lt (legendre_natDegree_le l) h)
