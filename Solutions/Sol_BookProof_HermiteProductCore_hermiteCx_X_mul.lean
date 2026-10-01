-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.hermiteCx_X_mul
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_hermiteZ_X_mul
open BookProof.HermiteProductCore




open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
omial.X : Polynomial ℂ) * hermiteCx n
      = hermiteCx (n + 1) + (n : ℂ) • hermiteCx (n - 1) := by
  have h := congrArg (Pol :=
  ynomial.map (Int.castRingHom ℂ)) (hermiteZ_X_mul n)
    simpa [hermi
