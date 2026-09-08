-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.integral_prod_coord
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore







open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

theorem BookProof.HermiteProductCore.integral_prod_coord (f : Fin d → ℝ → ℂ) :
    ∫ x : Vd d, ∏ i, f i (x i) = ∏ i, ∫ t : ℝ, f i t := by sorry
