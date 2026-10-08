-- Generated from ChapterAtomicDecomposition.lean — theorem BookProof.ChapterAtomicDecomposition.measurableSet_atoms
import Mathlib
import Definitions.Def_ChapterAtomicDecomposition
open BookProof.ChapterAtomicDecomposition


open MeasureTheory


variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]


theorem BookProof.ChapterAtomicDecomposition.measurableSet_atoms (mu : Measure X) [SFinite mu] : MeasurableSet (atoms mu) := by sorry
