-- Generated from ChapterNavierStokesShiftHamiltonian.lean — solution of BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.shiftH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_shiftH_symmetricOn
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_shiftH_relative_bound
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_shiftH_commForm_bound
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*} (S : ShiftData ι)

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn (lpFiniteModes ι)
      ((shiftH S).comp (Submodule.inclusion (finiteModes_le_maxDom S.sym))) :=
  essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds S.sym (sym_nonneg S)
      (shiftH S) (1 / 2) (8 * S.K ^ 2) (2 * S.step * (1 / 4 + S.K))
      (shiftH_symmetricOn S) (by nlinarith [S.step_nonneg, S.K_nonneg])
      (shiftH_relative_bound S) (shiftH_commForm_bound S)
