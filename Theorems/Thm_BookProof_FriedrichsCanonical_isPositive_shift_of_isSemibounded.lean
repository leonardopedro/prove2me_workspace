-- Generated from ChapterFriedrichsCanonical.lean — theorem BookProof.FriedrichsCanonical.isPositive_shift_of_isSemibounded
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



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {D : Submodule ℂ F}

theorem BookProof.FriedrichsCanonical.isPositive_shift_of_isSemibounded {Dom : Submodule ℂ F} (H : D →ₗ[ℂ] F) (c : ℝ)
    (A : Dom →ₗ[ℂ] F) (hA : IsSemiboundedSelfAdjointExtension c H A) :
    IsPositiveSelfAdjointExtension (H + (c : ℂ) • D.subtype) (A + (c : ℂ) • Dom.subtype) := by sorry
