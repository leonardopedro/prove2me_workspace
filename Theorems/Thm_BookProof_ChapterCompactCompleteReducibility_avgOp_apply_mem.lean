-- Generated from ChapterCompactCompleteReducibility.lean — theorem BookProof.ChapterCompactCompleteReducibility.avgOp_apply_mem
import Mathlib
import Definitions.Def_ChapterCompactCompleteReducibility
open BookProof.ChapterCompactCompleteReducibility

variable {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
  [MeasurableSpace G] [BorelSpace G] {μ : Measure G} [IsProbabilityMeasure μ]
  [μ.IsMulLeftInvariant]
variable {V : Type*} [NormedAddCommGroup V] [NormedSpace ℂ V] [FiniteDimensional ℂ V]



open MeasureTheory


theorem BookProof.ChapterCompactCompleteReducibility.avgOp_apply_mem {ρ : G →* (V ≃L[ℂ] V)} (hρ : Continuous fun g => (ρ g : V →L[ℂ] V))
    {W : Submodule ℂ V} {T : V →L[ℂ] V} (hT : ∀ v, T v ∈ W)
    (hW : ∀ g : G, ∀ x ∈ W, ρ g x ∈ W) (v : V) :
    avgOp μ ρ T v ∈ W := by sorry
