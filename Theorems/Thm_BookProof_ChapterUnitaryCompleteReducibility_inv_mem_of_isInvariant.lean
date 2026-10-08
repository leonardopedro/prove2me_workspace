-- Generated from ChapterUnitaryCompleteReducibility.lean — theorem BookProof.ChapterUnitaryCompleteReducibility.inv_mem_of_isInvariant
import Mathlib
import Definitions.Def_ChapterUnitaryCompleteReducibility
import Definitions.Def_ChapterMaschkeFiniteGroup
open BookProof.ChapterMaschkeFiniteGroup
open BookProof.ChapterUnitaryCompleteReducibility



open Submodule

variable {G : Type*} [Group G] {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]


theorem BookProof.ChapterUnitaryCompleteReducibility.inv_mem_of_isInvariant {ρ : G →* (V ≃ₗᵢ[ℂ] V)} {W : Submodule ℂ V}
    (hW : IsInvariant ρ W) (g : G) {x : V} (hx : x ∈ W) : (ρ g).symm x ∈ W := by sorry
