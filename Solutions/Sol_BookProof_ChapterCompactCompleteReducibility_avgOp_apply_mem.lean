-- Generated from ChapterCompactCompleteReducibility.lean — solution of BookProof.ChapterCompactCompleteReducibility.avgOp_apply_mem
import Mathlib
import Definitions.Def_ChapterCompactCompleteReducibility
import Theorems.Thm_BookProof_ChapterCompactCompleteReducibility_integrable_conjOp
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
    {W : Submodule ℂ V} {T : V →L[ℂ] V} (hT : ∀ v, T v ∈ W)
    (hW : ∀ g : G, ∀ x ∈ W, ρ g x ∈ W) (v : V) :
    avgOp μ ρ T v ∈ W := by

  rw [avgOp_apply hρ]
  have hconv : Convex ℝ (W : Set V) := (W.restrictScalars ℝ).convex
  have hclosed : IsClosed (W : Set V) := W.closed_of_finiteDimensional
  have hint : Integrable (fun g => ρ g (T ((ρ g).symm v))) μ := by
    have := (integrable_conjOp (μ := μ) hρ T).apply_continuousLinearMap v
    simpa [conjOp] using this
  refine hconv.integral_mem hclosed ?_ hint
  exact Filter.Eventually.of_forall fun g => hW g _ (hT _)
