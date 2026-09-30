-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.sum_le_of_vanishing
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
open BookProof.FockWeightedSchur














open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

















variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {f : ℕ → ℝ} {S L : Finset ℕ} (hf : ∀ j, 0 ≤ f j)
    (hz : ∀ j, j ∉ S → f j = 0) : ∑ j ∈ L, f j ≤ ∑ j ∈ S, f j := by

  classical
  have h1 : ∑ j ∈ L, f j = ∑ j ∈ L ∩ S, f j := by
    refine (Finset.sum_subset Finset.inter_subset_left ?_).symm
    intro j hj hjn
    exact hz j fun hs => hjn (Finset.mem_inter.mpr ⟨hj, hs⟩)
  rw [h1]
  exact Finset.sum_le_sum_of_subset_of_nonneg Finset.inter_subset_right fun j _ _ => hf j
