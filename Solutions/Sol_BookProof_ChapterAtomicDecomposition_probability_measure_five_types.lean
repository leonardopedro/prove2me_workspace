-- Generated from ChapterAtomicDecomposition.lean — solution of BookProof.ChapterAtomicDecomposition.probability_measure_five_types
import Mathlib
import Definitions.Def_ChapterAtomicDecomposition
import Theorems.Thm_BookProof_ChapterAtomicDecomposition_not_continuousPart_zero_and_atoms_empty
open BookProof.ChapterAtomicDecomposition



open MeasureTheory


variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

set_option maxHeartbeats 1000000 in
theorem solution (mu : Measure X) [IsProbabilityMeasure mu] :
    (continuousPart mu = 0 ∧ (atoms mu).Finite ∧ (atoms mu).Nonempty) ∨
    (continuousPart mu = 0 ∧ (atoms mu).Infinite) ∨
    (continuousPart mu ≠ 0 ∧ atoms mu = ∅) ∨
    (continuousPart mu ≠ 0 ∧ (atoms mu).Finite ∧ (atoms mu).Nonempty) ∨
    (continuousPart mu ≠ 0 ∧ (atoms mu).Infinite) := by

  by_cases hc : continuousPart mu = 0
  · rcases Set.finite_or_infinite (atoms mu) with hfin | hinf
    · have hne : (atoms mu).Nonempty := by
        rcases Set.eq_empty_or_nonempty (atoms mu) with he | hne
        · exact absurd ⟨hc, he⟩ (not_continuousPart_zero_and_atoms_empty mu)
        · exact hne
      exact Or.inl ⟨hc, hfin, hne⟩
    · exact Or.inr (Or.inl ⟨hc, hinf⟩)
  · rcases Set.eq_empty_or_nonempty (atoms mu) with he | hne
    · exact Or.inr (Or.inr (Or.inl ⟨hc, he⟩))
    · rcases Set.finite_or_infinite (atoms mu) with hfin | hinf
      · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨hc, hfin, hne⟩)))
      · exact Or.inr (Or.inr (Or.inr (Or.inr ⟨hc, hinf⟩)))
