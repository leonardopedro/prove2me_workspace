-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.ndeg_up
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_ndeg_eq_sum
import Theorems.Thm_BookProof_FockSchur_up_apply_prime
import Theorems.Thm_BookProof_FockSecondQuantization_support_up
import Definitions.Def_ChapterCoreBoundsEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (α : Conf) : ndeg (up j α) = ndeg α + 1 := by

  classical
  have h1 : (up j α).support ⊆ insert j α.support := support_up j α
  have h2 : α.support ⊆ insert j α.support := Finset.subset_insert _ _
  rw [ndeg_eq_sum h1, ndeg_eq_sum h2,
    Finset.sum_congr rfl (fun i _ => up_apply_prime j α i), Finset.sum_add_distrib]
  congr 1
  simp
