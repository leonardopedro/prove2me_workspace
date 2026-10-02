-- Generated from ChapterQgOuterFockFarisLavine.lean — solution of BookProof.QgOuterFockFL.friedrichsComparison_extends
import Mathlib
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_dom_le_range
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_friedrichsResolvent_injective
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_friedrichsResolvent_shift
import Theorems.Thm_BookProof_HashimotoShiftInvert_invShiftOperator_apply
import Theorems.Thm_BookProof_HashimotoShiftInvert_preim_eq
open BookProof.QgOuterFockFL



open scoped ENNReal


open BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock
open BookProof.YangMillsFriedrichs
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom
open BookProof.HashimotoShiftInvert
open BookProof.QgHermiteOscillator
open BookProof.HermiteProductCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace F] (P : PosSymOp F)
    (hdense : Dense (P.dom : Set F)) (x : P.dom) :
    ∃ h : (x : F) ∈ (friedrichsComparison P hdense).dom,
      (friedrichsComparison P hdense).op ⟨(x : F), h⟩ = P.op x := by

  have hinj : Function.Injective (friedrichsResolvent P) :=
    friedrichsResolvent_injective P hdense
  refine ⟨dom_le_range P x.2, ?_⟩
  have hpre : preim (friedrichsResolvent P) ⟨(x : F), dom_le_range P x.2⟩ = (x : F) + P.op x :=
    preim_eq _ hinj _ (friedrichsResolvent_shift P x)
  change invShiftOperator (friedrichsResolvent P) hinj 1 ⟨(x : F), dom_le_range P x.2⟩ = P.op x
  rw [invShiftOperator_apply, hpre]
  push_cast
  module
