-- Generated from ChapterLegendrePolynomial.lean — theorem BookProof.ChapterLegendrePolynomial.iterD_X_mul
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
open BookProof.ChapterLegendrePolynomial



open Polynomial

theorem BookProof.ChapterLegendrePolynomial.iterD_X_mul (k : ℕ) (f : ℝ[X]) :
    derivative^[k] (X * f) = X * derivative^[k] f + C (k : ℝ) * derivative^[k-1] f := by sorry
