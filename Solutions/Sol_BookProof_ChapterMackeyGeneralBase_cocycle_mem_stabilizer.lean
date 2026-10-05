-- Generated from ChapterMackeyGeneralBase.lean — solution of BookProof.ChapterMackeyGeneralBase.cocycle_mem_stabilizer
import Mathlib
import Definitions.Def_ChapterMackeyGeneralBase
import Theorems.Thm_BookProof_ChapterMackeyGeneralBase_inv_smul_section
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
theorem solution (hs : ∀ x, s x • x₀ = x) (g : G) (x : X) :
    cocycle s g x ∈ MulAction.stabilizer G x₀ := by

  change cocycle s g x • x₀ = x₀
  rw [cocycle, mul_smul, mul_smul, hs (g⁻¹ • x), smul_inv_smul, inv_smul_section hs x]
