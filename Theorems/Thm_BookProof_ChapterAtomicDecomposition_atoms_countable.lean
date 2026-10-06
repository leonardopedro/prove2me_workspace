-- Generated from ChapterAtomicDecomposition.lean — theorem BookProof.ChapterAtomicDecomposition.atoms_countable
import Mathlib
import Definitions.Def_ChapterAtomicDecomposition
open BookProof.ChapterAtomicDecomposition

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]


open MeasureTheory



theorem BookProof.ChapterAtomicDecomposition.atoms_countable (mu : Measure X) [SFinite mu] : (atoms mu).Countable := by sorry
