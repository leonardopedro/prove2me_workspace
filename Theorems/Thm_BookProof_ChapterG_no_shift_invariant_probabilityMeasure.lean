-- Generated from ChapterG.lean — theorem BookProof.ChapterG.no_shift_invariant_probabilityMeasure
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG


open scoped ComplexConjugate InnerProductSpace Matrix
open MeasureTheory

theorem BookProof.ChapterG.no_shift_invariant_probabilityMeasure :
    ¬ ∃ μ : Measure ℤ, IsProbabilityMeasure μ ∧
      ∀ s : Set ℤ, μ ((· + 1) ⁻¹' s) = μ s := by sorry
