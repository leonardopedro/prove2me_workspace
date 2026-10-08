-- Generated from ChapterMixedPrior.lean — theorem BookProof.ChapterMixedPrior.exists_atom_of_isPurelyAtomic
import Mathlib
import Definitions.Def_ChapterMixedPrior
import Definitions.Def_ChapterAtomicDecomposition
open BookProof.ChapterAtomicDecomposition
open BookProof.ChapterMixedPrior


open MeasureTheory ProbabilityTheory


open BookProof.ChapterAtomicDecomposition

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]


theorem BookProof.ChapterMixedPrior.exists_atom_of_isPurelyAtomic (mu : Measure X) [IsProbabilityMeasure mu]
    (h : IsPurelyAtomic mu) : (atoms mu).Nonempty := by sorry
