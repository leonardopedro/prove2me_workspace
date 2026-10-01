-- Generated from ChapterQgTruncationResolvent.lean — theorem BookProof.QgTruncationResolvent.esa_core_of_ext
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

theorem BookProof.QgTruncationResolvent.esa_core_of_ext (d : CoreData F) (hesa : EssentiallySelfAdjointOn d.C.dom d.ext) :
    EssentiallySelfAdjointOn d.C₀ d.H₀ := by sorry
