-- Generated from ChapterRelationShiftInvert.lean — theorem BookProof.RelationShiftInvert.hasDerivAt_unitaryU_relOp
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterNonnegUnitaryGroup
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterRelationShiftInvert
open BookProof.RelationShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}



open BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot BookProof.NonnegResolvent
open BookProof.NonnegUnitaryGroup BookProof.HashimotoShiftInvert


theorem BookProof.RelationShiftInvert.hasDerivAt_unitaryU_relOp (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (x : relDomain T) (t : ℝ) :
    HasDerivAt (fun s : ℝ => unitaryU hT hsv s (x : F))
      ((-Complex.I) • unitaryU hT hsv t (relOp hsv x)) t := by sorry
