-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.wdeg_up
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_wdeg_eq_sum
import Theorems.Thm_BookProof_FockSecondQuantization_support_up
open BookProof.FockWeightedSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {w : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (α : Conf) : wdeg w (up j α) = wdeg w α + w j ^ 2 := by

  classical
  have h1 : (up j α).support ⊆ insert j α.support := support_up j α
  have h2 : α.support ⊆ insert j α.support := Finset.subset_insert _ _
  rw [wdeg_eq_sum h1, wdeg_eq_sum h2]
  have hcongr : ∀ i ∈ insert j α.support,
      w i ^ 2 * (((up j α) i : ℕ) : ℝ)
        = w i ^ 2 * ((α i : ℕ) : ℝ) + (if i = j then w j ^ 2 else 0) := by
    intro i _
    rw [up_apply' j α i]
    by_cases h : i = j
    · subst h; push_cast; simp; ring
    · simp [h]
  rw [Finset.sum_congr rfl hcongr, Finset.sum_add_distrib]
  congr 1
  simp
