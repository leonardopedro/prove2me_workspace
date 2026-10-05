-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.toggle_toggle
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_toggle_of_mem
import Theorems.Thm_BookProof_FermionFock_toggle_of_not_mem
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (S : FConf) : toggle j (toggle j S) = S := by

  by_cases hS : j ∈ S
  · rw [toggle_of_mem hS, toggle_of_not_mem (Finset.notMem_erase j S), Finset.insert_erase hS]
  · rw [toggle_of_not_mem hS, toggle_of_mem (Finset.mem_insert_self j S),
      Finset.erase_insert hS]
