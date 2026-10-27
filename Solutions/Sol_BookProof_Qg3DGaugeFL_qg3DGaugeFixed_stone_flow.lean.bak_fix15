-- Generated from ChapterQg3DGaugeFarisLavine.lean — solution of BookProof.Qg3DGaugeFL.qg3DGaugeFixed_stone_flow
import Mathlib
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Theorems.Thm_BookProof_Qg3DGaugeFL_qg3DGaugeFixed_esa_fl
import Theorems.Thm_BookProof_QgOuterFock_sqSumOp_symmetricOn
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
open BookProof.Qg3DGaugeFL




open BookProof.QuantumGravity3DGauge BookProof.Qg3DGaugeEsa
open BookProof.QgOuterFock BookProof.FarisLavineOnly
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (T : UnboundedSelfAdjoint (L2d 84)) (U : ℝ → (L2d 84 →L[ℂ] L2d 84)),
      IsSelfAdjointExtension qg3DGaugeFixedHam T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ polyGaussCore_dense (sqSumOp_symmetricOn _ _)
      qg3DGaugeFixed_esa_fl
