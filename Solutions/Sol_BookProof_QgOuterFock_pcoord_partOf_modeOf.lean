-- Generated from ChapterQgOuterFockEsa.lean — solution of BookProof.QgOuterFock.pcoord_partOf_modeOf
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

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (I : Fin (n * 84)) :
    pcoord (partOf I) (modeOf I) = I := by

  simp only [pcoord, partOf, modeOf, Prod.mk.eta, Equiv.apply_symm_apply]
