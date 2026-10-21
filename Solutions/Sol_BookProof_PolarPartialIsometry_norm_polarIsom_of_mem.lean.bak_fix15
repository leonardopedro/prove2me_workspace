-- Generated from ChapterPolarPartialIsometry.lean — solution of BookProof.PolarPartialIsometry.norm_polarIsom_of_mem
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
import Theorems.Thm_BookProof_PolarPartialIsometry_polarIsom_apply_of_mem
import Theorems.Thm_BookProof_PolarPartialIsometry_norm_extend
open BookProof.PolarPartialIsometry




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {Dom : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {Dom : Submodule ℂ F}
variable (P Q : Dom →ₗ[ℂ] F)
  (h : ∀ x y : Dom, (inner ℂ (P x) (P y) : ℂ) = inner ℂ (Q x) (Q y))
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {z : F} (hz : z ∈ initSpace P) : ‖polarIsom P Q h z‖ = ‖z‖ := by

  rw [polarIsom_apply_of_mem P Q h hz, norm_extend]
  rfl
