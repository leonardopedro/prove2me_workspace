-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.hermiteZ_X_mul
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

 : ℕ) + 1 : ℤ) : Polynomial ℤ)
        = Polynomial.C ((n : ℤ) + 1) + 1 := by
      push_cast
      rw [show ((n : ℤ) + 1 + 1) = ((n : ℤ) + 1) + 1 from rfl, Polynomial.C_add, Polynomial.C_1]
    rw [key, ← Polynomial.hermite_succ n, hC, add_mul, o := by sorry
