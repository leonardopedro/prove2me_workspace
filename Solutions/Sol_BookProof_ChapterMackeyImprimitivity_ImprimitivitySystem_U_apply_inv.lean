-- Generated from ChapterMackeyImprimitivity.lean — solution of BookProof.ChapterMackeyImprimitivity.ImprimitivitySystem.U_apply_inv
import Mathlib
import Definitions.Def_ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity.ImprimitivitySystem



open scoped InnerProductSpace
open Finset


variable {G : Type*} [Group G] {X : Type*} [Fintype X] [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

variable {G : Type*} [Group G] {X : Type*} [Fintype X] [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable (S : ImprimitivitySystem G X E)

set_option maxHeartbeats 1000000 in
theorem solution (g : G) (ψ : E) : S.U g (S.U g⁻¹ ψ) = ψ := by

  have h : S.U g (S.U g⁻¹ ψ) = S.U (g * g⁻¹) ψ := by rw [map_mul]; rfl
  rw [h, mul_inv_cancel, map_one]
  rfl
