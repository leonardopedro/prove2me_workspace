-- Generated from ChapterCompactCompleteReducibility.lean — theorem BookProof.ChapterCompactCompleteReducibility.avgOp_apply
import Mathlib
import Definitions.Def_ChapterCompactCompleteReducibility
open BookProof.ChapterCompactCompleteReducibility



open MeasureTheory

variable {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
  [MeasurableSpace G] [BorelSpace G] {μ : Measure G} [IsProbabilityMeasure μ]
  [μ.IsMulLeftInvariant]
variable {V : Type*} [NormedAddCommGroup V] [NormedSpace ℂ V] [FiniteDimensional ℂ V]


omit [μ.IsMulLeftInvariant] [FiniteDimensional ℂ V] in
theorem BookProof.ChapterCompactCompleteReducibility.avgOp_apply {ρ : G →* (V ≃L[ℂ] V)} (hρ : Continuous fun g => (ρ g : V →L[ℂ] V))
    (T : V →L[ℂ] V) (v : V) :
    avgOp μ ρ T v = ∫ g, ρ g (T ((ρ g).symm v)) ∂μ := by sorry
