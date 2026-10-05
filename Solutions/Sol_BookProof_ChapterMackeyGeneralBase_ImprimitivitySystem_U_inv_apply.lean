-- Generated from ChapterMackeyGeneralBase.lean — solution of BookProof.ChapterMackeyGeneralBase.ImprimitivitySystem.U_inv_apply
import Mathlib
import Definitions.Def_ChapterMackeyGeneralBase
open BookProof.ChapterMackeyGeneralBase



open scoped InnerProductSpace


open BookProof.ChapterOrthogonalSums

variable {G : Type*} [Group G] {X : Type*} [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

variable {G : Type*} [Group G] {X : Type*} [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable (S : ImprimitivitySystem G X E)

set_option maxHeartbeats 1000000 in
theorem solution (g : G) (ψ : E) : S.U g⁻¹ (S.U g ψ) = ψ := by

  have h : S.U g⁻¹ (S.U g ψ) = S.U (g⁻¹ * g) ψ := by rw [map_mul]; rfl
  rw [h, inv_mul_cancel, map_one]
  rfl
