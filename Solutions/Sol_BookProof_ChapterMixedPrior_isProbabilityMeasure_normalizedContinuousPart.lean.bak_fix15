-- Generated from ChapterMixedPrior.lean — solution of BookProof.ChapterMixedPrior.isProbabilityMeasure_normalizedContinuousPart
import Mathlib
import Definitions.Def_ChapterMixedPrior
open BookProof.ChapterMixedPrior



open MeasureTheory ProbabilityTheory


open BookProof.ChapterAtomicDecomposition

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

set_option maxHeartbeats 1000000 in
theorem solution (mu : Measure X)
    [IsFiniteMeasure mu] (h : ¬ IsPurelyAtomic mu) :
    IsProbabilityMeasure (normalizedContinuousPart mu) := cond_isProbabilityMeasure h
