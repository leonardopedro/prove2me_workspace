-- Generated from ChapterQgOuterFockFullFL.lean — solution of BookProof.QgOuterFockFullFL.qgSectorHam_commForm_le
import Mathlib
import Definitions.Def_ChapterQgOuterFockFullFL
import Theorems.Thm_BookProof_QgOuterFockFullFL_qgSector_gradFun_le
import Theorems.Thm_BookProof_SqSumFarisLavine_commForm_sqSumOp_le
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterSqSumFarisLavine
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterQgOuterFockEsa
open BookProof.QgOuterFockFullFL




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.Qg3DGaugeEsa BookProof.QuantumGravity3DGauge
open BookProof.GaussCoreQuadBounds BookProof.SqSumFarisLavine
open Filter Topology
open BookProof.HermiteProductCore
open BookProof.QgHermiteOscillator
open BookProof.QgOuterFock

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (u : polyGaussCore (d := n * 84)) :
    |commForm (qgSectorHam n) harmCore u| ≤ qgFLc * quadForm harmCore u := by

  rw [qgSectorHam, qgFLc]
  exact commForm_sqSumOp_le (km := 1 / 16) (M := 128) (by norm_num)
    (qgKappaN_abs_le n) (by norm_num) (qgSector_gradFun_le n) u
