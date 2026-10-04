-- Generated from ChapterQgFullEliminated.lean — theorem BookProof.QgFullEliminated.elimCoef_torsion_ne_zero
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterScalaronCoreEsa
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
import Definitions.Def_ChapterA4
open BookProof.QgFullEliminated



open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa

noncomputable section

theorem BookProof.QgFullEliminated.elimCoef_torsion_ne_zero (k : Mom) (hk : k 0 ≠ 0) :
    elimCoef k (torsionF 0 1 0) ((1, 0) : EComp) ≠ 0 := by sorry
