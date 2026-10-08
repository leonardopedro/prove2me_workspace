-- Generated from ChapterG.lean — theorem BookProof.ChapterG.haarAverage_nonneg
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG


open scoped ComplexConjugate InnerProductSpace Matrix
open MeasureTheory

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]

theorem BookProof.ChapterG.haarAverage_nonneg (f : X → ℝ) (hf : 0 ≤ f) :
    0 ≤ haarAverage (μG := by sorry
