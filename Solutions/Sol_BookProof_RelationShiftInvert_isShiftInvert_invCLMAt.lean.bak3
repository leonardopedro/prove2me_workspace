-- Generated from ChapterRelationShiftInvert.lean — solution of BookProof.RelationShiftInvert.isShiftInvert_invCLMAt
import Mathlib
import Definitions.Def_ChapterRelationShiftInvert
import Theorems.Thm_BookProof_RelationShiftInvert_relOp_mem
import Theorems.Thm_BookProof_HashimotoShiftInvert_shiftMap_apply
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_eq_of_mem
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_mem
open BookProof.RelationShiftInvert




open BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot BookProof.NonnegResolvent
open BookProof.NonnegUnitaryGroup BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {γ : ℝ} (hγ : 0 < γ) :
    IsShiftInvert (relOp hsv) γ (invCLMAt hT hγ) := by

  constructor
  · intro x
    refine invCLMAt_eq_of_mem hT hγ ?_
    have hx := relOp_mem hsv x
    have hrw : shiftMap (relOp hsv) γ x - (γ : ℂ) • (x : F) = relOp hsv x := by
      rw [shiftMap_apply]
      abel
    rw [hrw]
    exact hx
  · intro u
    have hmem := invCLMAt_mem hT hγ u
    have hdom : invCLMAt hT hγ u ∈ relDomain T := mem_relDomain_iff.2 ⟨_, hmem⟩
    refine ⟨hdom, ?_⟩
    have hval : relOp hsv ⟨invCLMAt hT hγ u, hdom⟩ = u - (γ : ℂ) • invCLMAt hT hγ u :=
      relOpFun_eq hsv hmem
    rw [shiftMap_apply, hval]
    abel
