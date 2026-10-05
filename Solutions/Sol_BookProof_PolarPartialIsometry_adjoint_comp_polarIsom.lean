-- Generated from ChapterPolarPartialIsometry.lean — solution of BookProof.PolarPartialIsometry.adjoint_comp_polarIsom
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
import Theorems.Thm_BookProof_PolarPartialIsometry_inner_polarIsom
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
theorem solution :
    (ContinuousLinearMap.adjoint (polarIsom P Q h)).comp (polarIsom P Q h)
      = (initSpace P).starProjection := by

  refine ContinuousLinearMap.ext fun w => ?_
  refine ext_inner_left ℂ fun z => ?_
  have hidem : (initSpace P).starProjection ((initSpace P).starProjection w)
      = (initSpace P).starProjection w := Submodule.starProjection_eq_self_iff.2 (by simp)
  rw [ContinuousLinearMap.comp_apply, ContinuousLinearMap.adjoint_inner_right,
    inner_polarIsom P Q h, Submodule.inner_starProjection_left_eq_right, hidem]
