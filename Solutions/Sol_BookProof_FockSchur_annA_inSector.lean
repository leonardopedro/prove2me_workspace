-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.annA_inSector
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
theorem solution {n : ℕ} {u : FockAlg} (hu : InSector (n + 1) u) (j : ℕ) :
    InSector n (annA j u) := by

  intro α hα
  have hne : (annA j u) α ≠ 0 := Finsupp.mem_support_iff.mp hα
  rw [annA_apply] at hne
  have hu' : u (up j α) ≠ 0 := fun h => hne (by rw [h, mul_zero])
  have := hu _ (Finsupp.mem_support_iff.mpr hu')
  rw [ndeg_up] at this
  omega
