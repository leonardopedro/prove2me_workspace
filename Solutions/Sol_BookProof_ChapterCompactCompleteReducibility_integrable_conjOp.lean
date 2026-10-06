-- Generated from ChapterCompactCompleteReducibility.lean — solution of BookProof.ChapterCompactCompleteReducibility.integrable_conjOp
import Mathlib
import Definitions.Def_ChapterCompactCompleteReducibility
import Theorems.Thm_BookProof_ChapterCompactCompleteReducibility_continuous_conjOp
open BookProof.ChapterCompactCompleteReducibility




open MeasureTheory

variable {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
  [MeasurableSpace G] [BorelSpace G] {μ : Measure G} [IsProbabilityMeasure μ]
  [μ.IsMulLeftInvariant]
variable {V : Type*} [NormedAddCommGroup V] [NormedSpace ℂ V] [FiniteDimensional ℂ V]

variable {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
  [MeasurableSpace G] [BorelSpace G] {μ : Measure G} [IsProbabilityMeasure μ]
  [μ.IsMulLeftInvariant]
variable {V : Type*} [NormedAddCommGroup V] [NormedSpace ℂ V] [FiniteDimensional ℂ V]

set_option maxHeartbeats 1000000 in
omit [μ.IsMulLeftInvariant] [FiniteDimensional ℂ V] in
theorem solution {ρ : G →* (V ≃L[ℂ] V)}
    (hρ : Continuous fun g => (ρ g : V →L[ℂ] V)) (T : V →L[ℂ] V) :
    Integrable (conjOp ρ T) μ :=
  (continuous_conjOp hρ T).integrable_of_hasCompactSupport
      (HasCompactSupport.of_compactSpace _)
