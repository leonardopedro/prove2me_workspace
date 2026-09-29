-- Generated from ChapterQgOuterFockEsa.lean — solution of BookProof.QgOuterFock.qgOuterHam_stone_flow
import Mathlib
import Definitions.Def_ChapterQgOuterFockEsa
import Theorems.Thm_BookProof_QgOuterFock_qgOuterCore_dense
import Theorems.Thm_BookProof_QgOuterFock_qgOuterHam_symmetricOn
import Theorems.Thm_BookProof_QgOuterFock_qgOuterFock_esa
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
open BookProof.QgOuterFock




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.Qg3DGaugeEsa
open BookProof.QgHermiteOscillator
open BookProof.DirectSumEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (T : UnboundedSelfAdjoint qgOuterFock) (U : ℝ → (qgOuterFock →L[ℂ] qgOuterFock)),
      IsSelfAdjointExtension qgOuterHam T.op ∧ IsStoneFlow T U := exists_stone_flow_of_esa _ qgOuterCore_dense qgOuterHam_symmetricOn qgOuterFock_esa
