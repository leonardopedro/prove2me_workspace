-- Generated from ChapterFriedrichsExtension.lean — theorem BookProof.FriedrichsExtension.friedrichs_extension_exists
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_BookProof.ChapterClosureUniqueness

open BookProof.FriedrichsExtension



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.FriedrichsExtension.friedrichs_extension_exists (P : PosSymOp F) (hdense : Dense (P.dom : Set F)) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsPositiveSelfAdjointExtension P.op A := by sorry
