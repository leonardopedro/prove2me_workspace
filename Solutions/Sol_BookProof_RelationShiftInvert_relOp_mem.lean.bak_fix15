-- Generated from ChapterRelationShiftInvert.lean — solution of BookProof.RelationShiftInvert.relOp_mem
import Mathlib
import Definitions.Def_ChapterRelationShiftInvert
open BookProof.RelationShiftInvert




open BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot BookProof.NonnegResolvent
open BookProof.NonnegUnitaryGroup BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (x : relDomain T) :
    ((x : F), relOp hsv x) ∈ T := relOpFun_mem x
