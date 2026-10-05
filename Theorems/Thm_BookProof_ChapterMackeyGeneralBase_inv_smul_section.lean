-- Generated from ChapterMackeyGeneralBase.lean — theorem BookProof.ChapterMackeyGeneralBase.inv_smul_section
import Definitions.Def_ChapterOrthogonalSums
import Mathlib
import Definitions.Def_ChapterMackeyGeneralBase
open BookProof.ChapterMackeyGeneralBase

variable {G : Type*} [Group G] {X : Type*} [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable (S : ImprimitivitySystem G X E)
variable (S : ImprimitivitySystem G X E) (x₀ : X) (s : X → G)
variable {S x₀ s}


open scoped InnerProductSpace


open BookProof.ChapterOrthogonalSums


theorem BookProof.ChapterMackeyGeneralBase.inv_smul_section (hs : ∀ x, s x • x₀ = x) (x : X) : (s x)⁻¹ • x = x₀ := by sorry
