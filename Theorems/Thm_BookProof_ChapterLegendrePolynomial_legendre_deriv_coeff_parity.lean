-- Generated from ChapterLegendrePolynomial.lean — theorem BookProof.ChapterLegendrePolynomial.legendre_deriv_coeff_parity
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
open BookProof.ChapterLegendrePolynomial



open Polynomial

theorem BookProof.ChapterLegendrePolynomial.legendre_deriv_coeff_parity (l μ : ℕ) (h : μ ≤ l) (j : ℕ)
    (hpar : j % 2 ≠ (l - μ) % 2) : (derivative^[μ] (legendre l)).coeff j = 0 := by sorry
