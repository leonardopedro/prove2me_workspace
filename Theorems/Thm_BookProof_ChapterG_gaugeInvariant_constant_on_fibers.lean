-- Generated from ChapterG.lean — theorem BookProof.ChapterG.gaugeInvariant_constant_on_fibers
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]
variable {A : Type*} [Ring A]
variable {α β E : Type*} [MeasurableSpace α] [MeasurableSpace β]
  [NormedAddCommGroup E] [NormedSpace ℝ E] {μ : Measure α} {ν : Measure β}
  {p : ENNReal} [Fact (1 ≤ p)]


open scoped ComplexConjugate InnerProductSpace Matrix

theorem BookProof.ChapterG.gaugeInvariant_constant_on_fibers {X Y : Type*}
    (π : X → Y) (f : X → ℝ) (hf : ∀ g ∈ gaugeGroup π, ∀ x, f (g x) = f x)
    (x y : X) (h : π x = π y) : f x = f y := by sorry
