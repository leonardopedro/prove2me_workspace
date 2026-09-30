-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.ndeg_le_wdeg
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
theorem solution (hw : ∀ k, 1 ≤ w k) (α : Conf) : (ndeg α : ℝ) ≤ wdeg w α := by

  rw [wdeg_eq_sum (Finset.Subset.refl α.support), ndeg_eq_sum (Finset.Subset.refl α.support)]
  push_cast
  refine Finset.sum_le_sum fun k _ => ?_
  have h1 : (1:ℝ) ≤ w k ^ 2 := by nlinarith [hw k]
  have h2 : (0:ℝ) ≤ (α k : ℝ) := Nat.cast_nonneg _
  nlinarith
