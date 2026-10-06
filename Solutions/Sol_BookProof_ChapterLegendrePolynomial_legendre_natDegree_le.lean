-- Generated from ChapterLegendrePolynomial.lean — solution of BookProof.ChapterLegendrePolynomial.legendre_natDegree_le
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
import Theorems.Thm_BookProof_ChapterLegendrePolynomial_legendreAux_natDegree_le
open BookProof.ChapterLegendrePolynomial




open Polynomial

set_option maxHeartbeats 1000000 in
theorem solution (l : ℕ) : (legendre l).natDegree ≤ l := le_trans (natDegree_C_mul_le _ _) (legendreAux_natDegree_le l)
