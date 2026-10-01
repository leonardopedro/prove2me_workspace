-- Generated from ChapterWeakSecondDerivative.lean — theorem BookProof.WeakSecondDeriv.integral_eq_neg_integral_coord_mul_deriv
import Mathlib
import Definitions.Def_ChapterWeakSecondDerivative
open BookProof.WeakSecondDeriv

variable {F : Type*} [NormedAddCommGroup F] [NormedSpace ℝ F] [CompleteSpace F]



open MeasureTheory Filter Topology intervalIntegral Set

noncomputable section

theorem BookProof.WeakSecondDeriv.integral_eq_neg_integral_coord_mul_deriv {g : ℝ → ℝ} (h : IsTestFun g) :
    ∫ x, g x = -∫ x, x * deriv g x := by sorry
