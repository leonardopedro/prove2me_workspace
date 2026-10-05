-- Generated from ChapterFriedrichsCanonical.lean — solution of BookProof.FriedrichsCanonical.unbounded_friedrichs_canonical_example
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
import Theorems.Thm_BookProof_FriedrichsCanonical_friedrichsOp_isPositiveSelfAdjointExtension
import Theorems.Thm_BookProof_FriedrichsCanonical_friedrichs_unique_selfAdjoint
import Theorems.Thm_BookProof_HashimotoShiftInvert_ell2ExampleMatrix_unbounded
import Theorems.Thm_BookProof_HermiteGalerkin_finiteModeDomain_dense
open BookProof.FriedrichsCanonical




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution :
    IsPositiveSelfAdjointExtension ell2ExampleMatrix
        (friedrichsOp ell2ExamplePosSymOp (finiteModeDomain_dense ell2Basis)) ∧
      (∀ (Dom' : Submodule ℂ (ℓ²(ℕ, ℂ))) (A' : Dom' →ₗ[ℂ] ℓ²(ℕ, ℂ)),
          IsPositiveSelfAdjointExtension ell2ExampleMatrix A' →
          Dom' ≤ formDomain ell2ExamplePosSymOp →
          Dom' = friedrichsDomain ell2ExamplePosSymOp) ∧
      ∀ C : ℝ, ∃ x : finiteModeDomain ell2Basis,
        C * ‖(x : ℓ²(ℕ, ℂ))‖ < ‖ell2ExampleMatrix x‖ :=
  ⟨friedrichsOp_isPositiveSelfAdjointExtension ell2ExamplePosSymOp
        (finiteModeDomain_dense ell2Basis),
      fun _ A' hA' hform =>
        (friedrichs_unique_selfAdjoint ell2ExamplePosSymOp (finiteModeDomain_dense ell2Basis)
          A' hA' hform).1,
      ell2ExampleMatrix_unbounded⟩
