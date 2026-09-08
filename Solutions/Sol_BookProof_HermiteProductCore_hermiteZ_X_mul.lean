-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.hermiteZ_X_mul
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_derivative_hermiteZ
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    (Polynomial.X : Polynomial ℤ) * Polynomial.hermite n
      = Polynomial.hermite (n + 1) + (n : ℤ) • Polynomial.hermite (n - 1) := by

  cases n with
  | zero => simp [Polynomial.hermite_succ, Polynomial.hermite_zero]
  | succ m =>
    rw [Polynomial.hermite_succ (m + 1), derivative_hermiteZ m]
    simp [Polynomial.smul_eq_C_mul]
