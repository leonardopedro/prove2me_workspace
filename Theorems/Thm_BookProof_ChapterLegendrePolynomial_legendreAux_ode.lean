-- Generated from ChapterLegendrePolynomial.lean — theorem BookProof.ChapterLegendrePolynomial.legendreAux_ode
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
open BookProof.ChapterLegendrePolynomial



open Polynomial

theorem BookProof.ChapterLegendrePolynomial.legendreAux_ode (l : ℕ) :
    (X ^ 2 - 1) * derivative^[2] (legendreAux l) + C 2 * X * derivative (legendreAux l)
      - C ((l : ℝ) * ((l : ℝ) + 1)) * legendreAux l = 0 := by sorry
