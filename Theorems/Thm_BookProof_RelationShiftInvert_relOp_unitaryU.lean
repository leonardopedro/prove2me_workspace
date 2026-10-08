-- Generated from ChapterRelationShiftInvert.lean — theorem BookProof.RelationShiftInvert.relOp_unitaryU
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


theorem BookProof.RelationShiftInvert.relOp_unitaryU (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (x : relDomain T) (t : ℝ) :
    relOp hsv ⟨unitaryU hT hsv t (x : F), unitaryU_mem_relDomain hT hsv x t⟩
      = unitaryU hT hsv t (relOp hsv x) := by sorry
