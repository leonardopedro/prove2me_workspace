-- Generated from ChapterMixedPrior.lean — solution of BookProof.ChapterMixedPrior.continuousPart_eq_zero_of_isPurelyAtomic
import Mathlib
import Definitions.Def_ChapterMixedPrior
open BookProof.ChapterMixedPrior



open MeasureTheory ProbabilityTheory


open BookProof.ChapterAtomicDecomposition

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

set_option maxHeartbeats 1000000 in
theorem solution {mu : Measure X} (h : IsPurelyAtomic mu) :
    continuousPart mu = 0 := Measure.restrict_eq_zero.2 h
