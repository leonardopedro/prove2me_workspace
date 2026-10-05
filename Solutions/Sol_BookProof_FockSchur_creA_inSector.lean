-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.creA_inSector
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_ndeg_dn
import Theorems.Thm_BookProof_FockSecondQuantization_creA_apply
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} {u : FockAlg} (hu : InSector n u) (j : ℕ) :
    InSector (n + 1) (creA j u) := by

  intro α hα
  have hne : (creA j u) α ≠ 0 := Finsupp.mem_support_iff.mp hα
  rw [creA_apply] at hne
  have hj : α j ≠ 0 := by
    intro h
    rw [h] at hne
    simp at hne
  have hu' : u (dn j α) ≠ 0 := fun h => hne (by rw [h, mul_zero])
  have hd := hu _ (Finsupp.mem_support_iff.mpr hu')
  have := ndeg_dn j (α := α) (by omega)
  omega
