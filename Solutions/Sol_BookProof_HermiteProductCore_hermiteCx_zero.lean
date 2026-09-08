-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.hermiteCx_zero
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution : hermiteCx 0 = 1 := by

  simp [hermiteCx, Polynomial.hermite_zero]
