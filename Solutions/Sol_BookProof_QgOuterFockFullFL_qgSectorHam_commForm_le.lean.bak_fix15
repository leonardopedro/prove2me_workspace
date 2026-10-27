-- Generated from ChapterQgOuterFockFullFL.lean — solution of BookProof.QgOuterFockFullFL.qgSectorHam_commForm_le
import Mathlib
import Definitions.Def_ChapterQgOuterFockFullFL
import Theorems.Thm_BookProof_QgOuterFockFullFL_qgSector_gradFun_le
import Theorems.Thm_BookProof_SqSumFarisLavine_commForm_sqSumOp_le
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
theorem solution (n : ℕ) (u : polyGaussCore (d := n * 84)) :
    |commForm (qgSectorHam n) harmCore u| ≤ qgFLc * quadForm harmCore u := by

  rw [qgSectorHam, qgFLc]
  exact commForm_sqSumOp_le (km := 1 / 16) (M := 128) (by norm_num)
    (qgKappaN_abs_le n) (by norm_num) (qgSector_gradFun_le n) u
