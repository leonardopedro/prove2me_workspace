-- Generated from ChapterWeakSecondDerivative.lean — theorem BookProof.WeakSecondDeriv.exists_antideriv
import Mathlib
import Definitions.Def_ChapterWeakSecondDerivative
open BookProof.WeakSecondDeriv

variable {F : Type*} [NormedAddCommGroup F] [NormedSpace ℝ F] [CompleteSpace F]



open MeasureTheory Filter Topology intervalIntegral Set

noncomputable section

theorem BookProof.WeakSecondDeriv.exists_antideriv {g : ℝ → ℝ} (h : IsTestFun g) (h0 : ∫ x, g x = 0) :
    ∃ G : ℝ → ℝ, IsTestFun G ∧ deriv G = g := by sorry
