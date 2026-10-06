-- Generated from ChapterMaschkeFiniteGroup.lean — solution of BookProof.ChapterMaschkeFiniteGroup.rho_rho
import Mathlib
import Definitions.Def_ChapterMaschkeFiniteGroup
open BookProof.ChapterMaschkeFiniteGroup




variable {G : Type*} [Group G] {V : Type*} [AddCommGroup V] [Module ℂ V]

variable {G : Type*} [Group G] {V : Type*} [AddCommGroup V] [Module ℂ V]

set_option maxHeartbeats 1000000 in
theorem solution (ρ : Representation ℂ G V) (a b : G) (x : V) :
    ρ a (ρ b x) = ρ (a * b) x := by

  rw [map_mul]; rfl
