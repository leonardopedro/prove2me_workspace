-- Generated from ChapterG2.lean — theorem BookProof.ChapterG2.not_isProbabilityMeasure_cond_null
import Mathlib
import Definitions.Def_ChapterG2
import Definitions.Def_ChapterA4
open BookProof.ChapterG2

variable {Ω : Type*} [MeasurableSpace Ω]


open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

theorem BookProof.ChapterG2.not_isProbabilityMeasure_cond_null (μ : Measure Ω) {C : Set Ω}
    (hC : μ C = 0) : ¬ IsProbabilityMeasure μ[|C] := by sorry
