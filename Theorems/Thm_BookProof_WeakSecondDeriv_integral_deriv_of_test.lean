-- Generated from ChapterWeakSecondDerivative.lean — theorem BookProof.WeakSecondDeriv.integral_deriv_of_test
import Mathlib
import Definitions.Def_ChapterWeakSecondDerivative
open BookProof.WeakSecondDeriv

variable {F : Type*} [NormedAddCommGroup F] [NormedSpace ℝ F] [CompleteSpace F]



open MeasureTheory Filter Topology intervalIntegral Set

noncomputable section

theorem BookProof.WeakSecondDeriv.integral_deriv_of_test {g : ℝ → ℝ} (h : IsTestFun g) : ∫ x, deriv g x = 0 := by sorry
