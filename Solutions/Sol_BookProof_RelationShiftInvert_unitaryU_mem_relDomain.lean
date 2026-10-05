-- Generated from ChapterRelationShiftInvert.lean — solution of BookProof.RelationShiftInvert.unitaryU_mem_relDomain
import Mathlib
import Definitions.Def_ChapterRelationShiftInvert
import Theorems.Thm_BookProof_RelationShiftInvert_relOp_mem
import Theorems.Thm_BookProof_NonnegUnitaryGroup_mem_unitaryU
open BookProof.RelationShiftInvert




open BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot BookProof.NonnegResolvent
open BookProof.NonnegUnitaryGroup BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (x : relDomain T) (t : ℝ) :
    unitaryU hT hsv t (x : F) ∈ relDomain T := mem_relDomain_iff.2 ⟨_, mem_unitaryU hT hsv (relOp_mem hsv x) t⟩
