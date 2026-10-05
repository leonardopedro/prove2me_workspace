-- Generated from ChapterPolarPartialIsometry.lean — solution of BookProof.PolarPartialIsometry.isometry_inclL
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
import Theorems.Thm_BookProof_PolarPartialIsometry_norm_inclL
open BookProof.PolarPartialIsometry




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {Dom : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {Dom : Submodule ℂ F}
variable (P Q : Dom →ₗ[ℂ] F)
  (h : ∀ x y : Dom, (inner ℂ (P x) (P y) : ℂ) = inner ℂ (Q x) (Q y))

set_option maxHeartbeats 1000000 in
theorem solution : Isometry (inclL P) := AddMonoidHomClass.isometry_of_norm _ (norm_inclL P)
