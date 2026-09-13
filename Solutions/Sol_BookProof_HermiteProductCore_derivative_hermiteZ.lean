-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.derivative_hermiteZ
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    Polynomial.derivative (Polynomial.hermite (n + 1))
      = Polynomial.C ((n : ℤ) + 1) * Polynomial.hermite n := by

  induction n with
  | zero => simp [Polynomial.hermite_zero]
  | succ n ih =>
    have key : Polynomial.derivative (Polynomial.hermite (n + 1 + 1))
        = Polynomial.hermite (n + 1) + Polynomial.C ((n : ℤ) + 1)
          * (Polynomial.X * Polynomial.hermite n
              - Polynomial.derivative (Polynomial.hermite n)) := by
      rw [Polynomial.hermite_succ (n + 1), Polynomial.derivative_sub,
        Polynomial.derivative_mul, Polynomial.derivative_X, ih, Polynomial.derivative_C_mul]
      ring
    have hC : (Polynomial.C (((n : ℕ) + 1 : ℕ) + 1 : ℤ) : Polynomial ℤ)
        = Polynomial.C ((n : ℤ) + 1) + 1 := by
      push_cast
      rw [show ((n : ℤ) + 1 + 1) = ((n : ℤ) + 1) + 1 from rfl, Polynomial.C_add, Polynomial.C_1]
    rw [key, ← Polynomial.hermite_succ n, hC, add_mul, one_mul, add_comm]
