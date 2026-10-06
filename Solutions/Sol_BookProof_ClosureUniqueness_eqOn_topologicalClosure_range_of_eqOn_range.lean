-- Generated from ChapterClosureUniqueness.lean — solution of BookProof.ClosureUniqueness.eqOn_topologicalClosure_range_of_eqOn_range
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
open BookProof.ClosureUniqueness




open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (B : D →ₗ[ℂ] F) (U V : F →L[ℂ] F)
    (h : ∀ x : D, U (B x) = V (B x)) :
    ∀ z ∈ (LinearMap.range B).topologicalClosure, U z = V z := by

  intro z hz
  have hclosed : IsClosed {y : F | U y = V y} := isClosed_eq U.continuous V.continuous
  have hsub : ((LinearMap.range B : Submodule ℂ F) : Set F) ⊆ {y : F | U y = V y} := by
    rintro _ ⟨x, rfl⟩
    exact h x
  have := closure_minimal hsub hclosed
  exact this (by
    rw [← Submodule.topologicalClosure_coe]
    exact hz)
