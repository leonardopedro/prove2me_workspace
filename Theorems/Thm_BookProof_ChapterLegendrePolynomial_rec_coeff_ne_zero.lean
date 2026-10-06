-- Generated from ChapterLegendrePolynomial.lean — theorem BookProof.ChapterLegendrePolynomial.rec_coeff_ne_zero
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
open BookProof.ChapterLegendrePolynomial



open Polynomial

theorem BookProof.ChapterLegendrePolynomial.rec_coeff_ne_zero (l μ j : ℕ) (h : μ ≤ l) (hne : j ≠ l - μ) :
    ((j : ℝ) * ((j : ℝ) - 1) + (2 * (μ : ℝ) + 2) * j
      + ((μ : ℝ) * ((μ : ℝ) + 1) - (l : ℝ) * ((l : ℝ) + 1))) ≠ 0 := by sorry
