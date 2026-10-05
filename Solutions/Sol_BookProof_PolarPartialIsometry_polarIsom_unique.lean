-- Generated from ChapterPolarPartialIsometry.lean — solution of BookProof.PolarPartialIsometry.polarIsom_unique
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
import Theorems.Thm_BookProof_PolarPartialIsometry_polarIsom_apply_range
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
theorem solution (V : F →L[ℂ] F) (hV : ∀ x : Dom, V (P x) = Q x)
    (hV0 : ∀ z ∈ (initSpace P)ᗮ, V z = 0) : V = polarIsom P Q h := by

  have hagree : ∀ y ∈ initSpace P, V y = polarIsom P Q h y := by
    have hclosed : IsClosed {y : F | V y = polarIsom P Q h y} :=
      isClosed_eq V.continuous (polarIsom P Q h).continuous
    have hsub : ((LinearMap.range P : Submodule ℂ F) : Set F)
        ⊆ {y : F | V y = polarIsom P Q h y} := by
      rintro y ⟨x, rfl⟩
      simp only [Set.mem_setOf_eq]
      rw [hV x, polarIsom_apply_range]
    intro y hy
    have hy' : y ∈ closure ((LinearMap.range P : Submodule ℂ F) : Set F) := by
      have hy2 : y ∈ (LinearMap.range P).topologicalClosure := hy
      rwa [← SetLike.mem_coe, Submodule.topologicalClosure_coe] at hy2
    exact hclosed.closure_subset_iff.2 hsub hy'
  refine ContinuousLinearMap.ext fun z => ?_
  have hz : z = (initSpace P).starProjection z + (z - (initSpace P).starProjection z) := by abel
  have hmem : (initSpace P).starProjection z ∈ initSpace P := by simp
  have hperp : z - (initSpace P).starProjection z ∈ (initSpace P)ᗮ := by simp
  conv_lhs => rw [hz]
  conv_rhs => rw [hz]
  rw [map_add, map_add, hV0 _ hperp, polarIsom_eq_zero_of_mem_orthogonal P Q h hperp,
    hagree _ hmem]
