-- Generated from ChapterLegendrePolynomial.lean — theorem BookProof.ChapterLegendrePolynomial.iterD_X_mul_succ
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
open BookProof.ChapterLegendrePolynomial



open Polynomial

theorem BookProof.ChapterLegendrePolynomial.iterD_X_mul_succ (k : ℕ) (f : ℝ[X]) :
    derivative^[k+1] (X * f) = X * derivative^[k+1] f + C ((k : ℝ) + 1) * derivative^[k] f := by sorry
