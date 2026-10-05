-- Generated from ChapterPolarPartialIsometry.lean — solution of BookProof.PolarPartialIsometry.polarIsom_apply_range
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
import Theorems.Thm_BookProof_PolarPartialIsometry_preIsom_apply
import Theorems.Thm_BookProof_PolarPartialIsometry_isUniformInducing_inclL
import Theorems.Thm_BookProof_PolarPartialIsometry_denseRange_inclL
import Theorems.Thm_BookProof_PolarPartialIsometry_polarIsom_apply_of_mem
open BookProof.PolarPartialIsometry




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {Dom : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {Dom : Submodule ℂ F}
variable (P Q : Dom →ₗ[ℂ] F)
  (h : ∀ x y : Dom, (inner ℂ (P x) (P y) : ℂ) = inner ℂ (Q x) (Q y))
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (x : Dom) : polarIsom P Q h (P x) = Q x := by

  have hmem : P x ∈ initSpace P := range_le_initSpace P (LinearMap.mem_range_self P x)
  rw [polarIsom_apply_of_mem P Q h hmem]
  have hincl : inclL P ⟨P x, LinearMap.mem_range_self P x⟩ = ⟨P x, hmem⟩ := rfl
  rw [← hincl, ContinuousLinearMap.extend_eq _ (denseRange_inclL P) (isUniformInducing_inclL P),
    preIsomL_apply, preIsom_apply]
