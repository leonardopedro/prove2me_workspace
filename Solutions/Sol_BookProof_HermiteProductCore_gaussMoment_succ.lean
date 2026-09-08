-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.gaussMoment_succ
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) : gaussMoment (k + 1) = (k : ℝ) * gaussMoment (k - 1) := by

  have h := gint_ibp ((Polynomial.X : Polynomial ℝ) ^ k) 1
  rw [Polynomial.derivative_X_pow, mul_one, Polynomial.derivative_one, sub_zero, mul_one] at h
  rw [gint_C_mul] at h
  rw [gaussMoment, gaussMoment, h, pow_succ]
