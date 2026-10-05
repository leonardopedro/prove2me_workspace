-- Generated from ChapterG2.lean — theorem BookProof.ChapterG2.no_translation_invariant_probabilityMeasure
import Mathlib
import Definitions.Def_ChapterG2
open BookProof.ChapterG2

variable {Ω : Type*} [MeasurableSpace Ω]


open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

theorem BookProof.ChapterG2.no_translation_invariant_probabilityMeasure {G : Type*} [Group G]
    [Countable G] [Infinite G] [MeasurableSpace G] [MeasurableSingletonClass G] :
    ¬ ∃ μ : Measure G, IsProbabilityMeasure μ ∧ ∀ g x : G, μ {g * x} = μ {x} := by sorry
