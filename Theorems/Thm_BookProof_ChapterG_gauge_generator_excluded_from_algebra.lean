-- Generated from ChapterG.lean — theorem BookProof.ChapterG.gauge_generator_excluded_from_algebra
import Mathlib
import Definitions.Def_ChapterG
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterG

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]
variable {A : Type*} [Ring A]
variable {α β E : Type*} [MeasurableSpace α] [MeasurableSpace β]
  [NormedAddCommGroup E] [NormedSpace ℝ E] {μ : Measure α} {ν : Measure β}
  {p : ENNReal} [Fact (1 ≤ p)]


open scoped ComplexConjugate InnerProductSpace Matrix

theorem BookProof.ChapterG.gauge_generator_excluded_from_algebra {X Y : Type*} (π : X → Y)
    (h : IsUnconstrainedGaugeFixing π) :
    ∃ g ∈ gaugeGroup π, ∃ (f : gaugeInvariantSubalgebra ℝ π),
      (f : X → ℝ) ∘ g ≠ (f : X → ℝ) := by sorry
