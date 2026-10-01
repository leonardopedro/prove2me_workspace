-- Generated from ChapterQg3DGaugeEsa.lean — solution of BookProof.Qg3DGaugeEsa.qgSigned_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterQg3DGaugeEsa
import Theorems.Thm_BookProof_Qg3DGaugeEsa_qgSigned_eq_fqOp
import Theorems.Thm_BookProof_FullQuadratic_fqOp_essentiallySelfAdjoint
open BookProof.Qg3DGaugeEsa




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (kappa : Fin 84 → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 84))
      (signedOp kappa (qgMom (coreRepPoly 84)) (torsionOps (coreRepPoly 84))) := by

  rw [qgSigned_eq_fqOp kappa]
  exact fqOp_essentiallySelfAdjoint (qgFqP kappa) qgFqQ 0 0 0
