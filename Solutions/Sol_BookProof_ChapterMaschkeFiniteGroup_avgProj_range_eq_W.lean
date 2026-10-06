-- Generated from ChapterMaschkeFiniteGroup.lean — solution of BookProof.ChapterMaschkeFiniteGroup.avgProj_range_eq_W
import Mathlib
import Definitions.Def_ChapterMaschkeFiniteGroup
import Theorems.Thm_BookProof_ChapterMaschkeFiniteGroup_avgProj_mem
import Theorems.Thm_BookProof_ChapterMaschkeFiniteGroup_avgProj_eq_self
open BookProof.ChapterMaschkeFiniteGroup




variable {G : Type*} [Group G] {V : Type*} [AddCommGroup V] [Module ℂ V]

variable {G : Type*} [Group G] {V : Type*} [AddCommGroup V] [Module ℂ V]

set_option maxHeartbeats 1000000 in
theorem solution [Fintype G] {ρ : Representation ℂ G V} {W : Submodule ℂ V}
    (hW : IsInvariant ρ W) (pi : V →ₗ[ℂ] V) (hpi_mem : ∀ x, pi x ∈ W)
    (hpi_id : ∀ x ∈ W, pi x = x) :
    LinearMap.range (avgProj ρ pi) = W := by

  refine le_antisymm ?_ ?_
  · rintro y ⟨x, rfl⟩
    exact avgProj_mem hW pi hpi_mem x
  · intro x hx
    exact ⟨x, avgProj_eq_self hW pi hpi_id hx⟩
