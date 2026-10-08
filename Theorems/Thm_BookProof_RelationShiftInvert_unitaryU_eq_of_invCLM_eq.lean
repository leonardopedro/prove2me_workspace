-- Generated from ChapterRelationShiftInvert.lean — theorem BookProof.RelationShiftInvert.unitaryU_eq_of_invCLM_eq
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterNonnegUnitaryGroup
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterRelationShiftInvert
open BookProof.RelationShiftInvert



open BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot BookProof.NonnegResolvent
open BookProof.NonnegUnitaryGroup BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}


theorem BookProof.RelationShiftInvert.unitaryU_eq_of_invCLM_eq (hT₁ : IsNonnegSelfAdjoint T₁) (hT₂ : IsNonnegSelfAdjoint T₂)
    (hsv₁ : ∀ w : F, ((0 : F), w) ∈ T₁ → w = 0) (hsv₂ : ∀ w : F, ((0 : F), w) ∈ T₂ → w = 0)
    (heq : invCLM hT₁ = invCLM hT₂) (t : ℝ) :
    unitaryU hT₁ hsv₁ t = unitaryU hT₂ hsv₂ t := by sorry
