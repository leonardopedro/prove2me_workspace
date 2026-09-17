-- Generated from ChapterFriedrichsExtension.lean — solution of BookProof.FriedrichsExtension.FormDom.friedrichsResolvent_shift
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_formExt_coe
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_inner_coe_eq
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_friedrichsResolvent_apply
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (P : PosSymOp F) (x : P.dom) :
    friedrichsResolvent P ((x : F) + P.op x) = (x : F) := by

  have hx : formRiesz P ((x : F) + P.op x)
      = ((show FormDom P from x : FormDom P) : FormSpace P) := by
    refine ext_inner_right ℂ (fun k => ?_)
    rw [formRiesz_spec, inner_coe_eq]
    rfl
  rw [friedrichsResolvent_apply, hx, formExt_coe]
  rfl
