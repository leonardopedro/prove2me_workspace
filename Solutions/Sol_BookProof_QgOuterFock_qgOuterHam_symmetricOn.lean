-- Generated from ChapterQgOuterFockEsa.lean — solution of BookProof.QgOuterFock.qgOuterHam_symmetricOn
import Mathlib
import Definitions.Def_ChapterQgOuterFockEsa
import Theorems.Thm_BookProof_QgOuterFock_qgSectorHam_symmetricOn
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
theorem solution : SymmetricOn qgOuterCore qgOuterHam := dsOp_symmetricOn _ fun n => qgSectorHam_symmetricOn n
