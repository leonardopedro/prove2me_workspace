-- Generated from ChapterMaschkeFiniteGroup.lean — theorem BookProof.ChapterMaschkeFiniteGroup.avgProj_apply
import Mathlib
import Definitions.Def_ChapterMaschkeFiniteGroup
open BookProof.ChapterMaschkeFiniteGroup



variable {G : Type*} [Group G] {V : Type*} [AddCommGroup V] [Module ℂ V]


theorem BookProof.ChapterMaschkeFiniteGroup.avgProj_apply [Fintype G] (ρ : Representation ℂ G V) (pi : V →ₗ[ℂ] V) (x : V) :
    avgProj ρ pi x = (Fintype.card G : ℂ)⁻¹ • ∑ g : G, ρ g (pi (ρ g⁻¹ x)) := by sorry
