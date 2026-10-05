-- Generated from ChapterQgOuterFockFullFL.lean — solution of BookProof.QgOuterFockFullFL.qgSector_gradFun_le
import Mathlib
import Definitions.Def_ChapterQgOuterFockFullFL
import Theorems.Thm_BookProof_SqSumFarisLavine_sum_gradFun_sq_le_of_schur
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
theorem solution (n : ℕ) (x : Vd (n * 84)) :
    ∑ k : Fin (n * 84), (gradFun (qgTorsionVecN n) k x) ^ 2 ≤ (128 : ℝ) ^ 2 * ‖x‖ ^ 2 := by

  have h := sum_gradFun_sq_le_of_schur (a := 2) (b := 64) (by norm_num) (by norm_num)
    (qgTorsionVecN_row_le n) (qgTorsionVecN_col_le n) x
  norm_num at h ⊢
  exact h
