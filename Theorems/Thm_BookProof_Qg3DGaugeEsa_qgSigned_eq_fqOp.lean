-- Generated from ChapterQg3DGaugeEsa.lean — theorem BookProof.Qg3DGaugeEsa.qgSigned_eq_fqOp
import Mathlib
import Definitions.Def_ChapterQg3DGaugeEsa
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

set_option maxHeartbeats 4000000 in
-- the `L²` coercions of the Gauss–polynomial core make these defeq checks expensive
theorem BookProof.Qg3DGaugeEsa.qgSigned_eq_fqOp (kappa : Fin 84 → ℝ) :
    signedOp kappa (qgMom (coreRepPoly 84)) (torsionOps (coreRepPoly 84))
      = fqOp (qgFqP kappa) qgFqQ 0 0 0 := by sorry
