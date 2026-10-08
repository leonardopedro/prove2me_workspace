-- Generated from ChapterFriedrichsCanonical.lean — theorem BookProof.FriedrichsCanonical.unbounded_friedrichs_canonical_example
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFriedrichsExtension
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
import Definitions.Def_ChapterHashimotoShiftInvert
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.YangMillsFriedrichs
open BookProof.FriedrichsCanonical



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {D : Submodule ℂ F}

theorem BookProof.FriedrichsCanonical.unbounded_friedrichs_canonical_example :
    IsPositiveSelfAdjointExtension ell2ExampleMatrix
        (friedrichsOp ell2ExamplePosSymOp (finiteModeDomain_dense ell2Basis)) ∧
      (∀ (Dom' : Submodule ℂ (ℓ²(ℕ, ℂ))) (A' : Dom' →ₗ[ℂ] ℓ²(ℕ, ℂ)),
          IsPositiveSelfAdjointExtension ell2ExampleMatrix A' →
          Dom' ≤ formDomain ell2ExamplePosSymOp →
          Dom' = friedrichsDomain ell2ExamplePosSymOp) ∧
      ∀ C : ℝ, ∃ x : finiteModeDomain ell2Basis,
        C * ‖(x : ℓ²(ℕ, ℂ))‖ < ‖ell2ExampleMatrix x‖ := by sorry
