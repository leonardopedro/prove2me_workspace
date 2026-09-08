-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.hermiteFactor_zero
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_hermiteCx_zero
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) : hermiteFactor i 0 = 1 := by

  simp [hermiteFactor, hermiteCx_zero]
