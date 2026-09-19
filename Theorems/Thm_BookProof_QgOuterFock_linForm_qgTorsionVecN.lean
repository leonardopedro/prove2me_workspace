-- Generated from ChapterQgOuterFockEsa.lean — theorem BookProof.QgOuterFock.linForm_qgTorsionVecN
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

theorem BookProof.QgOuterFock.linForm_qgTorsionVecN {n : ℕ} (p : Fin n) (m : Fin 64) :
    linForm (qgTorsionVecN n (p, m))
      = X (pcoord p (torsionIdx1 m)) - X (pcoord p (torsionIdx2 m)) := by sorry
