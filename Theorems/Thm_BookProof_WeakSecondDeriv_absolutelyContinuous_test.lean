-- Generated from ChapterWeakSecondDerivative.lean — theorem BookProof.WeakSecondDeriv.absolutelyContinuous_test
import Mathlib
import Definitions.Def_ChapterWeakSecondDerivative
open BookProof.WeakSecondDeriv



open MeasureTheory Filter Topology intervalIntegral Set

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [NormedSpace ℝ F] [CompleteSpace F]

theorem BookProof.WeakSecondDeriv.absolutelyContinuous_test {g : ℝ → ℝ} (hg : IsTestFun g) (a b : ℝ) :
    AbsolutelyContinuousOnInterval g a b := by sorry
