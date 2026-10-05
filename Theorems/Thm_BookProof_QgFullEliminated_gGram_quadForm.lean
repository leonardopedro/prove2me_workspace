-- Generated from ChapterQgFullEliminated.lean — theorem BookProof.QgFullEliminated.gGram_quadForm
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
open BookProof.QgFourierElim

noncomputable section

theorem BookProof.QgFullEliminated.gGram_quadForm (k : Mom) (w : Comp → ℂ) :
    ∑ c : Comp, ∑ d : Comp, (starRingEnd ℂ) (w c) * (gGram (k, c) (k, d) * w d)
      = ∑ F : FormIdx, (starRingEnd ℂ) (formValue k F w) * formValue k F w := by sorry
