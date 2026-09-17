-- Generated from ChapterFriedrichsExtension.lean — theorem BookProof.FriedrichsExtension.friedrichs_hypothesis_holds
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
open BookProof.FriedrichsExtension



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.FriedrichsExtension.friedrichs_hypothesis_holds :
    ∀ (D' : Submodule ℂ F) (H' : D' →ₗ[ℂ] F), Dense (D' : Set F) →
      SymmetricOn D' H' → (∀ x : D', 0 ≤ quadForm H' x) →
      ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsPositiveSelfAdjointExtension H' A := by sorry
