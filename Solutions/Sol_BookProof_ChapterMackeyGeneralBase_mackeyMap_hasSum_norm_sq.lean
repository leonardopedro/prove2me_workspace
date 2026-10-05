-- Generated from ChapterMackeyGeneralBase.lean — solution of BookProof.ChapterMackeyGeneralBase.mackeyMap_hasSum_norm_sq
import Mathlib
import Definitions.Def_ChapterMackeyGeneralBase
import Theorems.Thm_BookProof_ChapterMackeyGeneralBase_ImprimitivitySystem_pvm_hasSum_norm_sq
import Theorems.Thm_BookProof_ChapterMackeyGeneralBase_mackeyMap_norm
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
theorem solution (ψ : E) :
    HasSum (fun x => ‖mackeyMap S s ψ x‖ ^ 2) (‖ψ‖ ^ 2) := by

  simpa only [mackeyMap_norm] using S.pvm_hasSum_norm_sq ψ
