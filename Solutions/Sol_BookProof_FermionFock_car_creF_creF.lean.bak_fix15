-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.car_creF_creF
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_fsign_insert_of_ne
import Theorems.Thm_BookProof_FermionFock_creF_apply
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j k : ℕ) (u : FermiAlg) :
    creF j (creF k u) + creF k (creF j u) = 0 := by

  classical
  refine Finsupp.ext fun S => ?_
  simp only [Finsupp.add_apply, creF_apply, Finsupp.zero_apply]
  rcases eq_or_ne j k with rfl | hjk
  · simp
  · by_cases hjS : j ∈ S
    · by_cases hkS : k ∈ S
      · rw [if_pos hjS, if_pos hkS,
          if_pos (Finset.mem_erase.mpr ⟨hjk.symm, hkS⟩),
          if_pos (Finset.mem_erase.mpr ⟨hjk, hjS⟩)]
        have hswap : (S.erase j).erase k = (S.erase k).erase j := Finset.erase_right_comm
        have hj : fsign j S = (if k < j then (-1 : ℂ) else 1) * fsign j (S.erase k) := by
          have h := fsign_insert_of_ne (j := j) (k := k) (S.erase k)
            (Finset.notMem_erase k S) hjk.symm
          rwa [Finset.insert_erase hkS] at h
        have hk : fsign k S = (if j < k then (-1 : ℂ) else 1) * fsign k (S.erase j) := by
          have h := fsign_insert_of_ne (j := k) (k := j) (S.erase j)
            (Finset.notMem_erase j S) hjk
          rwa [Finset.insert_erase hjS] at h
        rcases lt_or_gt_of_ne hjk with h | h
        · have e1 : fsign k (S.erase j) = -fsign k S := by
            rw [hk, if_pos h]; ring
          have e2 : fsign j (S.erase k) = fsign j S := by
            rw [hj, if_neg (by omega : ¬ k < j), one_mul]
          rw [hswap, e1, e2]; ring
        · have e1 : fsign j (S.erase k) = -fsign j S := by
            rw [hj, if_pos h]; ring
          have e2 : fsign k (S.erase j) = fsign k S := by
            rw [hk, if_neg (by omega : ¬ j < k), one_mul]
          rw [hswap, e1, e2]; ring
      · rw [if_pos hjS, if_neg hkS,
          if_neg (fun hc => hkS (Finset.mem_of_mem_erase hc))]
        ring
    · by_cases hkS : k ∈ S
      · rw [if_neg hjS, if_pos hkS,
          if_neg (fun hc => hjS (Finset.mem_of_mem_erase hc))]
        ring
      · rw [if_neg hjS, if_neg hkS]
        ring
