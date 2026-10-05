-- Generated from ChapterMackeyGeneralBase.lean — solution of BookProof.ChapterMackeyGeneralBase.ImprimitivitySystem.pvm_hasSum_norm_sq
import Mathlib
import Definitions.Def_ChapterMackeyGeneralBase
import Theorems.Thm_BookProof_ChapterMackeyGeneralBase_ImprimitivitySystem_inner_pvm_eq_zero
import Theorems.Thm_BookProof_ChapterOrthogonalSums_hasSum_norm_sq_of_hasSum
open BookProof.ChapterMackeyGeneralBase



open scoped InnerProductSpace


open BookProof.ChapterOrthogonalSums

variable {G : Type*} [Group G] {X : Type*} [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

variable {G : Type*} [Group G] {X : Type*} [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable (S : ImprimitivitySystem G X E)

set_option maxHeartbeats 1000000 in
theorem solution (ψ : E) : HasSum (fun x => ‖S.p x ψ‖ ^ 2) (‖ψ‖ ^ 2) := hasSum_norm_sq_of_hasSum (S.complete ψ) fun _ _ hxy => S.inner_pvm_eq_zero hxy ψ ψ
