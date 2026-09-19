-- Generated from ChapterQgOuterFockEsa.lean — solution of BookProof.QgOuterFock.qgOuterN_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterQgOuterFockEsa
import Theorems.Thm_BookProof_QgOuterFock_dsOp_quadForm_nonneg
import Theorems.Thm_BookProof_QgHermiteOscillator_harmonicCore_quadForm_nonneg
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
theorem solution (x : qgOuterCore) : 0 ≤ quadForm qgOuterN x := dsOp_quadForm_nonneg _ (fun _ u => harmonicCore_quadForm_nonneg u) x
