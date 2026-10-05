-- Generated from ChapterG.lean — solution of BookProof.ChapterG.haarAverage_one
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG



open scoped ComplexConjugate InnerProductSpace Matrix

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution : haarAverage (μG := by

  funext x
  simp only [haarAverage, integral_const]
  simp
