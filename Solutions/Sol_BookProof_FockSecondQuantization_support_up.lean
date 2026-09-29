-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.support_up
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_FockSecondQuantization_up_of_ne
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (α : Conf) : (up j α).support ⊆ insert j α.support := by

  intro i hi
  by_cases h : i = j
  · simp [h]
  · have : α i ≠ 0 := by
      have := Finsupp.mem_support_iff.mp hi
      rwa [up_of_ne _ h] at this
    exact Finset.mem_insert_of_mem (Finsupp.mem_support_iff.mpr this)
