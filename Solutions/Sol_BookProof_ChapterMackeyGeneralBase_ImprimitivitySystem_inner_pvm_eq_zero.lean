-- Generated from ChapterMackeyGeneralBase.lean — solution of BookProof.ChapterMackeyGeneralBase.ImprimitivitySystem.inner_pvm_eq_zero
import Mathlib
import Definitions.Def_ChapterMackeyGeneralBase
import Theorems.Thm_BookProof_QgOuterFockFL_Comparison_selfAdjoint
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
theorem solution {x y : X} (hxy : x ≠ y) (ψ φ : E) :
    ⟪S.p x ψ, S.p y φ⟫_ℂ = 0 := by

  rw [S.selfAdjoint x ψ (S.p y φ), S.orthogonal x y hxy, inner_zero_right]
