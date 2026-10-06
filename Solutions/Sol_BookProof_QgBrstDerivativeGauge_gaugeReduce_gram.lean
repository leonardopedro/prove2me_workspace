-- Generated from ChapterQgBrstDerivativeGauge.lean — solution of BookProof.QgBrstDerivativeGauge.gaugeReduce_gram
import Mathlib
import Definitions.Def_ChapterQgBrstDerivativeGauge
import Theorems.Thm_BookProof_QgBrstDerivativeGauge_gaugeReduce_extTorsionCoef
open BookProof.QgBrstDerivativeGauge




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x y : CMode) (h : x.1 = y.1) :
    ∑ mu : Fin 3, ∑ nu : Fin 3, ∑ i : Fin 3,
        (starRingEnd ℂ) (gaugeReduce (extTorsionCoef x.1 mu nu i) x)
          * gaugeReduce (extTorsionCoef x.1 mu nu i) y
      = contTorsionGram x y := by

  have hy : y.1 = x.1 := h.symm
  simp only [contTorsionGram, if_pos h]
  refine Finset.sum_congr rfl fun mu _ => Finset.sum_congr rfl fun nu _ =>
    Finset.sum_congr rfl fun i _ => ?_
  rw [gaugeReduce_extTorsionCoef, gaugeReduce_extTorsionCoef, if_pos rfl, if_pos hy]
