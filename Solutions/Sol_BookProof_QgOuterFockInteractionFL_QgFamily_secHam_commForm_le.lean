-- Generated from ChapterQgOuterFockInteractionFL.lean — solution of BookProof.QgOuterFockInteractionFL.QgFamily.secHam_commForm_le
import Mathlib
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Theorems.Thm_BookProof_SqSumFarisLavine_commForm_sqSumOp_le
import Theorems.Thm_BookProof_SqSumFarisLavine_sum_gradFun_sq_le_of_schur
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterQgOuterFockFullFL
import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterMajoranaClifford
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterSqSumFarisLavine
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
open BookProof.HermiteProductCore
open BookProof.MajoranaClifford
open BookProof.QgHermiteOscillator
open BookProof.QgOuterFock
open BookProof.SqSumFarisLavine

noncomputable section

variable (F : QgFamily)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (u : polyGaussCore (d := n * 84)) :
    |commForm (F.secHam n) harmCore u| ≤ F.flc * quadForm harmCore u := by

  have hM : ∀ x : Vd (n * 84),
      ∑ k : Fin (n * 84), (gradFun (F.vv n) k x) ^ 2 ≤ (F.a * F.b) ^ 2 * ‖x‖ ^ 2 :=
    fun x => sum_gradFun_sq_le_of_schur F.a_nonneg F.b_nonneg (F.row_le n) (F.col_le n) x
  have heq : F.km / 2 + 2 * (F.a * F.b) = F.flc := by rw [flc]
  rw [secHam, ← heq]
  exact commForm_sqSumOp_le F.km_nonneg (F.kap_le n) F.ab_nonneg hM u
