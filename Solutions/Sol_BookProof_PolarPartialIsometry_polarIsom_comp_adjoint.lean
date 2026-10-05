-- Generated from ChapterPolarPartialIsometry.lean — solution of BookProof.PolarPartialIsometry.polarIsom_comp_adjoint
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
import Theorems.Thm_BookProof_PolarPartialIsometry_polarIsom_apply_range
import Theorems.Thm_BookProof_PolarPartialIsometry_adjoint_comp_polarIsom
import Theorems.Thm_BookProof_PolarPartialIsometry_polarIsom_mem_initSpace
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
    (polarIsom P Q h).comp (ContinuousLinearMap.adjoint (polarIsom P Q h))
      = (initSpace Q).starProjection := by

  refine ContinuousLinearMap.ext fun z => ?_
  refine (Submodule.eq_starProjection_of_mem_of_inner_eq_zero
    (polarIsom_mem_initSpace P Q h _) ?_).symm
  intro w hw
  have hzero : ∀ x : Dom,
      (inner ℂ (z - polarIsom P Q h (ContinuousLinearMap.adjoint (polarIsom P Q h) z))
        (Q x) : ℂ) = 0 := by
    intro x
    have hQ : Q x = polarIsom P Q h (P x) := (polarIsom_apply_range P Q h x).symm
    have hPx : (initSpace P).starProjection (P x) = P x :=
      Submodule.starProjection_eq_self_iff.2 (range_le_initSpace P (LinearMap.mem_range_self P x))
    have hUU : (inner ℂ (polarIsom P Q h (ContinuousLinearMap.adjoint (polarIsom P Q h) z))
        (polarIsom P Q h (P x)) : ℂ)
        = inner ℂ (ContinuousLinearMap.adjoint (polarIsom P Q h) z) (P x) := by
      have h2 := congrArg (fun T : F →L[ℂ] F => T (P x)) (adjoint_comp_polarIsom P Q h)
      simp only [ContinuousLinearMap.comp_apply] at h2
      rw [← ContinuousLinearMap.adjoint_inner_right, h2, hPx]
    rw [inner_sub_left, hQ, hUU, ContinuousLinearMap.adjoint_inner_left, sub_self]
  have hclosed : IsClosed {y : F | (inner ℂ
      (z - polarIsom P Q h (ContinuousLinearMap.adjoint (polarIsom P Q h) z)) y : ℂ) = 0} :=
    isClosed_eq (continuous_const.inner continuous_id) continuous_const
  have hsub : ((LinearMap.range Q : Submodule ℂ F) : Set F)
      ⊆ {y : F | (inner ℂ
        (z - polarIsom P Q h (ContinuousLinearMap.adjoint (polarIsom P Q h) z)) y : ℂ) = 0} := by
    rintro y ⟨x, rfl⟩
    exact hzero x
  have hw' : w ∈ closure ((LinearMap.range Q : Submodule ℂ F) : Set F) := by
    have hw2 : w ∈ (LinearMap.range Q).topologicalClosure := hw
    rwa [← SetLike.mem_coe, Submodule.topologicalClosure_coe] at hw2
  exact hclosed.closure_subset_iff.2 hsub hw'
