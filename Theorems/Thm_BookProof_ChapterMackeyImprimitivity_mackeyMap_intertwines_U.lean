-- Generated from ChapterMackeyImprimitivity.lean — theorem BookProof.ChapterMackeyImprimitivity.mackeyMap_intertwines_U
import Mathlib
import Definitions.Def_ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity


open scoped InnerProductSpace
open Finset


variable {G : Type*} [Group G] {X : Type*} [Fintype X] [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

variable (S : ImprimitivitySystem G X E)
variable (S : ImprimitivitySystem G X E) (x₀ : X) (s : X → G)
variable {S x₀ s}

theorem BookProof.ChapterMackeyImprimitivity.mackeyMap_intertwines_U (hs : ∀ x, s x • x₀ = x) (g : G) (ψ : E) :
    mackeyMap S s (S.U g ψ) = inducedRep S s g (mackeyMap S s ψ) := by sorry
