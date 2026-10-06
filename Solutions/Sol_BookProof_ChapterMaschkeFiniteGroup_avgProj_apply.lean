-- Generated from ChapterMaschkeFiniteGroup.lean — solution of BookProof.ChapterMaschkeFiniteGroup.avgProj_apply
import Mathlib
import Definitions.Def_ChapterMaschkeFiniteGroup
open BookProof.ChapterMaschkeFiniteGroup




variable {G : Type*} [Group G] {V : Type*} [AddCommGroup V] [Module ℂ V]

variable {G : Type*} [Group G] {V : Type*} [AddCommGroup V] [Module ℂ V]

set_option maxHeartbeats 1000000 in
theorem solution [Fintype G] (ρ : Representation ℂ G V) (pi : V →ₗ[ℂ] V) (x : V) :
    avgProj ρ pi x = (Fintype.card G : ℂ)⁻¹ • ∑ g : G, ρ g (pi (ρ g⁻¹ x)) := by

  simp [avgProj, LinearMap.sum_apply]
