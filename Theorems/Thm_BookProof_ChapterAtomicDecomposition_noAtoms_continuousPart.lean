-- Generated from ChapterAtomicDecomposition.lean — theorem BookProof.ChapterAtomicDecomposition.noAtoms_continuousPart
import Mathlib
import Definitions.Def_ChapterAtomicDecomposition
open BookProof.ChapterAtomicDecomposition

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]


open MeasureTheory



theorem BookProof.ChapterAtomicDecomposition.noAtoms_continuousPart (mu : Measure X) [SFinite mu] : NullSingletonClass (continuousPart mu) := by sorry
