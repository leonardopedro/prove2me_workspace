-- Generated from ChapterHashimotoComplexShifts.lean — theorem BookProof.HashimotoShiftInvert.isShiftInvertC_of_rightInverse
import Mathlib
import Definitions.Def_ChapterHashimotoComplexShifts
open BookProof.HashimotoShiftInvert


















open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}

theorem BookProof.HashimotoShiftInvert.isShiftInvertC_of_rightInverse {A : Dom →ₗ[ℂ] F} {γ : ℂ} {X : F →L[ℂ] F}
    (hsym : SymmetricOn Dom A) (hγ : γ.im ≠ 0)
    (hright : ∀ u : F, ∃ h : X u ∈ Dom, cshiftMap A γ ⟨X u, h⟩ = u) :
    IsShiftInvertC A γ X := by sorry
