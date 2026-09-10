-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.support_dn
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
theorem solution (j : ℕ) (α : Conf) : (dn j α).support ⊆ α.support := by

  intro i hi
  have hi' := Finsupp.mem_support_iff.mp hi
  by_cases h : i = j
  · subst h
    rw [dn_self] at hi'
    exact Finsupp.mem_support_iff.mpr (by omega)
  · rw [dn_of_ne _ h] at hi'
    exact Finsupp.mem_support_iff.mpr hi'
