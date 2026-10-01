-- Generated from ChapterQgTruncationResolvent.lean — solution of BookProof.QgTruncationResolvent.truncModes_nbr
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
open BookProof.QgTruncationResolvent




open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.QgOuterFockCoreFL BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (Q : QgModeData ι) (Λ : Set ι) :
    (truncModes Q Λ).nbr = Q.nbr := rfl
