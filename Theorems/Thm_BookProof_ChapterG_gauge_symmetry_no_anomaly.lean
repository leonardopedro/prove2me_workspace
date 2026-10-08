-- Generated from ChapterG.lean — theorem BookProof.ChapterG.gauge_symmetry_no_anomaly
import Mathlib
import Definitions.Def_ChapterG
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

theorem BookProof.ChapterG.gauge_symmetry_no_anomaly {X : Type*} [MeasurableSpace X]
    (μ : Measure X) [IsProbabilityMeasure μ]
    (G : Type*) [Group G] (U : G → X → X)
    (f : X → ℝ) (hf : ∀ g x, f (U g x) = f x) (g : G) :
    ∫ x, f x ∂μ = ∫ x, f (U g x) ∂μ := by sorry
