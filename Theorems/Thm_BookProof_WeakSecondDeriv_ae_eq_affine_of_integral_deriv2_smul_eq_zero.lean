-- Generated from ChapterWeakSecondDerivative.lean — theorem BookProof.WeakSecondDeriv.ae_eq_affine_of_integral_deriv2_smul_eq_zero
import Mathlib
import Definitions.Def_ChapterWeakSecondDerivative
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.WeakSecondDeriv



open MeasureTheory Filter Topology intervalIntegral Set

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [NormedSpace ℝ F] [CompleteSpace F]

theorem BookProof.WeakSecondDeriv.ae_eq_affine_of_integral_deriv2_smul_eq_zero {r : ℝ → F}
    (hr : LocallyIntegrable r volume)
    (h : ∀ g : ℝ → ℝ, IsTestFun g → ∫ x, deriv (deriv g) x • r x = 0) :
    ∃ a b : F, r =ᵐ[volume] fun x => x • a + b := by sorry
