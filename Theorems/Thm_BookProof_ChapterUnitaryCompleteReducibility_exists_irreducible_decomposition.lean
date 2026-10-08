-- Generated from ChapterUnitaryCompleteReducibility.lean — theorem BookProof.ChapterUnitaryCompleteReducibility.exists_irreducible_decomposition
import Mathlib
import Definitions.Def_ChapterUnitaryCompleteReducibility
import Definitions.Def_ChapterMaschkeFiniteGroup
open BookProof.ChapterMaschkeFiniteGroup
open BookProof.ChapterUnitaryCompleteReducibility



open Submodule

variable {G : Type*} [Group G] {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]


theorem BookProof.ChapterUnitaryCompleteReducibility.exists_irreducible_decomposition [FiniteDimensional ℂ V]
    {ρ : G →* (V ≃ₗᵢ[ℂ] V)} (U : Submodule ℂ V) (hU : IsInvariant ρ U) :
    ∃ L : List (Submodule ℂ V),
      (∀ W ∈ L, W ≤ U ∧ IsIrreducibleInvariant ρ W) ∧
        L.foldr (· ⊔ ·) ⊥ = U := by sorry
