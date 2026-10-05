-- Generated from ChapterQg3DGaugeFarisLavine.lean — theorem BookProof.Qg3DGaugeFL.qgSigned_eq_sqSumOp
import Definitions.Def_ChapterFarisLavineOnly
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterYangMillsHermite
open BookProof.FullQuadratic
open BookProof.HermiteProductCore
open BookProof.Qg3DGaugeEsa
open BookProof.QgOuterFock
open BookProof.QuantumGravity3DGauge
open BookProof.YangMillsHermite
open BookProof.Qg3DGaugeFL



open BookProof.QuantumGravity3DGauge BookProof.Qg3DGaugeEsa
open BookProof.QgOuterFock BookProof.FarisLavineOnly
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

theorem BookProof.Qg3DGaugeFL.qgSigned_eq_sqSumOp (kappa : Fin 84 → ℝ) :
    signedOp kappa (qgMom (coreRepPoly 84)) (torsionOps (coreRepPoly 84))
      = sqSumOp kappa torsionVec := by sorry
