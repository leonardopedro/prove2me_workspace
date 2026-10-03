-- Generated from ChapterFriedrichsExtension.lean — theorem BookProof.FriedrichsExtension.FormDom.incl_apply
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin
open scoped InnerProductSpace ENNReal lp


mOp F} (x : FormDom P) : incl P x = toAmbient x := rfl

theorem BookProof.FriedrichsExtension.FormDom.incl_apply (P : PosSymOp F) : ‖incl P‖ ≤ 1 := by sorry
