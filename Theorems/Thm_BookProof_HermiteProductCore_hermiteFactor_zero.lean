-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.hermiteFactor_zero
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

theorem BookProof.HermiteProductCore.hermiteFactor_zero (i : Fin d) : hermiteFactor i 0 = 1 := by sorry
