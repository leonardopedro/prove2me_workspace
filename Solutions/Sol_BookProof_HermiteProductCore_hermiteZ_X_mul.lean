-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.hermiteZ_X_mul
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_derivative_hermiteZ
open BookProof.HermiteProductCore




open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
 : ℕ) + 1 : ℤ) : Polynomial ℤ)
        = Polynomial.C ((n : ℤ) + 1) + 1 := by
      push_cast
      rw [show ((n : ℤ) + 1 + 1) = ((n : ℤ) + 1) + 1 from rfl, Polynomial.C_add, Polynomial.C_1]
    rw [key, ← Polynomial.hermite_succ n, hC, add_mul, o :=
  ne_mul, add_comm]
  
  /-- The **three-term recurrence** `X · He_n = He_{n+1} + n · He_{n-1}`, over `ℤ`. -/
  theorem hermiteZ_X_mul (n : ℕ) :
      (Polynomial.X : Polynomial ℤ) * Polynomial.hermite n
