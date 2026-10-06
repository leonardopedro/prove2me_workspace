-- Generated from PhysMeasureBasis.lean — theorem PhysMeasureBasis.null_singleton
import Mathlib
import Definitions.Def_PhysMeasureBasis
import Definitions.Def_ChapterA4
open PhysMeasureBasis


open MeasureTheory Set ProbabilityTheory
open scoped ENNReal

noncomputable section

theorem PhysMeasureBasis.null_singleton {α : Type*} [MeasurableSpace α] (μ : Measure α)
    [MeasurableSingletonClass α] [NullSingletonClass μ] (a : α) : μ {a} = 0 := by sorry
