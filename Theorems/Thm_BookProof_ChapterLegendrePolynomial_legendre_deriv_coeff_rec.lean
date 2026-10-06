-- Generated from ChapterLegendrePolynomial.lean — theorem BookProof.ChapterLegendrePolynomial.legendre_deriv_coeff_rec
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
open BookProof.ChapterLegendrePolynomial



open Polynomial

theorem BookProof.ChapterLegendrePolynomial.legendre_deriv_coeff_rec (l μ j : ℕ) :
    (((j : ℝ) + 2) * ((j : ℝ) + 1)) * (derivative^[μ] (legendre l)).coeff (j + 2)
      = ((j : ℝ) * ((j : ℝ) - 1) + (2 * (μ : ℝ) + 2) * j
          + ((μ : ℝ) * ((μ : ℝ) + 1) - (l : ℝ) * ((l : ℝ) + 1)))
        * (derivative^[μ] (legendre l)).coeff j := by sorry
