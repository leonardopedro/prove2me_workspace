-- Generated from ChapterG3.lean — theorem BookProof.ChapterG3.averagedMeasure_isProbability
import Mathlib
import Definitions.Def_ChapterG3
import Definitions.Def_ChapterA4
open BookProof.ChapterG3

variable {X : Type*}


open MeasureTheory
open scoped ENNReal




theorem BookProof.ChapterG3.averagedMeasure_isProbability (G : Type*) [Group G] [Fintype G]
    {Z : Type*} [MeasurableSpace Z] [MulAction G Z]
    (hmeas : ∀ g : G, Measurable (fun x : Z => g • x))
    (μ : Measure Z) [IsProbabilityMeasure μ] :
    IsProbabilityMeasure (averagedMeasure G μ) := by sorry
