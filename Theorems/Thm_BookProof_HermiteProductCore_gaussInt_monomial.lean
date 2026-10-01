-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.gaussInt_monomial
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

Moment (k + 1) = (k : ℝ) * gaussMoment (k - 1) := by
  have h := gint_ibp ((Polynomial.X : Polynomial ℝ) ^ k) 1
  rw [Polynomial.derivative_X_pow, mul_one, Polynomial.derivative_one, sub_zero, mul_one] at h
  r := by sorry
