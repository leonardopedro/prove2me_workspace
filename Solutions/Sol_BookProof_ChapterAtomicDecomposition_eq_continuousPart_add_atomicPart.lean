-- Generated from ChapterAtomicDecomposition.lean — solution of BookProof.ChapterAtomicDecomposition.eq_continuousPart_add_atomicPart
import Mathlib
import Definitions.Def_ChapterAtomicDecomposition
import Theorems.Thm_BookProof_ChapterAtomicDecomposition_measurableSet_atoms
open BookProof.ChapterAtomicDecomposition



open MeasureTheory


variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

set_option maxHeartbeats 1000000 in
theorem solution (mu : Measure X) [SFinite mu] :
    mu = continuousPart mu + atomicPart mu := by

  rw [continuousPart, atomicPart, add_comm]
  exact (Measure.restrict_add_restrict_compl (measurableSet_atoms mu)).symm
