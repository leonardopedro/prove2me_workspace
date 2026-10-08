-- Generated from ChapterMackeyImprimitivity.lean — theorem BookProof.ChapterMackeyImprimitivity.ImprimitivitySystem.U_mul_apply
import Mathlib
import Definitions.Def_ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity


open scoped InnerProductSpace
open Finset


variable {G : Type*} [Group G] {X : Type*} [Fintype X] [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

variable (S : ImprimitivitySystem G X E)

theorem BookProof.ChapterMackeyImprimitivity.ImprimitivitySystem.U_mul_apply (g h : G) (ψ : E) : S.U g (S.U h ψ) = S.U (g * h) ψ := by sorry
