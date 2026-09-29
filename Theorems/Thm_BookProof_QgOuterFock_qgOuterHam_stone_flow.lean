-- Generated from ChapterQgOuterFockEsa.lean — theorem BookProof.QgOuterFock.qgOuterHam_stone_flow
import Mathlib
import Definitions.Def_ChapterQgOuterFockEsa
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

theorem BookProof.QgOuterFock.qgOuterHam_stone_flow :
    ∃ (T : UnboundedSelfAdjoint qgOuterFock) (U : ℝ → (qgOuterFock →L[ℂ] qgOuterFock)),
      IsSelfAdjointExtension qgOuterHam T.op ∧ IsStoneFlow T U := by sorry
