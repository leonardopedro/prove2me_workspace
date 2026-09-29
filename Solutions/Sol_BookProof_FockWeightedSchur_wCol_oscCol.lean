-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.wCol_oscCol
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_oscW_pos
import Theorems.Thm_BookProof_FockWeightedSchur_support_oscCol_subset
import Theorems.Thm_BookProof_FockWeightedSchur_sum_pair_le
import Theorems.Thm_BookProof_FockWeightedSchur_norm_oscCol_le_col
open BookProof.FockWeightedSchur














open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

















variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution : WColBound oscW oscCol 2 := by

  intro j
  have h := sum_pair_le (f := fun k => ‖(oscCol j) k‖ / oscW k) (C := 1)
    (support_oscCol_subset j) (fun k => div_nonneg (norm_nonneg _) (oscW_pos k).le)
    (fun k => by
      rw [div_le_one (oscW_pos k)]
      exact norm_oscCol_le_col j k) zero_le_one
  simpa using h
