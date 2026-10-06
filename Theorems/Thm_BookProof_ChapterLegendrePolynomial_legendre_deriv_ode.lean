-- Generated from ChapterLegendrePolynomial.lean — theorem BookProof.ChapterLegendrePolynomial.legendre_deriv_ode
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
open BookProof.ChapterLegendrePolynomial



open Polynomial

theorem BookProof.ChapterLegendrePolynomial.legendre_deriv_ode (l μ : ℕ) :
    (X ^ 2 - 1) * derivative^[2] (derivative^[μ] (legendre l))
      + C (2 * (μ : ℝ) + 2) * X * derivative (derivative^[μ] (legendre l))
      + C ((μ : ℝ) * ((μ : ℝ) + 1) - (l : ℝ) * ((l : ℝ) + 1)) * derivative^[μ] (legendre l)
      = 0 := by sorry
