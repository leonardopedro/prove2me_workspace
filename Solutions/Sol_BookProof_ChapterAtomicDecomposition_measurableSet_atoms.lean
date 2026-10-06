-- Generated from ChapterAtomicDecomposition.lean — solution of BookProof.ChapterAtomicDecomposition.measurableSet_atoms
import Mathlib
import Definitions.Def_ChapterAtomicDecomposition
import Theorems.Thm_BookProof_ChapterAtomicDecomposition_atoms_countable
open BookProof.ChapterAtomicDecomposition



open MeasureTheory


variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

set_option maxHeartbeats 1000000 in
theorem solution (mu : Measure X) [SFinite mu] : MeasurableSet (atoms mu) := (atoms_countable mu).measurableSet
