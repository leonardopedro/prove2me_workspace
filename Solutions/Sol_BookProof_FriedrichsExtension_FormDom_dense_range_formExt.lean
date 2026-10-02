-- Generated from ChapterFriedrichsExtension.lean — solution of BookProof.FriedrichsExtension.FormDom.dense_range_formExt
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_formExt_coe
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin
open scoped InnerProductSpace ENNReal lp

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
ed_eq (by fun_prop) (by fun_prop)
  simpa using hall k

theorem solution (P : PosSymOp F) (hdense : Den :=
  se (P.dom : Set F)) :
      Dense (Set.range (formExt P)) := by
    refine Dense.mono ?_ hdense
    intro v hv
    exact ⟨((show FormDom P from ⟨v, hv⟩
