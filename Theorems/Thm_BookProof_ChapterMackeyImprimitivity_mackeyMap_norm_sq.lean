-- Generated from ChapterMackeyImprimitivity.lean — theorem BookProof.ChapterMackeyImprimitivity.mackeyMap_norm_sq
import Mathlib
import Definitions.Def_ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity

variable {G : Type*} [Group G] {X : Type*} [Fintype X] [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable (S : ImprimitivitySystem G X E)
variable (S : ImprimitivitySystem G X E) (x₀ : X) (s : X → G)
variable {S x₀ s}


open scoped InnerProductSpace
open Finset



theorem BookProof.ChapterMackeyImprimitivity.mackeyMap_norm_sq (ψ : E) : ∑ x : X, ‖mackeyMap S s ψ x‖ ^ 2 = ‖ψ‖ ^ 2 := by sorry
