-- Generated from ChapterGaugeCasimirAverage.lean — theorem BookProof.ChapterGaugeCasimirAverage.gaugeAverage_of_isPhysicalObservable
import Mathlib
import Definitions.Def_ChapterGaugeCasimirAverage
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeCasimirAverage

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {ι : Type*} [Fintype ι]
variable {X : Type*}
variable {G : Type*} [Group G] [MeasurableSpace G] [MeasurableMul G] [MulAction G X]



open BookProof.ChapterGaugeIncompleteFixing
open MeasureTheory
open scoped InnerProductSpace

theorem BookProof.ChapterGaugeCasimirAverage.gaugeAverage_of_isPhysicalObservable (μ : Measure G) [IsProbabilityMeasure μ]
    {f : X → ℝ} (hf : IsPhysicalObservable G f) :
    gaugeAverage (X := X) μ f = f := by sorry
