-- Generated from ChapterQg3DGaugeFarisLavine.lean — solution of BookProof.Qg3DGaugeFL.qgGauge_outerHam_esa_fl
import Mathlib
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Theorems.Thm_BookProof_Qg3DGaugeFL_qgGauge_sector_esa_fl
import Theorems.Thm_BookProof_DirectSumEsa_dsOp_essentiallySelfAdjointOn
open BookProof.Qg3DGaugeFL




open BookProof.QuantumGravity3DGauge BookProof.Qg3DGaugeEsa
open BookProof.QgOuterFock BookProof.FarisLavineOnly
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : EssentiallySelfAdjointOn qgOuterCore qgGaugeOuterHam := dsOp_essentiallySelfAdjointOn _ fun n => qgGauge_sector_esa_fl n
