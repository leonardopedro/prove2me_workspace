-- Generated from ChapterAtomicDecomposition.lean — theorem BookProof.ChapterAtomicDecomposition.eq_continuousPart_add_atomicPart
import Mathlib
import Definitions.Def_ChapterAtomicDecomposition
open BookProof.ChapterAtomicDecomposition


open MeasureTheory


variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]


theorem BookProof.ChapterAtomicDecomposition.eq_continuousPart_add_atomicPart (mu : Measure X) [SFinite mu] :
    mu = continuousPart mu + atomicPart mu := by sorry
