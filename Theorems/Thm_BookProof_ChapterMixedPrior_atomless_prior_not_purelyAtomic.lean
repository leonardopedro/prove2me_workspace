-- Generated from ChapterMixedPrior.lean — theorem BookProof.ChapterMixedPrior.atomless_prior_not_purelyAtomic
import Definitions.Def_ChapterAtomicDecomposition
import Mathlib
import Definitions.Def_ChapterMixedPrior
open BookProof.ChapterMixedPrior

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]


open MeasureTheory ProbabilityTheory


open BookProof.ChapterAtomicDecomposition


theorem BookProof.ChapterMixedPrior.atomless_prior_not_purelyAtomic (mu : Measure X) [IsProbabilityMeasure mu]
    [NullSingletonClass mu] : ¬ IsPurelyAtomic mu := by sorry
