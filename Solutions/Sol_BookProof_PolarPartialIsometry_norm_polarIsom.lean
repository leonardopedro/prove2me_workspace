-- Generated from ChapterPolarPartialIsometry.lean — solution of BookProof.PolarPartialIsometry.norm_polarIsom
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
import Theorems.Thm_BookProof_PolarPartialIsometry_norm_polarIsom_of_mem
import Theorems.Thm_BookProof_PolarPartialIsometry_polarIsom_eq_zero_of_mem_orthogonal
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
theorem solution (z : F) :
    ‖polarIsom P Q h z‖ = ‖(initSpace P).starProjection z‖ := by

  have hmem : (initSpace P).starProjection z ∈ initSpace P := by simp
  have hsplit : z - (initSpace P).starProjection z ∈ (initSpace P)ᗮ := by simp
  have h1 : polarIsom P Q h z = polarIsom P Q h ((initSpace P).starProjection z) := by
    have hz : z = (initSpace P).starProjection z + (z - (initSpace P).starProjection z) := by abel
    conv_lhs => rw [hz]
    rw [map_add, polarIsom_eq_zero_of_mem_orthogonal P Q h hsplit, add_zero]
  rw [h1, norm_polarIsom_of_mem P Q h hmem]
