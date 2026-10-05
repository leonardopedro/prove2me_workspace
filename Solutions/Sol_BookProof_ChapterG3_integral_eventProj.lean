-- Generated from ChapterG3.lean — solution of BookProof.ChapterG3.integral_eventProj
import Mathlib
import Definitions.Def_ChapterG3
open BookProof.ChapterG3



open MeasureTheory
open scoped ENNReal



variable {X : Type*}

variable {X : Type*}

set_option maxHeartbeats 1000000 in
theorem solution [MeasurableSpace X] (μ : Measure X)
    [IsProbabilityMeasure μ] (A : Set X) (hA : MeasurableSet A) :
    ∫ x, eventProj A x ∂μ = (μ A).toReal := by

  rw [eventProj, MeasureTheory.integral_indicator_one hA, MeasureTheory.measureReal_def]
