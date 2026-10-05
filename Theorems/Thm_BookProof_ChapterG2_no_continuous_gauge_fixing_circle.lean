-- Generated from ChapterG2.lean — theorem BookProof.ChapterG2.no_continuous_gauge_fixing_circle
import Mathlib
import Definitions.Def_ChapterG2
open BookProof.ChapterG2

variable {Ω : Type*} [MeasurableSpace Ω]


open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

theorem BookProof.ChapterG2.no_continuous_gauge_fixing_circle :
    ¬ ∃ s : Circle → ℝ, Continuous s ∧ ∀ z, Circle.exp (s z) = z := by sorry
