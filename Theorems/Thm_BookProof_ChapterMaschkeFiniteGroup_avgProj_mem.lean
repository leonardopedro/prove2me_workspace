-- Generated from ChapterMaschkeFiniteGroup.lean — theorem BookProof.ChapterMaschkeFiniteGroup.avgProj_mem
import Mathlib
import Definitions.Def_ChapterMaschkeFiniteGroup
open BookProof.ChapterMaschkeFiniteGroup



variable {G : Type*} [Group G] {V : Type*} [AddCommGroup V] [Module ℂ V]


theorem BookProof.ChapterMaschkeFiniteGroup.avgProj_mem [Fintype G] {ρ : Representation ℂ G V} {W : Submodule ℂ V}
    (hW : IsInvariant ρ W) (pi : V →ₗ[ℂ] V) (hpi : ∀ x, pi x ∈ W) (x : V) : avgProj ρ pi x ∈ W := by sorry
