-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.wRow_oscCol
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_oscW_pos
import Theorems.Thm_BookProof_FockWeightedSchur_support_oscCol_subset
import Theorems.Thm_BookProof_FockWeightedSchur_sum_pair_le
import Theorems.Thm_BookProof_FockWeightedSchur_norm_oscCol_le
open BookProof.FockWeightedSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {w : ℕ → ℝ}
variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution : WRowBound oscW oscCol 2 := by

  intro k
  exact sum_pair_le (support_oscCol_subset k) (fun j => norm_nonneg _)
    (fun j => norm_oscCol_le k j) (le_of_lt (oscW_pos k))
