-- Generated from ChapterAtomicDecomposition.lean — theorem BookProof.ChapterAtomicDecomposition.not_continuousPart_zero_and_atoms_empty
import Mathlib
import Definitions.Def_ChapterAtomicDecomposition
open BookProof.ChapterAtomicDecomposition


open MeasureTheory


variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]


theorem BookProof.ChapterAtomicDecomposition.not_continuousPart_zero_and_atoms_empty (mu : Measure X) [IsProbabilityMeasure mu] :
    ¬ (continuousPart mu = 0 ∧ atoms mu = ∅) := by sorry
