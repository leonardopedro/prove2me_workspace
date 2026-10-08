-- Generated from ChapterMixedPrior.lean — theorem BookProof.ChapterMixedPrior.exists_continuous_prior_beyond_atomic
import Definitions.Def_ChapterAtomicDecomposition
import Mathlib
import Definitions.Def_ChapterMixedPrior
open BookProof.ChapterMixedPrior


open MeasureTheory ProbabilityTheory


open BookProof.ChapterAtomicDecomposition

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]


theorem BookProof.ChapterMixedPrior.exists_continuous_prior_beyond_atomic (mu : Measure X) [IsProbabilityMeasure mu]
    (h : ¬ IsPurelyAtomic mu) :
    ∃ nu : Measure X, IsProbabilityMeasure nu ∧ NullSingletonClass nu ∧ ¬ IsPurelyAtomic nu := by sorry
