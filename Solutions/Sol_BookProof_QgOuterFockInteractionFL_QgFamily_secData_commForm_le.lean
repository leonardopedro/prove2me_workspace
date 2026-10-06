-- Generated from ChapterQgOuterFockInteractionFL.lean — solution of BookProof.QgOuterFockInteractionFL.QgFamily.secData_commForm_le
import Mathlib
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Theorems.Thm_BookProof_QgOuterFockInteractionFL_QgFamily_secHam_commForm_le
import Theorems.Thm_BookProof_QgOuterFockCoreFL_commForm_congr
import Theorems.Thm_BookProof_QgOuterFockCoreFL_quadForm_congr
import Theorems.Thm_BookProof_QgOuterFockFL_harmFried_op_core
open BookProof.QgOuterFockInteractionFL
open BookProof.QgOuterFockInteractionFL.QgFamily




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
theorem solution (n : ℕ) (p : (F.secData n).C₀) :
    |commForm (F.secData n).H₀ (F.secData n).coreN p|
      ≤ F.flc * quadForm (F.secData n).coreN p := by

  have hN : (F.secData n).coreN p = harmCore p :=
    harmFried_op_core (n * 84) p _
  have h1 : commForm (F.secData n).H₀ (F.secData n).coreN p
      = commForm (F.secHam n) (harmCore (d := n * 84)) p :=
    commForm_congr (F.secData n).H₀ (F.secData n).coreN (F.secHam n)
      (harmCore (d := n * 84)) p p rfl hN
  have h2 : quadForm (F.secData n).coreN p = quadForm (harmCore (d := n * 84)) p :=
    quadForm_congr (F.secData n).coreN (harmCore (d := n * 84)) p p rfl hN
  rw [h1, h2]
  exact F.secHam_commForm_le n p
