-- Generated from ChapterSchurRepresentation.lean — solution of BookProof.ChapterSchurRepresentation.imprimitivitySystem_isNormal
import Mathlib
import Definitions.Def_ChapterSchurRepresentation
import Theorems.Thm_BookProof_ChapterSchurRepresentation_adjoint_uCLM
open BookProof.ChapterSchurRepresentation



open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System BookProof.ChapterSchurIrreducible

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {G : Type*} [Group G] {X : Type*}
    (U : G →* (V ≃ₗᵢ[ℂ] V)) (pvm : Set X → (V →L[ℂ] V))
    (hpvm : ∀ A : Set X, IsSelfAdjoint (pvm A)) :
    (imprimitivitySystem U pvm).IsNormal := by

  rintro m (⟨g, rfl⟩ | ⟨A, rfl⟩)
  · refine Or.inl ⟨g⁻¹, ?_⟩
    rw [adjoint_uCLM]
    congr 1
    rw [map_inv]
    rfl
  · refine Or.inr ⟨A, ?_⟩
    have := hpvm A
    rw [ContinuousLinearMap.isSelfAdjoint_iff'] at this
    exact this
