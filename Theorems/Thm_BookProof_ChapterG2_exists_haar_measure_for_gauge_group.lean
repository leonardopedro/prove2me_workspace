-- Generated from ChapterG2.lean — theorem BookProof.ChapterG2.exists_haar_measure_for_gauge_group
import Mathlib
import Definitions.Def_ChapterG2
open BookProof.ChapterG2

variable {Ω : Type*} [MeasurableSpace Ω]
variable {A : Type*} [CommRing A] (Q : A)
variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]


open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

theorem BookProof.ChapterG2.exists_haar_measure_for_gauge_group (G : Type*)
    [MeasurableSpace G] [TopologicalSpace G] [LocallyCompactSpace G] [Group G]
    [BorelSpace G] [IsTopologicalGroup G] :
    ∃ (μ : Measure G), μ.IsHaarMeasure := by sorry
