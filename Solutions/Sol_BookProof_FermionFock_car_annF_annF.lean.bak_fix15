-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.car_annF_annF
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_fsign_insert_of_ne
import Theorems.Thm_BookProof_FermionFock_annF_apply
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j k : ℕ) (u : FermiAlg) :
    annF j (annF k u) + annF k (annF j u) = 0 := by

  classical
  refine Finsupp.ext fun S => ?_
  simp only [Finsupp.add_apply, annF_apply, Finsupp.zero_apply]
  rcases eq_or_ne j k with rfl | hjk
  · by_cases hS : j ∈ S
    · rw [if_pos hS]
      ring
    · rw [if_neg hS, if_pos (Finset.mem_insert_self j S)]
      ring
  · by_cases hjS : j ∈ S
    · rw [if_pos hjS, if_pos (Finset.mem_insert_of_mem hjS)]
      simp
    · by_cases hkS : k ∈ S
      · rw [if_neg hjS, if_pos hkS, if_pos (Finset.mem_insert_of_mem hkS)]
        ring
      · have hk' : k ∉ insert j S := by simp [Finset.mem_insert, hjk.symm, hkS]
        have hj' : j ∉ insert k S := by simp [Finset.mem_insert, hjk, hjS]
        rw [if_neg hjS, if_neg hkS, if_neg hk', if_neg hj']
        have hswap : insert k (insert j S) = insert j (insert k S) := Finset.insert_comm k j S
        have hj : fsign j (insert k S) = (if k < j then (-1 : ℂ) else 1) * fsign j S :=
          fsign_insert_of_ne S hkS hjk.symm
        have hk : fsign k (insert j S) = (if j < k then (-1 : ℂ) else 1) * fsign k S :=
          fsign_insert_of_ne S hjS hjk
        rw [hswap, hj, hk]
        rcases lt_or_gt_of_ne hjk with h | h
        · rw [if_neg (by omega : ¬ k < j), if_pos h]
          ring
        · rw [if_pos h, if_neg (by omega : ¬ j < k)]
          ring
