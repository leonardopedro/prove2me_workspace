-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.hermiteMv_zero
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

theorem BookProof.HermiteProductCore.hermiteMv_zero : hermiteMv (0 : Fin d →₀ ℕ) = 1 := by sorry
