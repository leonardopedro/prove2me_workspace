-- Generated from ChapterQgOuterFockFullFL.lean — solution of BookProof.QgOuterFockFullFL.qgSectorData_commForm_le
import Mathlib
import Definitions.Def_ChapterQgOuterFockFullFL
import Theorems.Thm_BookProof_QgOuterFockFullFL_qgSectorHam_commForm_le
import Theorems.Thm_BookProof_QgOuterFockCoreFL_commForm_congr
import Theorems.Thm_BookProof_QgOuterFockCoreFL_quadForm_congr
import Theorems.Thm_BookProof_QgOuterFockFL_harmFried_op_core
open BookProof.QgOuterFockFullFL




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.Qg3DGaugeEsa BookProof.QuantumGravity3DGauge
open BookProof.GaussCoreQuadBounds BookProof.SqSumFarisLavine
open Filter Topology

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (p : (qgSectorData n).C₀) :
    |commForm (qgSectorData n).H₀ (qgSectorData n).coreN p|
      ≤ qgFLc * quadForm (qgSectorData n).coreN p := by

  have hN : (qgSectorData n).coreN p = harmCore p :=
    harmFried_op_core (n * 84) p _
  have h1 : commForm (qgSectorData n).H₀ (qgSectorData n).coreN p
      = commForm (qgSectorHam n) (harmCore (d := n * 84)) p :=
    commForm_congr (qgSectorData n).H₀ (qgSectorData n).coreN (qgSectorHam n)
      (harmCore (d := n * 84)) p p rfl hN
  have h2 : quadForm (qgSectorData n).coreN p = quadForm (harmCore (d := n * 84)) p :=
    quadForm_congr (qgSectorData n).coreN (harmCore (d := n * 84)) p p rfl hN
  rw [h1, h2]
  exact qgSectorHam_commForm_le n p
