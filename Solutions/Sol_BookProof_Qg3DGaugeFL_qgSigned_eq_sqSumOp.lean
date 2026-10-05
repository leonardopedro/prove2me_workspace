-- Generated from ChapterQg3DGaugeFarisLavine.lean — solution of BookProof.Qg3DGaugeFL.qgSigned_eq_sqSumOp
import Mathlib
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Theorems.Thm_BookProof_Qg3DGaugeFL_qgFqP_eq_diagP
import Theorems.Thm_BookProof_Qg3DGaugeFL_qgFqQ_eq_gramQ
import Theorems.Thm_BookProof_Qg3DGaugeEsa_qgSigned_eq_fqOp
import Theorems.Thm_BookProof_QgOuterFock_sqSumOp_eq_fqOp
open BookProof.Qg3DGaugeFL




open BookProof.QuantumGravity3DGauge BookProof.Qg3DGaugeEsa
open BookProof.QgOuterFock BookProof.FarisLavineOnly
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (kappa : Fin 84 → ℝ) :
    signedOp kappa (qgMom (coreRepPoly 84)) (torsionOps (coreRepPoly 84))
      = sqSumOp kappa torsionVec := by

  rw [qgSigned_eq_fqOp, sqSumOp_eq_fqOp, qgFqP_eq_diagP, qgFqQ_eq_gramQ]
