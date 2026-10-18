-- Generated from ChapterQgOuterFockFarisLavine.lean — solution of BookProof.QgOuterFockFL.harmFried_op_core
import Mathlib
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Theorems.Thm_BookProof_QgOuterFockFL_friedrichsComparison_extends
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
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
theorem solution (d : ℕ) (p : polyGaussCore (d := d))
    (h : (p : L2d d) ∈ (harmFried d).dom) :
    (harmFried d).op ⟨(p : L2d d), h⟩ = BookProof.QgOuterFockFL.harmCore p := (friedrichsComparison_extends (harmPosSym d) polyGaussCore_dense p).choose_spec
