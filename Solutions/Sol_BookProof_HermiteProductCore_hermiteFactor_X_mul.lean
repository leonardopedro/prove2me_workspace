-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.hermiteFactor_X_mul
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_hermiteCx_X_mul
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (n : ℕ) :
    X i * hermiteFactor i n = hermiteFactor i (n + 1) + (n : ℂ) • hermiteFactor i (n - 1) := by

  have h := congrArg (Polynomial.aeval (X i : MvPolynomial (Fin d) ℂ)) (hermiteCx_X_mul n)
  simpa [hermiteFactor, map_add, map_smul] using h
