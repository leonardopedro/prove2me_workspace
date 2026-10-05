-- Generated from ChapterQgTruncationResolvent.lean — solution of BookProof.QgTruncationResolvent.secCore_dense
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
import Theorems.Thm_BookProof_ScalaronEsa_ccDomain_dense
open BookProof.QgTruncationResolvent




open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.QgOuterFockCoreFL BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution :
    Dense ((secCore (ι := dsCore_dense fun _ => ccDomain_dense
