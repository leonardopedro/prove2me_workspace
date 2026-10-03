-- Generated from ChapterG3.lean — theorem BookProof.ChapterG3.integral_eventProj
import Mathlib
import Definitions.Def_ChapterG3
import Definitions.Def_ChapterConservativeDiagonal
import Definitions.Def_ChapterA4
open BookProof.ConservativeDiagonal

variable {X : Type*}


open MeasureTheory
open scoped ENNReal




theorem BookProof.ChapterG3.integral_eventProj [MeasurableSpace X] (μ : Measure X)
    [IsProbabilityMeasure μ] (A : Set X) (hA : MeasurableSet A) :
    ∫ x, eventProj A x ∂μ = (μ A).toReal := by sorry
