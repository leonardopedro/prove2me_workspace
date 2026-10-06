-- Generated from ChapterLegendrePolynomial.lean — theorem BookProof.ChapterLegendrePolynomial.legendre_deriv_coeff_top_ne_zero
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
open BookProof.ChapterLegendrePolynomial



open Polynomial

theorem BookProof.ChapterLegendrePolynomial.legendre_deriv_coeff_top_ne_zero (l μ : ℕ) (h : μ ≤ l) :
    (derivative^[μ] (legendre l)).coeff (l - μ) ≠ 0 := by sorry
