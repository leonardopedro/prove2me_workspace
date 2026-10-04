-- Generated from ChapterRelationShiftInvert.lean — theorem BookProof.RelationShiftInvert.isShiftInvert_invCLMAt
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterRelationShiftInvert
import Definitions.Def_ChapterHashimotoShiftInvert
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterA4
open BookProof.QgOuterFockFL
open BookProof.RelationShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}



open BookProof.NonnegUnitaryGroup BookProof.HashimotoShiftInvert


theorem BookProof.RelationShiftInvert.isShiftInvert_invCLMAt (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {γ : ℝ} (hγ : 0 < γ) :
    IsShiftInvert (relOp hsv) γ (invCLMAt hT hγ) := by sorry
