-- Generated from ChapterAtomicDecomposition.lean — solution of BookProof.ChapterAtomicDecomposition.noAtoms_continuousPart
import Mathlib
import Definitions.Def_ChapterAtomicDecomposition
open BookProof.ChapterAtomicDecomposition



open MeasureTheory


variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

set_option maxHeartbeats 1000000 in
theorem solution (mu : Measure X) [SFinite mu] : NullSingletonClass (continuousPart mu) := by

  constructor
  intro x
  rcases eq_or_ne (mu {x}) 0 with h | h
  · exact le_antisymm ((Measure.restrict_apply_le _ _).trans (le_of_eq h)) zero_le
  · have hxA : x ∈ atoms mu := pos_iff_ne_zero.mpr h
    rw [continuousPart, Measure.restrict_apply (measurableSet_singleton x)]
    have hempty : ({x} : Set X) ∩ (atoms mu)ᶜ = ∅ := by
      ext y
      simp only [Set.mem_inter_iff, Set.mem_singleton_iff, Set.mem_compl_iff,
        Set.mem_empty_iff_false, iff_false, not_and, not_not]
      rintro rfl; exact hxA
    simp [hempty]
