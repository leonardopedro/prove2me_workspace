-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.ndeg_up
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_ndeg_eq_sum
import Theorems.Thm_BookProof_FockSchur_up_apply'
import Theorems.Thm_BookProof_FockSecondQuantization_support_up
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (α : Conf) : ndeg (up j α) = ndeg α + 1 := by

  classical
  have h1 : (up j α).support ⊆ insert j α.support := support_up j α
  have h2 : α.support ⊆ insert j α.support := Finset.subset_insert _ _
  rw [ndeg_eq_sum h1, ndeg_eq_sum h2,
    Finset.sum_congr rfl (fun i _ => up_apply' j α i), Finset.sum_add_distrib]
  congr 1
  simp
