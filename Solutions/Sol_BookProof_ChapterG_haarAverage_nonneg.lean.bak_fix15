-- Generated from ChapterG.lean — solution of BookProof.ChapterG.haarAverage_nonneg
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG



open scoped ComplexConjugate InnerProductSpace Matrix

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution (f : X → ℝ) (hf : 0 ≤ f) :
    0 ≤ haarAverage (μG := by

  intro x
  simp only [haarAverage, Pi.zero_apply]
  apply integral_nonneg
  intro g
  exact hf (g⁻¹ • x)
