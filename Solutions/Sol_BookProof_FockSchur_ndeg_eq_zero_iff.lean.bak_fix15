-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.ndeg_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_ndeg_eq_sum
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {α : Conf} : ndeg α = 0 ↔ α = 0 := by

  classical
  constructor
  · intro h
    ext i
    have hsum : ∑ i ∈ α.support, α i = 0 := by
      rw [← ndeg_eq_sum (Finset.Subset.refl α.support), h]
    by_cases hi : i ∈ α.support
    · simp [(Finset.sum_eq_zero_iff.mp hsum) i hi]
    · simp [Finsupp.notMem_support_iff.mp hi]
  · intro h; subst h; simp [ndeg]
