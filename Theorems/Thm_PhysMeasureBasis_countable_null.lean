-- Generated from PhysMeasureBasis.lean — theorem PhysMeasureBasis.countable_null
import Mathlib
import Definitions.Def_PhysMeasureBasis
import Definitions.Def_ChapterA4
open PhysMeasureBasis


open MeasureTheory Set ProbabilityTheory
open scoped ENNReal

noncomputable section

theorem PhysMeasureBasis.countable_null {α : Type*} [MeasurableSpace α]
    [MeasurableSingletonClass α] (μ : Measure α) [NullSingletonClass μ]
    {s : Set α} (hs : s.Countable) : μ s = 0 := by sorry
