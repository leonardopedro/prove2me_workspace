-- Generated from ChapterFriedrichsCanonical.lean — solution of BookProof.FriedrichsCanonical.dom_le_formDomain
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_formExt_coe
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterQgOuterFockFarisLavine
open BookProof.FriedrichsCanonical




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom
open BookProof.QgOuterFockFL

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (P : PosSymOp F) : P.dom ≤ formDomain P := by

  intro v hv
  refine ⟨((show FormDom P from ⟨v, hv⟩ : FormDom P) : FormSpace P), ?_⟩
  simp only [ContinuousLinearMap.coe_coe]
  erw [formExt_coe]
  rfl
