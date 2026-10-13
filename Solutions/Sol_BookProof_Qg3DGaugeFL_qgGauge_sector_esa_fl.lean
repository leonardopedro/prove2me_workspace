-- Generated from ChapterQg3DGaugeFarisLavine.lean — solution of BookProof.Qg3DGaugeFL.qgGauge_sector_esa_fl
import Mathlib
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Theorems.Thm_BookProof_FarisLavineOnly_sqSumOp_esa_farisLavine
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterFarisLavineOnly
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockEsa
open BookProof.Qg3DGaugeFL




open BookProof.QuantumGravity3DGauge BookProof.Qg3DGaugeEsa
open BookProof.QgOuterFock BookProof.FarisLavineOnly
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.HermiteProductCore
open BookProof.QgOuterFock

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := n * 84)) (qgGaugeSectorHam n) := sqSumOp_esa_farisLavine _ _
