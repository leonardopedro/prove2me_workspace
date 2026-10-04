-- Generated from ChapterRelationShiftInvert.lean — theorem BookProof.RelationShiftInvert.relOp_unitaryU
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterRelationShiftInvert
import Definitions.Def_ChapterA4
open BookProof.RelationShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}



open BookProof.NonnegUnitaryGroup BookProof.HashimotoShiftInvert


theorem BookProof.RelationShiftInvert.relOp_unitaryU (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (x : relDomain T) (t : ℝ) :
    relOp hsv ⟨unitaryU hT hsv t (x : F), unitaryU_mem_relDomain hT hsv x t⟩
      = unitaryU hT hsv t (relOp hsv x) := by sorry
