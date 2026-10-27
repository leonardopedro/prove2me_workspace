-- Generated from ChapterMixedPrior.lean — solution of BookProof.ChapterMixedPrior.atomless_prior_not_purelyAtomic
import Mathlib
import Definitions.Def_ChapterMixedPrior
import Theorems.Thm_BookProof_ChapterMixedPrior_eq_zero_of_noAtoms_of_isPurelyAtomic
open BookProof.ChapterMixedPrior



open MeasureTheory ProbabilityTheory


open BookProof.ChapterAtomicDecomposition

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

set_option maxHeartbeats 1000000 in
theorem solution (mu : Measure X) [IsProbabilityMeasure mu]
    [NullSingletonClass mu] : ¬ IsPurelyAtomic mu := by

  intro h
  have hzero := eq_zero_of_noAtoms_of_isPurelyAtomic mu h
  have : (1 : ENNReal) = 0 := by rw [← measure_univ (μ := mu), hzero]; simp
  exact one_ne_zero this
