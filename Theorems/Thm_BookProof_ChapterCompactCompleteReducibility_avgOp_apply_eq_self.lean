-- Generated from ChapterCompactCompleteReducibility.lean — theorem BookProof.ChapterCompactCompleteReducibility.avgOp_apply_eq_self
import Mathlib
import Definitions.Def_ChapterCompactCompleteReducibility
open BookProof.ChapterCompactCompleteReducibility

variable {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
  [MeasurableSpace G] [BorelSpace G] {μ : Measure G} [IsProbabilityMeasure μ]
  [μ.IsMulLeftInvariant]
variable {V : Type*} [NormedAddCommGroup V] [NormedSpace ℂ V] [FiniteDimensional ℂ V]



open MeasureTheory


theorem BookProof.ChapterCompactCompleteReducibility.avgOp_apply_eq_self {ρ : G →* (V ≃L[ℂ] V)} (hρ : Continuous fun g => (ρ g : V →L[ℂ] V))
    {W : Submodule ℂ V} {T : V →L[ℂ] V} (hTid : ∀ w ∈ W, T w = w)
    (hW : ∀ g : G, ∀ x ∈ W, ρ g x ∈ W) {w : V} (hw : w ∈ W) :
    avgOp μ ρ T w = w := by sorry
