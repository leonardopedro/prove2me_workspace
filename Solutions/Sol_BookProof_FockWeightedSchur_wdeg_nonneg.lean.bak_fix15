-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.wdeg_nonneg
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_wdeg_eq_sum
open BookProof.FockWeightedSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {w : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (α : Conf) : 0 ≤ wdeg w α := by

  rw [wdeg_eq_sum (Finset.Subset.refl α.support)]
  refine Finset.sum_nonneg fun k _ => ?_
  have : (0:ℝ) ≤ w k ^ 2 := sq_nonneg _
  have h2 : (0:ℝ) ≤ (α k : ℝ) := Nat.cast_nonneg _
  positivity
