-- Generated from ChapterMaschkeFiniteGroup.lean — solution of BookProof.ChapterMaschkeFiniteGroup.avgProj_mem
import Mathlib
import Definitions.Def_ChapterMaschkeFiniteGroup
import Theorems.Thm_BookProof_ChapterMaschkeFiniteGroup_avgProj_apply
open BookProof.ChapterMaschkeFiniteGroup




variable {G : Type*} [Group G] {V : Type*} [AddCommGroup V] [Module ℂ V]

variable {G : Type*} [Group G] {V : Type*} [AddCommGroup V] [Module ℂ V]

set_option maxHeartbeats 1000000 in
theorem solution [Fintype G] {ρ : Representation ℂ G V} {W : Submodule ℂ V}
    (hW : IsInvariant ρ W) (pi : V →ₗ[ℂ] V) (hpi : ∀ x, pi x ∈ W) (x : V) : avgProj ρ pi x ∈ W := by

  rw [avgProj_apply]
  exact W.smul_mem _ (W.sum_mem fun g _ => hW g _ (hpi _))
