-- Generated from ChapterWeakSecondDerivative.lean — theorem BookProof.WeakSecondDeriv.IsTestFun.sub
import Mathlib
import Definitions.Def_ChapterWeakSecondDerivative
open BookProof.WeakSecondDeriv
open BookProof.WeakSecondDeriv.IsTestFun

variable {F : Type*} [NormedAddCommGroup F] [NormedSpace ℝ F] [CompleteSpace F]



open MeasureTheory Filter Topology intervalIntegral Set

noncomputable section

theorem BookProof.WeakSecondDeriv.IsTestFun.sub {f g : ℝ → ℝ} (h1 : IsTestFun f) (h2 : IsTestFun g) :
    IsTestFun (fun x => f x - g x) := by sorry
