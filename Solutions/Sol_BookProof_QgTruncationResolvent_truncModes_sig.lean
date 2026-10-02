-- Generated from ChapterQgTruncationResolvent.lean — solution of BookProof.QgTruncationResolvent.truncModes_sig
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent




open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (Q : QgModeData ι) (Λ : Set ι) :
    (truncModes Q Λ).sig = Q.sig := rfl
