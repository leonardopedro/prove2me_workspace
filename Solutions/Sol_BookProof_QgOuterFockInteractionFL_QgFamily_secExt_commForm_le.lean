-- Generated from ChapterQgOuterFockInteractionFL.lean — solution of BookProof.QgOuterFockInteractionFL.QgFamily.secExt_commForm_le
import Mathlib
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Theorems.Thm_BookProof_QgOuterFockInteractionFL_QgFamily_secData_commForm_le
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_commForm_le
open BookProof.QgOuterFockInteractionFL




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockFullFL
open BookProof.Qg3DGaugeEsa BookProof.QuantumGravity3DGauge
open BookProof.GaussCoreQuadBounds BookProof.SqSumFarisLavine

noncomputable section

variable (F : QgFamily)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (u : (harmFried (n * 84)).dom) :
    |commForm (F.secExt n) (harmFried (n * 84)).op u|
      ≤ F.flc * quadForm (harmFried (n * 84)).op u := (F.secData n).ext_commForm_le (F.secData_commForm_le n) u
