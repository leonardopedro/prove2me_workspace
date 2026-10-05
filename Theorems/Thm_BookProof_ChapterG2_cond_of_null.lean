-- Generated from ChapterG2.lean — theorem BookProof.ChapterG2.cond_of_null
import Mathlib
import Definitions.Def_ChapterG2
open BookProof.ChapterG2

variable {Ω : Type*} [MeasurableSpace Ω]


open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

theorem BookProof.ChapterG2.cond_of_null (μ : Measure Ω) {C : Set Ω} (hC : μ C = 0) : μ[|C] = 0 := by sorry
