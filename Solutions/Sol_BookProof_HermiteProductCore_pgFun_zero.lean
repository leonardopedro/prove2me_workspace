-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.pgFun_zero
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
theorem solution : pgFun (0 : MvPolynomial (Fin d) ℂ) = 0 := by

  funext x; simp [pgFun]
