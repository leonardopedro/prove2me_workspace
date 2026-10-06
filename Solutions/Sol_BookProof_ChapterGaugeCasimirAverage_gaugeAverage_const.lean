-- Generated from ChapterGaugeCasimirAverage.lean — solution of BookProof.ChapterGaugeCasimirAverage.gaugeAverage_const
import Mathlib
import Definitions.Def_ChapterGaugeCasimirAverage
open BookProof.ChapterGaugeCasimirAverage




open BookProof.ChapterGaugeIncompleteFixing
open MeasureTheory
open scoped InnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {ι : Type*} [Fintype ι]
variable {X : Type*}
variable {G : Type*} [Group G] [MeasurableSpace G] [MeasurableMul G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure G) [IsProbabilityMeasure μ] (c : ℝ) :
    gaugeAverage (X := X) μ (fun _ => c) = fun _ => c := by

  funext x
  simp [gaugeAverage]
