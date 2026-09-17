-- Generated from ChapterFriedrichsExtension.lean — solution of BookProof.FriedrichsExtension.FormDom.dense_range_formExt
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_formExt_coe
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (P : PosSymOp F) (hdense : Dense (P.dom : Set F)) :
    Dense (Set.range (formExt P)) := by

  refine Dense.mono ?_ hdense
  intro v hv
  exact ⟨((show FormDom P from ⟨v, hv⟩ : FormDom P) : FormSpace P), by rw [formExt_coe]; rfl⟩
