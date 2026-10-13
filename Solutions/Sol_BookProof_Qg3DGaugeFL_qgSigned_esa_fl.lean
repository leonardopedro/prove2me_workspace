-- Generated from ChapterQg3DGaugeFarisLavine.lean — solution of BookProof.Qg3DGaugeFL.qgSigned_esa_fl
import Mathlib
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Theorems.Thm_BookProof_Qg3DGaugeFL_qgSigned_eq_sqSumOp
import Theorems.Thm_BookProof_FarisLavineOnly_sqSumOp_esa_farisLavine
import Definitions.Def_ChapterFarisLavineOnly
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterYangMillsHermite
open BookProof.Qg3DGaugeFL




open BookProof.QuantumGravity3DGauge BookProof.Qg3DGaugeEsa
open BookProof.QgOuterFock BookProof.FarisLavineOnly
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.HermiteProductCore
open BookProof.Qg3DGaugeEsa
open BookProof.QgOuterFock
open BookProof.QuantumGravity3DGauge

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (kappa : Fin 84 → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 84))
      (signedOp kappa (qgMom (coreRepPoly 84)) (torsionOps (coreRepPoly 84))) := by

  rw [qgSigned_eq_sqSumOp kappa]
  exact sqSumOp_esa_farisLavine kappa torsionVec
