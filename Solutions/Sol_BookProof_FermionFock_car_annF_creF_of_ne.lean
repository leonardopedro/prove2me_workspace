-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.car_annF_creF_of_ne
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_fsign_insert_of_ne
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
theorem solution {j k : ℕ} (hjk : j ≠ k) (u : FermiAlg) :
    annF j (creF k u) + creF k (annF j u) = 0 := by

  classical
  refine Finsupp.ext fun S => ?_
  simp only [Finsupp.add_apply, annF_apply, creF_apply, Finsupp.zero_apply]
  by_cases hjS : j ∈ S
  · rw [if_pos hjS, zero_add]
    by_cases hkS : k ∈ S
    · rw [if_pos hkS, if_pos (Finset.mem_erase.mpr ⟨hjk, hjS⟩), mul_zero]
    · rw [if_neg hkS]
  · rw [if_neg hjS]
    by_cases hkS : k ∈ S
    · rw [if_pos hkS, if_pos (Finset.mem_insert_of_mem hkS),
        if_neg (fun hc => hjS (Finset.mem_of_mem_erase hc))]
      have hset : (insert j S).erase k = insert j (S.erase k) :=
        Finset.erase_insert_of_ne hjk
      have hk : fsign k (insert j S) = (if j < k then (-1 : ℂ) else 1) * fsign k S :=
        fsign_insert_of_ne S hjS hjk
      have hj : fsign j S = (if k < j then (-1 : ℂ) else 1) * fsign j (S.erase k) := by
        have hk' : k ∉ S.erase k := Finset.notMem_erase k S
        have h := fsign_insert_of_ne (j := j) (k := k) (S.erase k) hk' hjk.symm
        rwa [Finset.insert_erase hkS] at h
      rcases lt_or_gt_of_ne hjk with h | h
      · have e1 : fsign k (insert j S) = -fsign k S := by rw [hk, if_pos h]; ring
        have e2 : fsign j (S.erase k) = fsign j S := by
          rw [hj, if_neg (by omega : ¬ k < j), one_mul]
        rw [hset, e1, e2]; ring
      · have e1 : fsign k (insert j S) = fsign k S := by
          rw [hk, if_neg (by omega : ¬ j < k), one_mul]
        have e2 : fsign j (S.erase k) = -fsign j S := by rw [hj, if_pos h]; ring
        rw [hset, e1, e2]; ring
    · rw [if_neg hkS, if_neg (fun hc => hkS (by
        rcases Finset.mem_insert.mp hc with h | h
        · exact absurd h.symm hjk
        · exact h)), mul_zero, add_zero]
