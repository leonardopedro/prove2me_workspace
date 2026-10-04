-- Generated from ChapterRelationShiftInvert.lean — theorem BookProof.RelationShiftInvert.relOp_mem
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterRelationShiftInvert
import Definitions.Def_ChapterA4
open BookProof.RelationShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}



open BookProof.NonnegUnitaryGroup BookProof.HashimotoShiftInvert


theorem BookProof.RelationShiftInvert.relOp_mem (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (x : relDomain T) :
    ((x : F), relOp hsv x) ∈ T := by sorry
