-- Generated from ChapterG.lean — theorem BookProof.ChapterG.haarAverage_one
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]


open scoped ComplexConjugate InnerProductSpace Matrix

theorem BookProof.ChapterG.haarAverage_one : haarAverage (μG := by sorry
