-- Generated from ChapterMackeyGeneralBase.lean — solution of BookProof.ChapterMackeyGeneralBase.inv_smul_section
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
theorem solution (hs : ∀ x, s x • x₀ = x) (x : X) : (s x)⁻¹ • x = x₀ :=
  calc (s x)⁻¹ • x = (s x)⁻¹ • (s x • x₀) := by rw [hs x]
      _ = x₀ := inv_smul_smul _ _
