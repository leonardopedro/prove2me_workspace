-- Generated from ChapterGaugeCasimirAverage.lean — theorem BookProof.ChapterGaugeCasimirAverage.map_measure_constrainedSet
import Definitions.Def_ChapterGaugeIncompleteFixing
import Mathlib
import Definitions.Def_ChapterGaugeCasimirAverage
open BookProof.ChapterGaugeCasimirAverage

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {ι : Type*} [Fintype ι]
variable {X : Type*}
variable {G : Type*} [Group G] [MeasurableSpace G] [MeasurableMul G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [Fintype G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X]
variable {X : Type*} [MeasurableSpace X]



open BookProof.ChapterGaugeIncompleteFixing
open MeasureTheory
open scoped InnerProductSpace

theorem BookProof.ChapterGaugeCasimirAverage.map_measure_constrainedSet (μ : Measure X) [IsProbabilityMeasure μ]
    {C : Set X} (hC : MeasurableSet C) {q : X → X} (hq : Measurable q)
    (hqC : ∀ x, q x ∈ C) : (μ.map q) C = 1 := by sorry
