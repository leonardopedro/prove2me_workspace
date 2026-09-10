-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.up_dn
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_FockSecondQuantization_up_self
import Theorems.Thm_BookProof_FockSecondQuantization_up_of_ne
import Theorems.Thm_BookProof_FockSecondQuantization_dn_self
import Theorems.Thm_BookProof_FockSecondQuantization_dn_of_ne
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) {α : Conf} (h : 1 ≤ α j) : up j (dn j α) = α := by

  refine Finsupp.ext fun i => ?_
  by_cases hi : i = j
  · subst hi; simp; omega
  · rw [up_of_ne _ hi, dn_of_ne _ hi]
