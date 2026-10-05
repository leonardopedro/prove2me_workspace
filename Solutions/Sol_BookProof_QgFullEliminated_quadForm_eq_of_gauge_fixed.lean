-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.quadForm_eq_of_gauge_fixed
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
import Theorems.Thm_BookProof_QgFullEliminated_eFormValue_eq_formValue_elimConfig
import Theorems.Thm_BookProof_QgFullEliminated_eGram_quadForm
import Theorems.Thm_BookProof_QgFullEliminated_gGram_quadForm
import Theorems.Thm_BookProof_QgFourierElim_eq_elimConfig_of_gauge_fixed
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgFourierElim

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : Mom) (w : Comp → ℂ)
    (hgauge : ∀ mu nu i, formValue k (dGaugeF mu nu i) w = 0) :
    ∑ c : Comp, ∑ d : Comp, (starRingEnd ℂ) (w c) * (gGram (k, c) (k, d) * w d)
      = ∑ c : EComp, ∑ d : EComp,
          (starRingEnd ℂ) (w (eIdx c.1 c.2)) *
            (eGram (k, c) (k, d) * w (eIdx d.1 d.2)) := by

  set z : EComp → ℂ := fun p => w (eIdx p.1 p.2) with hz
  have hw : w = elimConfig k z := eq_elimConfig_of_gauge_fixed k w hgauge
  rw [gGram_quadForm k w, eGram_quadForm k z]
  refine Finset.sum_congr rfl fun F _ => ?_
  rw [hw, eFormValue_eq_formValue_elimConfig]
