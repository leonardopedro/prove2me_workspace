-- Generated from ChapterAtomicDecomposition.lean — theorem BookProof.ChapterAtomicDecomposition.atomicPart_eq_sum_dirac
import Mathlib
import Definitions.Def_ChapterAtomicDecomposition
open BookProof.ChapterAtomicDecomposition

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]


open MeasureTheory



theorem BookProof.ChapterAtomicDecomposition.atomicPart_eq_sum_dirac (mu : Measure X) [SFinite mu] :
    atomicPart mu = Measure.sum (fun x : atoms mu => mu {(x : X)} • Measure.dirac (x : X)) := by sorry
