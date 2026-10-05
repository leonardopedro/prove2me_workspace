-- Generated from ChapterSpectralCommutant.lean — solution of BookProof.ChapterSpectralCommutant.multOp_norm_le_of_toLp
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Theorems.Thm_BookProof_ChapterSpectralCommutant_denseRange_toLp
open BookProof.ChapterSpectralCommutant



noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}
variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X] {mu : Measure X} [IsFiniteMeasure mu] [mu.WeaklyRegular]

set_option maxHeartbeats 1000000 in
theorem solution {φ : X → ℂ} (hφ : MemLp φ ⊤ mu) {c : ℝ}
    (h : ∀ g : C(X, ℂ), ‖multOp φ hφ (ContinuousMap.toLp 2 mu ℂ g)‖
      ≤ c * ‖ContinuousMap.toLp 2 mu ℂ g‖) (u : Lp ℂ 2 mu) :
    ‖multOp φ hφ u‖ ≤ c * ‖u‖ := by

  have hclosed : IsClosed {v : Lp ℂ 2 mu | ‖multOp φ hφ v‖ ≤ c * ‖v‖} :=
    isClosed_le ((multOp φ hφ).continuous.norm) (continuous_const.mul continuous_norm)
  have hsub : Set.range (fun g : C(X, ℂ) => ContinuousMap.toLp 2 mu ℂ g)
      ⊆ {v : Lp ℂ 2 mu | ‖multOp φ hφ v‖ ≤ c * ‖v‖} := by
    rintro _ ⟨g, rfl⟩
    exact h g
  have : (Set.univ : Set (Lp ℂ 2 mu)) ⊆ {v : Lp ℂ 2 mu | ‖multOp φ hφ v‖ ≤ c * ‖v‖} := by
    rw [← denseRange_toLp.closure_range]
    exact hclosed.closure_subset_iff.mpr hsub
  exact this (Set.mem_univ u)
