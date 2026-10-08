-- Generated from ChapterMackeyGeneralBase.lean — solution of BookProof.ChapterMackeyGeneralBase.ImprimitivitySystem.U_mul_apply
import Mathlib
import Definitions.Def_ChapterMackeyGeneralBase
open BookProof.ChapterMackeyGeneralBase
open BookProof.ChapterMackeyGeneralBase.ImprimitivitySystem



open scoped InnerProductSpace


open BookProof.ChapterOrthogonalSums

variable {G : Type*} [Group G] {X : Type*} [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

variable {G : Type*} [Group G] {X : Type*} [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable (S : ImprimitivitySystem G X E)

set_option maxHeartbeats 1000000 in
theorem solution (g h : G) (ψ : E) : S.U g (S.U h ψ) = S.U (g * h) ψ := by

  rw [map_mul]; rfl
