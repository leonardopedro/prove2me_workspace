-- Generated from ChapterAtomicDecomposition.lean — theorem BookProof.ChapterAtomicDecomposition.five_types_pairwise_exclusive
import Mathlib
import Definitions.Def_ChapterAtomicDecomposition
open BookProof.ChapterAtomicDecomposition

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]


open MeasureTheory



theorem BookProof.ChapterAtomicDecomposition.five_types_pairwise_exclusive (mu : Measure X) :
    ¬ ((atoms mu).Finite ∧ (atoms mu).Infinite) ∧
      ¬ ((atoms mu = ∅) ∧ (atoms mu).Nonempty) ∧
      ¬ ((atoms mu = ∅) ∧ (atoms mu).Infinite) ∧
      ¬ (continuousPart mu = 0 ∧ continuousPart mu ≠ 0) := by sorry
