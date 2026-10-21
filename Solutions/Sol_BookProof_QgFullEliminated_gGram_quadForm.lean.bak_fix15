-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.gGram_quadForm
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
import Theorems.Thm_BookProof_QgFullEliminated_gram_quadForm
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgVielbeinScalaronGaugeFL BookProof.QgFourierElim

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : Mom) (w : Comp → ℂ) :
    ∑ c : Comp, ∑ d : Comp, (starRingEnd ℂ) (w c) * (gGram (k, c) (k, d) * w d)
      = ∑ F : FormIdx, (starRingEnd ℂ) (formValue k F w) * formValue k F w := by

  have h : ∀ c d : Comp, gGram ((k, c) : GMode) (k, d)
      = ∑ F : FormIdx, (starRingEnd ℂ) (gCoef k F c) * gCoef k F d := by
    intro c d
    simp [gGram]
  simp only [h, formValue]
  exact gram_quadForm (X := Comp) (gCoef k) w
