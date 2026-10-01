-- Generated from ChapterQgOuterFockFarisLavine.lean — solution of BookProof.QgOuterFockFL.harmFried_op_core
import Mathlib
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Theorems.Thm_BookProof_QgOuterFockFL_friedrichsComparison_extends
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
theorem solution (d : ℕ) (p : polyGaussCore (d := d))
    (h : (p : L2d d) ∈ (harmFried d).dom) :
    (harmFried d).op ⟨(p : L2d d), h⟩ = harmCore p := (friedrichsComparison_extends (harmPosSym d) polyGaussCore_dense p).choose_spec
