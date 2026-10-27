-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.sum_norm_col_le
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ} (hK : SchurBound col K) (k : ℕ)
    (L : Finset ℕ) : ∑ j ∈ L, ‖(col k) j‖ ≤ K := by

  classical
  have h1 : ∑ j ∈ L, ‖(col k) j‖ = ∑ j ∈ L ∩ (col k).support, ‖(col k) j‖ := by
    refine (Finset.sum_subset Finset.inter_subset_left ?_).symm
    intro j hj hjn
    have hz : (col k) j = 0 := by
      by_contra hc
      exact hjn (Finset.mem_inter.mpr ⟨hj, Finsupp.mem_support_iff.mpr hc⟩)
    simp [hz]
  rw [h1]
  refine le_trans (Finset.sum_le_sum_of_subset_of_nonneg Finset.inter_subset_right ?_) (hK k)
  intro j _ _
  exact norm_nonneg _
