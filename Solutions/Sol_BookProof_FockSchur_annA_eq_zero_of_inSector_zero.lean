-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.annA_eq_zero_of_inSector_zero
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_ndeg_up
import Theorems.Thm_BookProof_FockSecondQuantization_annA_apply
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {u : FockAlg} (hu : InSector 0 u) (j : ℕ) :
    annA j u = 0 := by

  refine Finsupp.ext fun α => ?_
  rw [annA_apply]
  have hz : u (up j α) = 0 := by
    by_contra hc
    have := hu _ (Finsupp.mem_support_iff.mpr hc)
    rw [ndeg_up] at this
    omega
  rw [hz, mul_zero]
  simp
