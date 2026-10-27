-- Generated from ChapterFriedrichsCanonical.lean — solution of BookProof.FriedrichsCanonical.dom_le_formDomain
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_formExt_coe
open BookProof.FriedrichsCanonical




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (P : PosSymOp F) : P.dom ≤ formDomain P := by

  intro v hv
  refine ⟨((show FormDom P from ⟨v, hv⟩ : FormDom P) : FormSpace P), ?_⟩
  simp only [ContinuousLinearMap.coe_coe]
  erw [formExt_coe]
  rfl
