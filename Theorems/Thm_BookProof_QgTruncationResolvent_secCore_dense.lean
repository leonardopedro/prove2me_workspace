-- Generated from ChapterQgTruncationResolvent.lean — theorem BookProof.QgTruncationResolvent.secCore_dense
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
open BookProof.QgTruncationResolvent

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {ι : Type*}
variable (W : WallPot) (Q : QgModeData ι)



open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.QgOuterFockCoreFL BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.QgTruncationResolvent.secCore_dense :
    Dense ((secCore (ι := ι) : Submodule ℂ (Sec ι)) : Set (Sec ι)) := by sorry
