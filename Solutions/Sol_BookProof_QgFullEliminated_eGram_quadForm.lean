-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.eGram_quadForm
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
import Theorems.Thm_BookProof_QgFullEliminated_gram_quadForm
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
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgVielbeinScalaronGaugeFL BookProof.QgFourierElim

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : Mom) (z : EComp → ℂ) :
    ∑ c : EComp, ∑ d : EComp, (starRingEnd ℂ) (z c) * (eGram (k, c) (k, d) * z d)
      = ∑ F : FormIdx, (starRingEnd ℂ) (eFormValue k F z) * eFormValue k F z := by

  have h : ∀ c d : EComp, eGram (k, c) (k, d)
      = ∑ F : FormIdx, (starRingEnd ℂ) (elimCoef k F c) * elimCoef k F d := by
    intro c d
    simp [eGram]
  simp only [h, eFormValue]
  exact gram_quadForm (X := EComp) (elimCoef k) z
