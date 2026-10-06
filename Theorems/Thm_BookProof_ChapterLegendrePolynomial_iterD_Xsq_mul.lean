-- Generated from ChapterLegendrePolynomial.lean — theorem BookProof.ChapterLegendrePolynomial.iterD_Xsq_mul
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
open BookProof.ChapterLegendrePolynomial



open Polynomial

theorem BookProof.ChapterLegendrePolynomial.iterD_Xsq_mul (k : ℕ) (f : ℝ[X]) :
    derivative^[k] (X ^ 2 * f)
      = X ^ 2 * derivative^[k] f + C (2 * (k : ℝ)) * X * derivative^[k-1] f
        + C ((k : ℝ) * ((k : ℝ) - 1)) * derivative^[k-2] f := by sorry
