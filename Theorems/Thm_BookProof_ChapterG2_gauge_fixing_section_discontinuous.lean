-- Generated from ChapterG2.lean — theorem BookProof.ChapterG2.gauge_fixing_section_discontinuous
import Mathlib
import Definitions.Def_ChapterG2
import Definitions.Def_ChapterA4
open BookProof.ChapterG2

variable {Ω : Type*} [MeasurableSpace Ω]


open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

theorem BookProof.ChapterG2.gauge_fixing_section_discontinuous
    (s : Circle → ℝ) (hs : ∀ z, Circle.exp (s z) = z) : ¬ Continuous s := by sorry
