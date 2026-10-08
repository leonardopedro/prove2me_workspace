-- Generated from ChapterMaschkeFiniteGroup.lean — theorem BookProof.ChapterMaschkeFiniteGroup.avgProj_eq_self
import Mathlib
import Definitions.Def_ChapterMaschkeFiniteGroup
open BookProof.ChapterMaschkeFiniteGroup



variable {G : Type*} [Group G] {V : Type*} [AddCommGroup V] [Module ℂ V]


theorem BookProof.ChapterMaschkeFiniteGroup.avgProj_eq_self [Fintype G] {ρ : Representation ℂ G V} {W : Submodule ℂ V}
    (hW : IsInvariant ρ W) (pi : V →ₗ[ℂ] V) (hpi : ∀ x ∈ W, pi x = x) {x : V} (hx : x ∈ W) :
    avgProj ρ pi x = x := by sorry
