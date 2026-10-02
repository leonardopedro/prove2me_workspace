-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.gaussWD_eq_prod
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

theorem BookProof.HermiteProductCore.gaussWD_eq_prod (x : Vd d) : gaussWD x = ∏ i, Real.exp (-(x i) ^ 2 / 2) := by sorry
