-- Generated from ChapterUnitaryCompleteReducibility.lean — theorem BookProof.ChapterUnitaryCompleteReducibility.exists_irreducible_invariant_le
import Mathlib
import Definitions.Def_ChapterUnitaryCompleteReducibility
import Definitions.Def_ChapterMaschkeFiniteGroup
open BookProof.ChapterMaschkeFiniteGroup
open BookProof.ChapterUnitaryCompleteReducibility

variable {G : Type*} [Group G] {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]



open Submodule


theorem BookProof.ChapterUnitaryCompleteReducibility.exists_irreducible_invariant_le [FiniteDimensional ℂ V]
    {ρ : G →* (V ≃ₗᵢ[ℂ] V)} {U : Submodule ℂ V} (hU : IsInvariant ρ U) (hUne : U ≠ ⊥) :
    ∃ W ≤ U, IsIrreducibleInvariant ρ W := by sorry
