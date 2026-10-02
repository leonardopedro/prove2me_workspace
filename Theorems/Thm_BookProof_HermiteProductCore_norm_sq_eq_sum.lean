-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.norm_sq_eq_sum
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

theorem BookProof.HermiteProductCore.norm_sq_eq_sum (x : Vd d) : ‖x‖ ^ 2 = ∑ i, (x i) ^ 2 := by sorry
