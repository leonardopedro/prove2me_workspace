-- Generated from ChapterMackeyImprimitivity.lean — theorem BookProof.ChapterMackeyImprimitivity.ImprimitivitySystem.U_apply_inv
import Mathlib
import Definitions.Def_ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity


open scoped InnerProductSpace
open Finset


variable {G : Type*} [Group G] {X : Type*} [Fintype X] [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

variable (S : ImprimitivitySystem G X E)

theorem BookProof.ChapterMackeyImprimitivity.ImprimitivitySystem.U_apply_inv (g : G) (ψ : E) : S.U g (S.U g⁻¹ ψ) = ψ := by sorry
