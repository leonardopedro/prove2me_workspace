-- Generated from ChapterQgOuterFockFarisLavine.lean — solution of BookProof.QgOuterFockFL.harmFried_isPositiveSelfAdjointExtension
import Mathlib
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Theorems.Thm_BookProof_QgOuterFockFL_Comparison_isPositiveSelfAdjointExtension
import Theorems.Thm_BookProof_QgOuterFockFL_polyGaussCore_le_harmFriedDom
import Theorems.Thm_BookProof_QgOuterFockFL_harmFried_op_core
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

set_option maxHeartbeats 1000000 in
theorem solution (d : ℕ) :
    IsPositiveSelfAdjointExtension (harmCore (d := d)) (harmFried d).op :=
  (harmFried d).isPositiveSelfAdjointExtension harmCore
      (fun p => ⟨polyGaussCore_le_harmFriedDom d p.2, harmFried_op_core d p _⟩)
