-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.car_annF_creF_self
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_fsign_mul_self
import Theorems.Thm_BookProof_FermionFock_fsign_erase
import Theorems.Thm_BookProof_FermionFock_fsign_insert_self
import Theorems.Thm_BookProof_FermionFock_creF_apply
import Theorems.Thm_BookProof_FermionFock_annF_apply
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (u : FermiAlg) :
    annF j (creF j u) + creF j (annF j u) = u := by

  classical
  refine Finsupp.ext fun S => ?_
  simp only [Finsupp.add_apply, annF_apply, creF_apply]
  by_cases hS : j ∈ S
  · rw [if_pos hS, if_pos hS, zero_add, if_neg (Finset.notMem_erase j S),
      fsign_erase, Finset.insert_erase hS, ← mul_assoc, fsign_mul_self, one_mul]
  · rw [if_neg hS, if_neg hS, add_zero, if_pos (Finset.mem_insert_self j S),
      fsign_insert_self, Finset.erase_insert hS, ← mul_assoc, fsign_mul_self, one_mul]
