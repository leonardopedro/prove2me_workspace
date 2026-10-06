-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.car_annih_creat_of_ne
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Theorems.Thm_BookProof_SmCar_jwSign_insert
open BookProof.SmCar




open Finset

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {i j : Fin n} (hij : i ≠ j) :
    annih i ∘ₗ creat j + creat j ∘ₗ annih i = 0 := by

  refine LinearMap.ext fun ψ => ?_
  ext S
  by_cases hi : i ∈ S
  · -- the first term vanishes; so does the second, unless `j ∈ S`, and then `i ∈ S.erase j`
    by_cases hj : j ∈ S
    · have hiR : i ∈ S.erase j := Finset.mem_erase.mpr ⟨hij, hi⟩
      simp [hi, hj, hiR]
    · simp [hi, hj]
  · by_cases hj : j ∈ S
    · -- the interesting case: `i ∉ S`, `j ∈ S`
      set R : Finset (Fin n) := S.erase j with hR
      have hjnotR : j ∉ R := Finset.notMem_erase _ _
      have hinotR : i ∉ R := fun hmem => hi (Finset.mem_of_mem_erase hmem)
      have hSR : S = insert j R := (Finset.insert_erase hj).symm
      have hjins : j ∈ insert i S := Finset.mem_insert_of_mem hj
      have hins : (insert i S).erase j = insert i R := by
        rw [hSR, Finset.insert_comm, Finset.erase_insert]
        simpa [Finset.mem_insert, hij.symm] using fun h => hjnotR h
      have hsign1 : jwSign i S = (if j < i then -1 else 1) * jwSign i R := by
        rw [hSR]; exact jwSign_insert hjnotR
      have hsign2 : jwSign j (insert i R) = (if i < j then -1 else 1) * jwSign j R :=
        jwSign_insert hinotR
      have hne : i < j ∨ j < i := lt_or_gt_of_ne hij
      simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.zero_apply,
        PiLp.add_apply, PiLp.zero_apply, annih_apply, creat_apply, if_neg hi, if_pos hj,
        if_pos hjins, hins, if_neg hinotR, hsign1, hsign2, ← hR]
      rcases hne with hlt1 | hlt2
      · rw [if_pos hlt1, if_neg (asymm hlt1)]
        ring
      · rw [if_neg (asymm hlt2), if_pos hlt2]
        ring
    · have hjins : j ∉ insert i S := by
        simp [Finset.mem_insert, hij.symm, hj]
      simp [hi, hj, hjins]
