-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.dn_dn_comm
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_FockSecondQuantization_dn_self
import Theorems.Thm_BookProof_FockSecondQuantization_dn_of_ne
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j k : ℕ) (α : Conf) : dn k (dn j α) = dn j (dn k α) := by

  rcases eq_or_ne j k with rfl | h
  · rfl
  refine Finsupp.ext fun i => ?_
  by_cases hik : i = k
  · subst hik
    rw [dn_self, dn_of_ne _ h.symm, dn_of_ne _ h.symm, dn_self]
  · by_cases hij : i = j
    · subst hij
      rw [dn_of_ne _ hik, dn_self, dn_self, dn_of_ne _ hik]
    · rw [dn_of_ne _ hik, dn_of_ne _ hij, dn_of_ne _ hij, dn_of_ne _ hik]
