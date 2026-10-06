-- Generated from ChapterAtomicDecomposition.lean — solution of BookProof.ChapterAtomicDecomposition.five_types_pairwise_exclusive
import Mathlib
import Definitions.Def_ChapterAtomicDecomposition
open BookProof.ChapterAtomicDecomposition



open MeasureTheory


variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

set_option maxHeartbeats 1000000 in
theorem solution (mu : Measure X) :
    ¬ ((atoms mu).Finite ∧ (atoms mu).Infinite) ∧
      ¬ ((atoms mu = ∅) ∧ (atoms mu).Nonempty) ∧
      ¬ ((atoms mu = ∅) ∧ (atoms mu).Infinite) ∧
      ¬ (continuousPart mu = 0 ∧ continuousPart mu ≠ 0) := by

  refine ⟨fun h => h.2 h.1, fun h => ?_, fun h => ?_, fun h => h.2 h.1⟩
  · obtain ⟨x, hx⟩ := h.2
    rw [h.1] at hx
    exact hx
  · exact h.2 (by rw [h.1]; exact Set.finite_empty)
