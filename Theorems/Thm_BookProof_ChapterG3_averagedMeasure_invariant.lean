-- Generated from ChapterG3.lean — theorem BookProof.ChapterG3.averagedMeasure_invariant
import Mathlib
import Definitions.Def_ChapterG3
import Definitions.Def_ChapterA4
open BookProof.ChapterG3

variable {X : Type*}


open MeasureTheory
open scoped ENNReal




theorem BookProof.ChapterG3.averagedMeasure_invariant (G : Type*) [Group G] [Fintype G]
    {Z : Type*} [MeasurableSpace Z] [MulAction G Z]
    (hmeas : ∀ g : G, Measurable (fun x : Z => g • x))
    (μ : Measure Z) (h : G) :
    (averagedMeasure G μ).map (fun x => h • x) = averagedMeasure G μ := by sorry
