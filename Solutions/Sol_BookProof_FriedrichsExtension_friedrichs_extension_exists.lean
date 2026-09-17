-- Generated from ChapterFriedrichsExtension.lean — solution of BookProof.FriedrichsExtension.friedrichs_extension_exists
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_friedrichsResolvent_isSelfAdjoint
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_friedrichsResolvent_pos
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_friedrichsResolvent_injective
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_friedrichsResolvent_shift
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_dom_le_range
open BookProof.FriedrichsExtension




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (P : PosSymOp F) (hdense : Dense (P.dom : Set F)) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsPositiveSelfAdjointExtension P.op A := by

  have hinj : Function.Injective (friedrichsResolvent P) :=
    friedrichsResolvent_injective P hdense
  refine ⟨_, invShiftOperator (friedrichsResolvent P) hinj 1, ?_⟩
  refine invShiftOperator_isPositiveSelfAdjointExtension (friedrichsResolvent P) hinj 1
    (friedrichsResolvent_isSelfAdjoint P) (friedrichsResolvent_pos P) (dom_le_range P) P.op ?_
  intro x
  have hpre : preim (friedrichsResolvent P) ⟨(x : F), dom_le_range P x.2⟩
      = (x : F) + P.op x :=
    preim_eq _ hinj _ (friedrichsResolvent_shift P x)
  rw [invShiftOperator_apply, hpre]
  push_cast
  module
