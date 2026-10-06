-- Generated from ChapterMackeyImprimitivity.lean — theorem BookProof.ChapterMackeyImprimitivity.fibre_stabilizer_invariant
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



theorem BookProof.ChapterMackeyImprimitivity.fibre_stabilizer_invariant {h : G} (hh : h ∈ MulAction.stabilizer G x₀) {v : E}
    (hv : S.p x₀ v = v) : S.p x₀ (S.U h v) = S.U h v := by sorry
