-- Generated from ChapterPolarPartialIsometry.lean — solution of BookProof.PolarPartialIsometry.inner_polarIsom
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
import Theorems.Thm_BookProof_PolarPartialIsometry_norm_polarIsom
import Theorems.Thm_BookProof_PolarPartialIsometry_inner_eq_of_norm_eq_clm
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
theorem solution (z w : F) :
    (inner ℂ (polarIsom P Q h z) (polarIsom P Q h w) : ℂ)
      = inner ℂ ((initSpace P).starProjection z) ((initSpace P).starProjection w) := inner_eq_of_norm_eq_clm _ _ (norm_polarIsom P Q h) z w
