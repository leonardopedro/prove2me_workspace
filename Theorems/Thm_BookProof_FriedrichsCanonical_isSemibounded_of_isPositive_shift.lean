-- Generated from ChapterFriedrichsCanonical.lean — theorem BookProof.FriedrichsCanonical.isSemibounded_of_isPositive_shift
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom
open BookProof.YangMillsFriedrichs
open BookProof.FriedrichsCanonical

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {D : Submodule ℂ F}



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section


theorem BookProof.FriedrichsCanonical.isSemibounded_of_isPositive_shift {Dom : Submodule ℂ F} (H : D →ₗ[ℂ] F) (c : ℝ)
    (A : Dom →ₗ[ℂ] F)
    (hA : IsPositiveSelfAdjointExtension (H + (c : ℂ) • D.subtype) A) :
    IsSemiboundedSelfAdjointExtension c H (A - (c : ℂ) • Dom.subtype) := by sorry
