-- Generated from ChapterMixedPrior.lean — theorem BookProof.ChapterMixedPrior.noAtoms_normalizedContinuousPart
import Mathlib
import Definitions.Def_ChapterMixedPrior
import Definitions.Def_ChapterAtomicDecomposition
open BookProof.ChapterAtomicDecomposition
open BookProof.ChapterMixedPrior


open MeasureTheory ProbabilityTheory


open BookProof.ChapterAtomicDecomposition

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]


theorem BookProof.ChapterMixedPrior.noAtoms_normalizedContinuousPart (mu : Measure X) [SFinite mu] :
    NullSingletonClass (normalizedContinuousPart mu) := by sorry
