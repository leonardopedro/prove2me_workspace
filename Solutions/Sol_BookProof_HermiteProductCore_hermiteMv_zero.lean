-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.hermiteMv_zero
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_hermiteFactor_zero
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution : hermiteMv (0 : Fin d →₀ ℕ) = 1 := by

  simp [hermiteMv, hermiteFactor_zero]
