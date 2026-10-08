-- Generated from ChapterCompactCompleteReducibility.lean — theorem BookProof.ChapterCompactCompleteReducibility.compact_invariant_complement_haar
import Mathlib
import Definitions.Def_ChapterCompactCompleteReducibility
open BookProof.ChapterCompactCompleteReducibility



open MeasureTheory

variable {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
  [MeasurableSpace G] [BorelSpace G] {μ : Measure G} [IsProbabilityMeasure μ]
  [μ.IsMulLeftInvariant]
variable {V : Type*} [NormedAddCommGroup V] [NormedSpace ℂ V] [FiniteDimensional ℂ V]


theorem BookProof.ChapterCompactCompleteReducibility.compact_invariant_complement_haar [T2Space G] {ρ : G →* (V ≃L[ℂ] V)}
    (hρ : Continuous fun g => (ρ g : V →L[ℂ] V)) (W : Submodule ℂ V)
    (hW : ∀ g : G, ∀ x ∈ W, ρ g x ∈ W) :
    ∃ W' : Submodule ℂ V, (∀ g : G, ∀ x ∈ W', ρ g x ∈ W') ∧ IsCompl W W' := by sorry
