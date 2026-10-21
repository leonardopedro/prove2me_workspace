-- Generated from ChapterPolarPartialIsometry.lean — solution of BookProof.PolarPartialIsometry.adjoint_polarIsom_apply
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
import Theorems.Thm_BookProof_PolarPartialIsometry_polarIsom_apply_range
import Theorems.Thm_BookProof_PolarPartialIsometry_adjoint_comp_polarIsom
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
theorem solution (x : Dom) :
    ContinuousLinearMap.adjoint (polarIsom P Q h) (Q x) = P x := by

  have h1 : Q x = polarIsom P Q h (P x) := (polarIsom_apply_range P Q h x).symm
  have h2 := congrArg (fun T : F →L[ℂ] F => T (P x)) (adjoint_comp_polarIsom P Q h)
  simp only [ContinuousLinearMap.comp_apply] at h2
  rw [h1, h2]
  exact Submodule.starProjection_eq_self_iff.2 (range_le_initSpace P (LinearMap.mem_range_self P x))
