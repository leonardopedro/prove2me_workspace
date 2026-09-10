-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.ccr_creA_creA
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_FockSecondQuantization_dn_of_ne
import Theorems.Thm_BookProof_FockSecondQuantization_creA_apply
import Theorems.Thm_BookProof_FockSecondQuantization_dn_dn_comm
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j k : ℕ) (u : FockAlg) : creA j (creA k u) = creA k (creA j u) := by

  refine Finsupp.ext fun α => ?_
  rcases eq_or_ne j k with rfl | h
  · rfl
  rw [creA_apply, creA_apply, creA_apply, creA_apply, dn_of_ne _ h.symm, dn_of_ne _ h,
    dn_dn_comm]
  ring
