-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.derivative_hermiteZ
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore




open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
product
Hermite core" is justified here: the products `∏ᵢ He_{αᵢ}(xᵢ)` of probabilists'
Hermite polynomials span the same space, because the three-term recurrence
`X · He_n = He_{n+1} + n · He_{n-1}` makes their span st :=
  able under multiplication
  by each coordinate. -/
  
  /-- The derivative of the probabilists' Hermite polynomial, over `ℤ`. -/
  theorem derivative_hermiteZ (n : ℕ) :
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
      have hC : (Polynomial.C (((n : ℕ) +
