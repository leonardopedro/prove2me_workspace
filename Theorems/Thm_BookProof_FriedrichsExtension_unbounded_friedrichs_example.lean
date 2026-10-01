-- Generated from ChapterFriedrichsExtension.lean — theorem BookProof.FriedrichsExtension.unbounded_friedrichs_example
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
open BookProof.FriedrichsExtension

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable [CompleteSpace F]
variable [CompleteSpace F]
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin
open scoped InnerProductSpace ENNReal lp

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

tion is not vacuous: a genuinely unbounded operator -/

theorem BookProof.FriedrichsExtension.unbounded_friedrichs_example :
    (∃ (Dom : Submodule ℂ (ℓ²(ℕ, ℂ))) (A : Dom →ₗ[ℂ] ℓ²(ℕ, ℂ)),
        IsPositiveSelfAdjointExtension ell2ExampleMatrix A) ∧
      ∀ C : ℝ, ∃ x : finiteModeDomain ell2Basis,
        C * := by sorry
