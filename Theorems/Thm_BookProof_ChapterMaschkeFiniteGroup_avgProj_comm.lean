-- Generated from ChapterMaschkeFiniteGroup.lean — theorem BookProof.ChapterMaschkeFiniteGroup.avgProj_comm
import Mathlib
import Definitions.Def_ChapterMaschkeFiniteGroup
open BookProof.ChapterMaschkeFiniteGroup



variable {G : Type*} [Group G] {V : Type*} [AddCommGroup V] [Module ℂ V]


theorem BookProof.ChapterMaschkeFiniteGroup.avgProj_comm [Fintype G] (ρ : Representation ℂ G V) (pi : V →ₗ[ℂ] V) (h : G) (x : V) :
    avgProj ρ pi (ρ h x) = ρ h (avgProj ρ pi x) := by sorry
