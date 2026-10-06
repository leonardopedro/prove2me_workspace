-- Generated from ChapterCompactCompleteReducibility.lean — solution of BookProof.ChapterCompactCompleteReducibility.avgOp_apply_eq_self
import Mathlib
import Definitions.Def_ChapterCompactCompleteReducibility
import Theorems.Thm_BookProof_ChapterCompactCompleteReducibility_avgOp_apply
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
theorem solution {ρ : G →* (V ≃L[ℂ] V)} (hρ : Continuous fun g => (ρ g : V →L[ℂ] V))
    {W : Submodule ℂ V} {T : V →L[ℂ] V} (hTid : ∀ w ∈ W, T w = w)
    (hW : ∀ g : G, ∀ x ∈ W, ρ g x ∈ W) {w : V} (hw : w ∈ W) :
    avgOp μ ρ T w = w := by

  rw [avgOp_apply hρ]
  have hpt : ∀ g : G, ρ g (T ((ρ g).symm w)) = w := by
    intro g
    have hmem : ((ρ g).symm w) ∈ W := by
      have : ((ρ g).symm w) = ρ g⁻¹ w := by
        rw [map_inv]
        rfl
      rw [this]
      exact hW _ _ hw
    rw [hTid _ hmem]
    exact (ρ g).apply_symm_apply w
  simp only [hpt]
  simp
