-- Generated from ChapterQgFullEliminated.lean — theorem BookProof.QgFullEliminated.gram_quadForm
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgVielbeinModeInstance
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterQgFourierElimination
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
open BookProof.QgFullEliminated



open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgVielbeinScalaronGaugeFL BookProof.QgFourierElim

noncomputable section

theorem BookProof.QgFullEliminated.gram_quadForm {X : Type*} [Fintype X] (C : FormIdx → X → ℂ) (z : X → ℂ) :
    ∑ c : X, ∑ d : X,
        (starRingEnd ℂ) (z c) * ((∑ F : FormIdx, (starRingEnd ℂ) (C F c) * C F d) * z d)
      = ∑ F : FormIdx, (starRingEnd ℂ) (∑ c : X, C F c * z c) * (∑ d : X, C F d * z d) := by sorry
