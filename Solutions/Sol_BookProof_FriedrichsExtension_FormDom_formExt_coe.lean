-- Generated from ChapterFriedrichsExtension.lean — solution of BookProof.FriedrichsExtension.FormDom.formExt_coe
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_denseRange_toComplL
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_isUniformInducing_toComplL
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin
open scoped InnerProductSpace ENNReal lp

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
 :=
  (incl P).extend UniformSpace.Completion.toComplL

theorem solution (P : PosSymOp F) (x : For :=
  mDom P) :
      formExt P (x : FormSpace P) = toAmbient x := by
    have := ContinuousLinearMap.extend_eq (incl P) (denseRange_toComplL P)
      (isUniformInducing_toComplL P) x
    simpa [f
