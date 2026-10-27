-- Generated from ChapterQgOuterFockFarisLavine.lean — solution of BookProof.QgOuterFockFL.Comparison.essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Theorems.Thm_BookProof_FarisLavine_essentiallySelfAdjointOn_of_farisLavine
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
theorem solution [CompleteSpace F] (C : Comparison F)
    (H : C.dom →ₗ[ℂ] F) (hH : SymmetricOn C.dom H) (c : ℝ) (hc : 0 ≤ c)
    (hcomm : ∀ x : C.dom, |commForm H C.op x| ≤ c * quadForm C.op x) :
    EssentiallySelfAdjointOn C.dom H :=
  essentiallySelfAdjointOn_of_farisLavine H C.op c hH C.sym hc C.pos
      (fun f => C.surj f) hcomm
