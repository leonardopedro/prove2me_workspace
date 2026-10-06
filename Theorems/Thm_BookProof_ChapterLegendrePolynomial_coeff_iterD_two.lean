-- Generated from ChapterLegendrePolynomial.lean — theorem BookProof.ChapterLegendrePolynomial.coeff_iterD_two
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
open BookProof.ChapterLegendrePolynomial



open Polynomial

theorem BookProof.ChapterLegendrePolynomial.coeff_iterD_two (Y : ℝ[X]) (j : ℕ) :
    (derivative^[2] Y).coeff j = (((j : ℝ) + 2) * ((j : ℝ) + 1)) * Y.coeff (j + 2) := by sorry
