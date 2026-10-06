-- Generated from ChapterAtomicDecomposition.lean — solution of BookProof.ChapterAtomicDecomposition.not_continuousPart_zero_and_atoms_empty
import Mathlib
import Definitions.Def_ChapterAtomicDecomposition
import Theorems.Thm_BookProof_ChapterAtomicDecomposition_eq_continuousPart_add_atomicPart
open BookProof.ChapterAtomicDecomposition



open MeasureTheory


variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

set_option maxHeartbeats 1000000 in
theorem solution (mu : Measure X) [IsProbabilityMeasure mu] :
    ¬ (continuousPart mu = 0 ∧ atoms mu = ∅) := by

  rintro ⟨hc, ha⟩
  have hzero : mu = 0 := by
    rw [eq_continuousPart_add_atomicPart mu, hc, atomicPart, ha]
    simp
  have : (1 : ENNReal) = 0 := by
    rw [← measure_univ (μ := mu), hzero]; simp
  exact one_ne_zero this
