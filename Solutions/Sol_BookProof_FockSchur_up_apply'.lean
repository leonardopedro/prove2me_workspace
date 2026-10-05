-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.up_apply'
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSecondQuantization_up_of_ne
import Theorems.Thm_BookProof_FockSecondQuantization_up_self
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (α : Conf) (i : ℕ) : up j α i = α i + if i = j then 1 else 0 := by

  by_cases h : i = j
  · subst h; simp [up_self]
  · simp [up_of_ne _ h, h]
