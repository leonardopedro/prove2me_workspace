-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.wcomm_row_le
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
theorem solution (hw : ∀ k, 1 ≤ w k) (hB : WCommBound w col B) (k : ℕ) (L : Finset ℕ) :
    ∑ j ∈ L, ‖(col k) j‖ * |w j ^ 2 - w k ^ 2| / (w k * w j) ≤ B := by

  classical
  refine le_trans (sum_le_of_vanishing (S := (col k).support) (fun j => ?_) ?_) (hB k)
  · have : 0 < w k * w j := mul_pos (w_pos hw k) (w_pos hw j)
    positivity
  · intro j hj
    rw [Finsupp.notMem_support_iff.mp hj]
    simp
