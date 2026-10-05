-- Generated from ChapterRelationShiftInvert.lean — theorem BookProof.RelationShiftInvert.isShiftInvert_invCLMAt
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterNonnegUnitaryGroup
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterRelationShiftInvert
import Definitions.Def_ChapterHashimotoShiftInvert
import Definitions.Def_ChapterQgOuterFockFarisLavine
open BookProof.QgOuterFockFL
open BookProof.RelationShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}



open BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot BookProof.NonnegResolvent
open BookProof.NonnegUnitaryGroup BookProof.HashimotoShiftInvert


theorem BookProof.RelationShiftInvert.isShiftInvert_invCLMAt (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {γ : ℝ} (hγ : 0 < γ) :
    IsShiftInvert (relOp hsv) γ (invCLMAt hT hγ) := by sorry
