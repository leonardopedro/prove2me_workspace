-- Generated from ChapterRelationShiftInvert.lean — solution of BookProof.RelationShiftInvert.relOp_unitaryU
import Mathlib
import Definitions.Def_ChapterRelationShiftInvert
import Theorems.Thm_BookProof_RelationShiftInvert_relOp_mem
import Theorems.Thm_BookProof_RelationShiftInvert_unitaryU_mem_relDomain
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
    relOp hsv ⟨unitaryU hT hsv t (x : F), unitaryU_mem_relDomain hT hsv x t⟩
      = unitaryU hT hsv t (relOp hsv x) := relOpFun_eq hsv (mem_unitaryU hT hsv (relOp_mem hsv x) t)
