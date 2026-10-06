-- Generated from ChapterLegendrePolynomial.lean — theorem BookProof.ChapterLegendrePolynomial.legendre_deriv_coeff_eq_zero
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
open BookProof.ChapterLegendrePolynomial



open Polynomial

theorem BookProof.ChapterLegendrePolynomial.legendre_deriv_coeff_eq_zero (l μ k : ℕ) (h : l < k + μ) :
    (derivative^[μ] (legendre l)).coeff k = 0 := by sorry
