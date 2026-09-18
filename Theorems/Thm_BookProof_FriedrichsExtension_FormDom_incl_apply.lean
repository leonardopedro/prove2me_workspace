-- Generated from ChapterFriedrichsExtension.lean — theorem BookProof.FriedrichsExtension.FormDom.incl_apply
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_BookProof.ChapterClosureUniqueness

open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.FriedrichsExtension.FormDom.incl_apply {P : PosSymOp F} (x : FormDom P) : incl P x = toAmbient x := by sorry
