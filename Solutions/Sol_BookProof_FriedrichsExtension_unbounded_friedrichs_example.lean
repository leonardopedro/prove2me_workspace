-- Generated from ChapterFriedrichsExtension.lean — solution of BookProof.FriedrichsExtension.unbounded_friedrichs_example
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Theorems.Thm_BookProof_FriedrichsExtension_friedrichs_extension_exists
import Theorems.Thm_BookProof_HermiteGalerkin_finiteModeDomain_dense
open BookProof.FriedrichsExtension




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution :
    (∃ (Dom : Submodule ℂ (ℓ²(ℕ, ℂ))) (A : Dom →ₗ[ℂ] ℓ²(ℕ, ℂ)),
        IsPositiveSelfAdjointExtension ell2ExampleMatrix A) ∧
      ∀ C : ℝ, ∃ x : finiteModeDomain ell2Basis,
        C * ‖(x : ℓ²(ℕ, ℂ))‖ < ‖ell2ExampleMatrix x‖ := by

  obtain ⟨-, hsym, hpos, -⟩ := ell2Example_isPositiveSelfAdjointExtension
  refine ⟨friedrichs_extension_exists
    ⟨finiteModeDomain ell2Basis, ell2ExampleMatrix, ?_, ?_⟩ (finiteModeDomain_dense ell2Basis),
    ell2ExampleMatrix_unbounded⟩
  · intro x y
    exact hsym ⟨(x : ℓ²(ℕ, ℂ)), finiteModeDomain_le_range x.2⟩
      ⟨(y : ℓ²(ℕ, ℂ)), finiteModeDomain_le_range y.2⟩
  · intro x
    exact hpos ⟨(x : ℓ²(ℕ, ℂ)), finiteModeDomain_le_range x.2⟩
