-- Generated from ChapterFriedrichsExtension.lean — theorem BookProof.FriedrichsExtension.unbounded_friedrichs_example
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
open BookProof.FriedrichsExtension














open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]































variable [CompleteSpace F]











variable [CompleteSpace F]
















open FormDom

variable [CompleteSpace F]










open Filter Topology

theorem BookProof.FriedrichsExtension.unbounded_friedrichs_example :
    (∃ (Dom : Submodule ℂ (ℓ²(ℕ, ℂ))) (A : Dom →ₗ[ℂ] ℓ²(ℕ, ℂ)),
        IsPositiveSelfAdjointExtension ell2ExampleMatrix A) ∧
      ∀ C : ℝ, ∃ x : finiteModeDomain ell2Basis,
        C * ‖(x : ℓ²(ℕ, ℂ))‖ < ‖ell2ExampleMatrix x‖ := by sorry
