-- Generated from ChapterQgTruncationResolvent.lean — theorem BookProof.QgTruncationResolvent.momWindow_exhausts
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterDirectSumEsa
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterA4

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {ι : Type*}
variable (W : WallPot) (Q : QgModeData ι)



open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section


theorem BookProof.QgTruncationResolvent.momWindow_exhausts (F : Finset CMode) :
    ∀ᶠ n : ℕ in atTop, ∀ a ∈ F, a ∈ momWindow n := by sorry
