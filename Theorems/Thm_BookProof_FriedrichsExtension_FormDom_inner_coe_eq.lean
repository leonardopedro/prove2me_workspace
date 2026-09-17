-- Generated from ChapterFriedrichsExtension.lean — theorem BookProof.FriedrichsExtension.FormDom.inner_coe_eq
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.FriedrichsExtension.FormDom.inner_coe_eq (P : PosSymOp F) (x : FormDom P) (k : FormSpace P) :
    (inner ℂ (x : FormSpace P) k : ℂ)
      = inner ℂ (toAmbient x + P.op (toDom x)) (formExt P k) := by sorry
