-- Generated from ChapterMackeyImprimitivity.lean — theorem BookProof.ChapterMackeyImprimitivity.ImprimitivitySystem.U_inv_apply
import Mathlib
import Definitions.Def_ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity


open scoped InnerProductSpace
open Finset


variable {G : Type*} [Group G] {X : Type*} [Fintype X] [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

variable (S : ImprimitivitySystem G X E)

theorem BookProof.ChapterMackeyImprimitivity.ImprimitivitySystem.U_inv_apply (g : G) (ψ : E) : S.U g⁻¹ (S.U g ψ) = ψ := by sorry
