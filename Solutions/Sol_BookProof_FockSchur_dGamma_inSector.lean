-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.dGamma_inSector
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_inSector_zero_op
import Theorems.Thm_BookProof_FockSchur_inSector_sum
import Theorems.Thm_BookProof_FockSchur_annA_inSector
import Theorems.Thm_BookProof_FockSchur_creVec_inSector
import Theorems.Thm_BookProof_FockSchur_annA_eq_zero_of_inSector_zero
import Theorems.Thm_BookProof_FockSecondQuantization_dGamma_eq_sum
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (col : ℕ → (ℕ →₀ ℂ)) {n : ℕ} {u : FockAlg} (hu : InSector n u) :
    InSector n (dGamma col u) := by

  classical
  rw [dGamma_eq_sum col (Finset.Subset.refl (modes u))]
  cases n with
  | zero =>
      refine inSector_sum _ _ fun k _ => ?_
      rw [annA_eq_zero_of_inSector_zero hu k, map_zero]
      exact inSector_zero_op 0
  | succ m =>
      exact inSector_sum _ _ fun k _ => creVec_inSector (annA_inSector hu k) (col k)
