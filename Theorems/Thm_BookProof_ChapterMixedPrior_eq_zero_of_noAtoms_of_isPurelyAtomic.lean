-- Generated from ChapterMixedPrior.lean — theorem BookProof.ChapterMixedPrior.eq_zero_of_noAtoms_of_isPurelyAtomic
import Mathlib
import Definitions.Def_ChapterMixedPrior
import Definitions.Def_ChapterAtomicDecomposition
open BookProof.ChapterAtomicDecomposition
open BookProof.ChapterMixedPrior

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]


open MeasureTheory ProbabilityTheory


open BookProof.ChapterAtomicDecomposition


theorem BookProof.ChapterMixedPrior.eq_zero_of_noAtoms_of_isPurelyAtomic (mu : Measure X) [NullSingletonClass mu]
    (h : IsPurelyAtomic mu) : mu = 0 := by sorry
