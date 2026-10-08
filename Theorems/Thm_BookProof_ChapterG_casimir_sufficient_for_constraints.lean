-- Generated from ChapterG.lean — theorem BookProof.ChapterG.casimir_sufficient_for_constraints
import Mathlib
import Definitions.Def_ChapterG
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterG


open scoped ComplexConjugate InnerProductSpace Matrix
open MeasureTheory

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]
variable {A : Type*} [Ring A]
variable {α β E : Type*} [MeasurableSpace α] [MeasurableSpace β]
  [NormedAddCommGroup E] [NormedSpace ℝ E] {μ : Measure α} {ν : Measure β}
  {p : ENNReal} [Fact (1 ≤ p)]

theorem BookProof.ChapterG.casimir_sufficient_for_constraints {X Y : Type*} (π : X → Y)
    (h : IsUnconstrainedGaugeFixing π) :
    gaugeInvariantSubalgebra ℝ π ≠ ⊤ := by sorry
