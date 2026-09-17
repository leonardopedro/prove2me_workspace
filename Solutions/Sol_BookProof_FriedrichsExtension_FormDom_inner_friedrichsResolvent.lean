-- Generated from ChapterFriedrichsExtension.lean — solution of BookProof.FriedrichsExtension.FormDom.inner_friedrichsResolvent
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_friedrichsResolvent_apply
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (P : PosSymOp F) (u v : F) :
    (inner ℂ u (friedrichsResolvent P v) : ℂ) = inner ℂ (formRiesz P u) (formRiesz P v) := by

  rw [friedrichsResolvent_apply, formRiesz_spec]
