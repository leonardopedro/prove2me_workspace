-- Generated from ChapterWeakSecondDerivative.lean — theorem BookProof.WeakSecondDeriv.ae_eq_const_of_integral_deriv_smul_eq_zero
import Mathlib
import Definitions.Def_ChapterWeakSecondDerivative
open BookProof.WeakSecondDeriv

variable {F : Type*} [NormedAddCommGroup F] [NormedSpace ℝ F] [CompleteSpace F]



open MeasureTheory Filter Topology intervalIntegral Set

noncomputable section

theorem BookProof.WeakSecondDeriv.ae_eq_const_of_integral_deriv_smul_eq_zero {r : ℝ → F}
    (hr : LocallyIntegrable r volume)
    (h : ∀ g : ℝ → ℝ, IsTestFun g → ∫ x, deriv g x • r x = 0) :
    ∃ c : F, r =ᵐ[volume] fun _ => c := by sorry
