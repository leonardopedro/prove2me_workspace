-- Generated from ChapterQgFullEliminated.lean — theorem BookProof.QgFullEliminated.eGram_eq_torsion_add_gauge3d
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

theorem BookProof.QgFullEliminated.eGram_eq_torsion_add_gauge3d (k : Mom) (c d : EComp) :
    eGram (k, c) (k, d)
      = (∑ mu : Fin 3, ∑ nu : Fin 3, ∑ i : Fin 3,
            (starRingEnd ℂ) (elimCoef k (torsionF mu nu i) c) * elimCoef k (torsionF mu nu i) d)
        + ∑ i : Fin 3,
            (starRingEnd ℂ) (elimCoef k (gauge3dF i) c) * elimCoef k (gauge3dF i) d := by sorry
