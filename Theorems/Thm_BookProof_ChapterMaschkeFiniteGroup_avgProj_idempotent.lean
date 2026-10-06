-- Generated from ChapterMaschkeFiniteGroup.lean — theorem BookProof.ChapterMaschkeFiniteGroup.avgProj_idempotent
import Mathlib
import Definitions.Def_ChapterMaschkeFiniteGroup
open BookProof.ChapterMaschkeFiniteGroup

variable {G : Type*} [Group G] {V : Type*} [AddCommGroup V] [Module ℂ V]




theorem BookProof.ChapterMaschkeFiniteGroup.avgProj_idempotent [Fintype G] {ρ : Representation ℂ G V} {W : Submodule ℂ V}
    (hW : IsInvariant ρ W) (pi : V →ₗ[ℂ] V) (hpi_mem : ∀ x, pi x ∈ W)
    (hpi_id : ∀ x ∈ W, pi x = x) (x : V) :
    avgProj ρ pi (avgProj ρ pi x) = avgProj ρ pi x := by sorry
