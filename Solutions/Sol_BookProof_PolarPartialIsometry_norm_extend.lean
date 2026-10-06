-- Generated from ChapterPolarPartialIsometry.lean — solution of BookProof.PolarPartialIsometry.norm_extend
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
import Theorems.Thm_BookProof_PolarPartialIsometry_norm_inclL
import Theorems.Thm_BookProof_PolarPartialIsometry_isUniformInducing_inclL
import Theorems.Thm_BookProof_PolarPartialIsometry_denseRange_inclL
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
theorem solution (w : initSpace P) :
    ‖(preIsomL P Q h).extend (inclL P) w‖ = ‖w‖ := by

  refine (denseRange_inclL P).induction_on w ?_ ?_
  · exact isClosed_eq (by fun_prop) (by fun_prop)
  · intro z
    rw [ContinuousLinearMap.extend_eq _ (denseRange_inclL P) (isUniformInducing_inclL P),
      preIsomL_apply, norm_preIsom, norm_inclL]
    rfl
