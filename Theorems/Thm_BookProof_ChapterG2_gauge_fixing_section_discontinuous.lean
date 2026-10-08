-- Generated from ChapterG2.lean — theorem BookProof.ChapterG2.gauge_fixing_section_discontinuous
import Mathlib
import Definitions.Def_ChapterG2
open BookProof.ChapterG2


open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

variable {Ω : Type*} [MeasurableSpace Ω]

theorem BookProof.ChapterG2.gauge_fixing_section_discontinuous
    (s : Circle → ℝ) (hs : ∀ z, Circle.exp (s z) = z) : ¬ Continuous s := by sorry
