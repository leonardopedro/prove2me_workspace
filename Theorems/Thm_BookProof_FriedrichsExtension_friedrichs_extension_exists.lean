-- Generated from ChapterFriedrichsExtension.lean — theorem BookProof.FriedrichsExtension.friedrichs_extension_exists
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
open BookProof.FriedrichsExtension














open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]































variable [CompleteSpace F]











variable [CompleteSpace F]
















open FormDom

variable [CompleteSpace F]

theorem BookProof.FriedrichsExtension.friedrichs_extension_exists (P : PosSymOp F) (hdense : Dense (P.dom : Set F)) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsPositiveSelfAdjointExtension P.op A := by sorry
