-- Generated from ChapterMaschkeFiniteGroup.lean — solution of BookProof.ChapterMaschkeFiniteGroup.avgProj_idempotent
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
    (hpi_id : ∀ x ∈ W, pi x = x) (x : V) :
    avgProj ρ pi (avgProj ρ pi x) = avgProj ρ pi x := avgProj_eq_self hW pi hpi_id (avgProj_mem hW pi hpi_mem x)
