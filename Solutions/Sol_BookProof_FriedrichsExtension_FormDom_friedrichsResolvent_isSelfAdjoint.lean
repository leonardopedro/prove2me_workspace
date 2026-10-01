-- Generated from ChapterFriedrichsExtension.lean — solution of BookProof.FriedrichsExtension.FormDom.friedrichsResolvent_isSelfAdjoint
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_inner_friedrichsResolvent
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin
open scoped InnerProductSpace ENNReal lp

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
:= by
  rw [friedrichsResolvent_apply, formRiesz_spec]

theorem solution (P : :=
  PosSymOp F) :
      IsSelfAdjoint (friedrichsResolvent P) := by
    rw [ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric]
    intro u v
    simp only [ContinuousLinearMap.coe_coe]
    rw [← inner_conj_symm, inner_friedric
