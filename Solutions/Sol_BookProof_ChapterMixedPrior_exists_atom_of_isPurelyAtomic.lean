-- Generated from ChapterMixedPrior.lean — solution of BookProof.ChapterMixedPrior.exists_atom_of_isPurelyAtomic
import Mathlib
import Definitions.Def_ChapterMixedPrior
open BookProof.ChapterMixedPrior



open MeasureTheory ProbabilityTheory


open BookProof.ChapterAtomicDecomposition

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

set_option maxHeartbeats 1000000 in
theorem solution (mu : Measure X) [IsProbabilityMeasure mu]
    (h : IsPurelyAtomic mu) : (atoms mu).Nonempty := by

  by_contra hempty
  rw [Set.not_nonempty_iff_eq_empty] at hempty
  rw [IsPurelyAtomic, hempty, Set.compl_empty] at h
  have : (1 : ENNReal) = 0 := by rw [← measure_univ (μ := mu)]; exact h
  exact one_ne_zero this
