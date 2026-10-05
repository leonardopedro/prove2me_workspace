-- Generated from ChapterG2.lean — solution of BookProof.ChapterG2.exists_haar_measure_for_gauge_group
import Mathlib
import Definitions.Def_ChapterG2
open BookProof.ChapterG2



open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

variable {Ω : Type*} [MeasurableSpace Ω]
variable {A : Type*} [CommRing A] (Q : A)
variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution (G : Type*)
    [MeasurableSpace G] [TopologicalSpace G] [LocallyCompactSpace G] [Group G]
    [BorelSpace G] [IsTopologicalGroup G] :
    ∃ (μ : Measure G), μ.IsHaarMeasure := by

  refine ⟨MeasureTheory.Measure.haar, ?_⟩
  infer_instance
