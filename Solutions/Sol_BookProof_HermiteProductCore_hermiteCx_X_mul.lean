-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.hermiteCx_X_mul
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_hermiteZ_X_mul
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    (Polynomial.X : Polynomial ℂ) * hermiteCx n
      = hermiteCx (n + 1) + (n : ℂ) • hermiteCx (n - 1) := by

  have h := congrArg (Polynomial.map (Int.castRingHom ℂ)) (hermiteZ_X_mul n)
  simpa [hermiteCx, Polynomial.smul_eq_C_mul, Polynomial.map_mul, Polynomial.map_add] using h
