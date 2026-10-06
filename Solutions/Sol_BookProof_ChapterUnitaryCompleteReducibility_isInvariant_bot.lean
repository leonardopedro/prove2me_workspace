-- Generated from ChapterUnitaryCompleteReducibility.lean — solution of BookProof.ChapterUnitaryCompleteReducibility.isInvariant_bot
import Mathlib
import Definitions.Def_ChapterUnitaryCompleteReducibility
open BookProof.ChapterUnitaryCompleteReducibility




open Submodule

variable {G : Type*} [Group G] {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

variable {G : Type*} [Group G] {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

set_option maxHeartbeats 1000000 in
theorem solution (ρ : G →* (V ≃ₗᵢ[ℂ] V)) : IsInvariant ρ (⊥ : Submodule ℂ V) := by

  intro g x hx
  rw [Submodule.mem_bot] at hx ⊢
  rw [hx, map_zero]
