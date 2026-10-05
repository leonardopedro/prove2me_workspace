-- Generated from ChapterMackeyGeneralBase.lean — solution of BookProof.ChapterMackeyGeneralBase.mackeyMap_smul
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
variable (S : ImprimitivitySystem G X E) (x₀ : X) (s : X → G)
variable {S x₀ s}

set_option maxHeartbeats 1000000 in
theorem solution (a : ℂ) (ψ : E) : mackeyMap S s (a • ψ) = a • mackeyMap S s ψ := by

  funext x
  simp [mackeyMap]
