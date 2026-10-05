-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.eGram_quadForm
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
import Theorems.Thm_BookProof_QgFullEliminated_gram_quadForm
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgFourierElim

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
