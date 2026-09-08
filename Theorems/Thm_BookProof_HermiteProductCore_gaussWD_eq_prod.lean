-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.gaussWD_eq_prod
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore







open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

theorem BookProof.HermiteProductCore.gaussWD_eq_prod (x : Vd d) : gaussWD x = ∏ i, Real.exp (-(x i) ^ 2 / 2) := by sorry
