-- Generated from ChapterQg3DGaugeFarisLavine.lean — solution of BookProof.Qg3DGaugeFL.qgGauge_stone_flow
import Mathlib
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Theorems.Thm_BookProof_Qg3DGaugeFL_qgGauge_outerHam_esa_fl
import Theorems.Thm_BookProof_Qg3DGaugeFL_qgGaugeOuterHam_symmetricOn
import Theorems.Thm_BookProof_QgOuterFock_qgOuterCore_dense
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
    ∃ (T : UnboundedSelfAdjoint qgOuterFock) (U : ℝ → (qgOuterFock →L[ℂ] qgOuterFock)),
      IsSelfAdjointExtension qgGaugeOuterHam T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ qgOuterCore_dense qgGaugeOuterHam_symmetricOn
      qgGauge_outerHam_esa_fl
