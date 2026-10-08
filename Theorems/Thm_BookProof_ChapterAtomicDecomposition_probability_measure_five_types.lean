-- Generated from ChapterAtomicDecomposition.lean — theorem BookProof.ChapterAtomicDecomposition.probability_measure_five_types
import Mathlib
import Definitions.Def_ChapterAtomicDecomposition
open BookProof.ChapterAtomicDecomposition


open MeasureTheory


variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]


theorem BookProof.ChapterAtomicDecomposition.probability_measure_five_types (mu : Measure X) [IsProbabilityMeasure mu] :
    (continuousPart mu = 0 ∧ (atoms mu).Finite ∧ (atoms mu).Nonempty) ∨
    (continuousPart mu = 0 ∧ (atoms mu).Infinite) ∨
    (continuousPart mu ≠ 0 ∧ atoms mu = ∅) ∨
    (continuousPart mu ≠ 0 ∧ (atoms mu).Finite ∧ (atoms mu).Nonempty) ∨
    (continuousPart mu ≠ 0 ∧ (atoms mu).Infinite) := by sorry
