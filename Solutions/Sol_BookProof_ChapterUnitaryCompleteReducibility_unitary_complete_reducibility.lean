-- Generated from ChapterUnitaryCompleteReducibility.lean — solution of BookProof.ChapterUnitaryCompleteReducibility.unitary_complete_reducibility
import Mathlib
import Definitions.Def_ChapterUnitaryCompleteReducibility
import Theorems.Thm_BookProof_ChapterUnitaryCompleteReducibility_orthogonal_isInvariant
open BookProof.ChapterUnitaryCompleteReducibility




open Submodule

variable {G : Type*} [Group G] {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

variable {G : Type*} [Group G] {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

set_option maxHeartbeats 1000000 in
theorem solution [FiniteDimensional ℂ V]
    {ρ : G →* (V ≃ₗᵢ[ℂ] V)} {W : Submodule ℂ V} (hW : IsInvariant ρ W) :
    ∃ W' : Submodule ℂ V, IsInvariant ρ W' ∧ IsCompl W W' := ⟨Wᗮ, orthogonal_isInvariant hW, Submodule.isCompl_orthogonal_of_hasOrthogonalProjection⟩
