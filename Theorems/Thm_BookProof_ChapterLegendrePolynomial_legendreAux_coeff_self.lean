-- Generated from ChapterLegendrePolynomial.lean — theorem BookProof.ChapterLegendrePolynomial.legendreAux_coeff_self
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
open BookProof.ChapterLegendrePolynomial



open Polynomial

theorem BookProof.ChapterLegendrePolynomial.legendreAux_coeff_self (l : ℕ) :
    (legendreAux l).coeff l = ((2 * l).descFactorial l : ℝ) := by sorry
