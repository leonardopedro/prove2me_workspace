-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.ccr_annA_annA
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_FockSecondQuantization_up_of_ne
import Theorems.Thm_BookProof_FockSecondQuantization_annA_apply
import Theorems.Thm_BookProof_FockSecondQuantization_up_up_comm
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j k : ℕ) (u : FockAlg) : annA j (annA k u) = annA k (annA j u) := by

  refine Finsupp.ext fun α => ?_
  rcases eq_or_ne j k with rfl | h
  · rfl
  rw [annA_apply, annA_apply, annA_apply, annA_apply, up_of_ne _ h.symm, up_of_ne _ h,
    up_up_comm]
  ring
