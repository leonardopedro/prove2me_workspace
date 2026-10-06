-- Generated from ChapterGaugeCasimirAverage.lean — theorem BookProof.ChapterGaugeCasimirAverage.integral_map_of_invariant
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

theorem BookProof.ChapterGaugeCasimirAverage.integral_map_of_invariant (μ : Measure X) {q : X → X} (hq : Measurable q)
    {f : X → ℝ} (hf : AEStronglyMeasurable f (μ.map q)) (hinv : ∀ x, f (q x) = f x) :
    ∫ x, f x ∂(μ.map q) = ∫ x, f x ∂μ := by sorry
