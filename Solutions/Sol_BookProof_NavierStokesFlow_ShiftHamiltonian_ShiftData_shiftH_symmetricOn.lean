-- Generated from ChapterNavierStokesShiftHamiltonian.lean — solution of BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.shiftH_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_hasSum_inner_shiftH_left
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_hasSum_inner_shiftH_right
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*} (S : ShiftData ι)

set_option maxHeartbeats 1000000 in
theorem solution : SymmetricOn (maxDom S.sym) (shiftH S) := by

  intro x y
  exact (hasSum_inner_shiftH_left S x (y : L2I ι)).unique (hasSum_inner_shiftH_right S x y)
