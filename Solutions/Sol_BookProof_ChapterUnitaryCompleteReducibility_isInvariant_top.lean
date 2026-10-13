-- Generated from ChapterUnitaryCompleteReducibility.lean — solution of BookProof.ChapterUnitaryCompleteReducibility.isInvariant_top
import Mathlib
import Definitions.Def_ChapterUnitaryCompleteReducibility
import Definitions.Def_ChapterMaschkeFiniteGroup
open BookProof.ChapterUnitaryCompleteReducibility




open Submodule

variable {G : Type*} [Group G] {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

variable {G : Type*} [Group G] {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

set_option maxHeartbeats 1000000 in
theorem solution (ρ : G →* (V ≃ₗᵢ[ℂ] V)) : IsInvariant ρ (⊤ : Submodule ℂ V) := fun _ _ _ => trivial
