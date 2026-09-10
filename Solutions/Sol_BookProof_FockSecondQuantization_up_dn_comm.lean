-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.up_dn_comm
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
theorem solution {j k : ℕ} (h : j ≠ k) (α : Conf) : dn k (up j α) = up j (dn k α) := by

  refine Finsupp.ext fun i => ?_
  by_cases hik : i = k
  · subst hik
    rw [dn_self, up_of_ne _ h.symm, up_of_ne _ h.symm, dn_self]
  · by_cases hij : i = j
    · subst hij
      rw [dn_of_ne _ hik, up_self, up_self, dn_of_ne _ hik]
    · rw [dn_of_ne _ hik, up_of_ne _ hij, up_of_ne _ hij, dn_of_ne _ hik]
