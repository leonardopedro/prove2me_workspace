-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.wrow_le
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_sum_le_of_vanishing
import Theorems.Thm_BookProof_FockWeightedSchur_w_pos
open BookProof.FockWeightedSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {w : ℕ → ℝ}
variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hw : ∀ k, 1 ≤ w k) (hK : WRowBound w col K) (k : ℕ) (L : Finset ℕ) :
    ∑ j ∈ L, ‖(col k) j‖ / w k ≤ K := by

  classical
  have hwk : 0 < w k := w_pos hw k
  refine le_trans (sum_le_of_vanishing (S := (col k).support)
    (fun j => div_nonneg (norm_nonneg _) hwk.le) ?_) ?_
  · intro j hj
    rw [Finsupp.notMem_support_iff.mp hj]
    simp
  · rw [← Finset.sum_div, div_le_iff₀ hwk]
    exact le_trans (hK k) (le_of_eq (by ring))
