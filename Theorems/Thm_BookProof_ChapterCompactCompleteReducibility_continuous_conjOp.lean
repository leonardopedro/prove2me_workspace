-- Generated from ChapterCompactCompleteReducibility.lean — theorem BookProof.ChapterCompactCompleteReducibility.continuous_conjOp
import Mathlib
import Definitions.Def_ChapterCompactCompleteReducibility
open BookProof.ChapterCompactCompleteReducibility



open MeasureTheory

variable {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
  [MeasurableSpace G] [BorelSpace G] {μ : Measure G} [IsProbabilityMeasure μ]
  [μ.IsMulLeftInvariant]
variable {V : Type*} [NormedAddCommGroup V] [NormedSpace ℂ V] [FiniteDimensional ℂ V]


omit [CompactSpace G] [MeasurableSpace G] [BorelSpace G] [FiniteDimensional ℂ V] in
theorem BookProof.ChapterCompactCompleteReducibility.continuous_conjOp {ρ : G →* (V ≃L[ℂ] V)}
    (hρ : Continuous fun g => (ρ g : V →L[ℂ] V)) (T : V →L[ℂ] V) :
    Continuous (conjOp ρ T) := by sorry
