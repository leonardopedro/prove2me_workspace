-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.wcomm_nonneg
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_w_pos
open BookProof.FockWeightedSchur














open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

















variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hw : ∀ k, 1 ≤ w k) (hB : WCommBound w col B) : 0 ≤ B :=
  le_trans (Finset.sum_nonneg (s := (col 0).support)
      (f := fun j => ‖(col 0) j‖ * |w j ^ 2 - w 0 ^ 2| / (w 0 * w j)) fun j _ => by
        have : 0 < w 0 * w j := mul_pos (w_pos hw 0) (w_pos hw j)
        positivity) (hB 0)
