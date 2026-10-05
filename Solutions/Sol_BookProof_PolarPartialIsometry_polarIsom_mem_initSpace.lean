-- Generated from ChapterPolarPartialIsometry.lean — solution of BookProof.PolarPartialIsometry.polarIsom_mem_initSpace
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
import Theorems.Thm_BookProof_PolarPartialIsometry_preIsom_apply
import Theorems.Thm_BookProof_PolarPartialIsometry_isUniformInducing_inclL
import Theorems.Thm_BookProof_PolarPartialIsometry_denseRange_inclL
import Theorems.Thm_BookProof_PolarPartialIsometry_polarIsom_apply
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
theorem solution (z : F) : polarIsom P Q h z ∈ initSpace Q := by

  rw [polarIsom_apply]
  refine (denseRange_inclL P).induction_on ((initSpace P).orthogonalProjection z) ?_ ?_
  · exact IsClosed.preimage (map_continuous _) (isClosed_initSpace Q)
  · intro y
    obtain ⟨x, hx⟩ := y.2
    have hy : y = ⟨P x, LinearMap.mem_range_self P x⟩ := Subtype.ext hx.symm
    rw [ContinuousLinearMap.extend_eq _ (denseRange_inclL P) (isUniformInducing_inclL P), hy,
      preIsomL_apply, preIsom_apply]
    exact range_le_initSpace Q (LinearMap.mem_range_self Q x)
