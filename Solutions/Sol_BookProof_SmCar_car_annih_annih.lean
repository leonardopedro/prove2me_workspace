-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.car_annih_annih
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Theorems.Thm_BookProof_SmCar_jwSign_insert
open BookProof.SmCar




open Finset

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin n) :
    annih i ∘ₗ annih j + annih j ∘ₗ annih i = 0 := by

  refine LinearMap.ext fun ψ => ?_
  ext S
  rcases eq_or_ne i j with rfl | hij
  · by_cases h : i ∈ S
    · simp [h]
    · simp [h]
  · by_cases hi : i ∈ S
    · by_cases hj : j ∈ S
      · simp [hi, hj]
      · have h1 : i ∈ insert j S := Finset.mem_insert_of_mem hi
        simp [hi, hj, h1]
    · by_cases hj : j ∈ S
      · have h1 : j ∈ insert i S := Finset.mem_insert_of_mem hj
        simp [hi, hj, h1]
      · have hjS : j ∉ insert i S := by
          simp [Finset.mem_insert, hij.symm, hj]
        have hiS : i ∉ insert j S := by
          simp [Finset.mem_insert, hij, hi]
        have hcomm : insert j (insert i S) = insert i (insert j S) := Finset.insert_comm j i S
        have hsign1 : jwSign j (insert i S) = (if i < j then -1 else 1) * jwSign j S :=
          jwSign_insert hi
        have hsign2 : jwSign i (insert j S) = (if j < i then -1 else 1) * jwSign i S :=
          jwSign_insert hj
        have hlt : ¬ (i < j ∧ j < i) := fun ⟨h1, h2⟩ => absurd (h1.trans h2) (lt_irrefl i)
        have hne : i < j ∨ j < i := lt_or_gt_of_ne hij
        simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.zero_apply,
          PiLp.add_apply, PiLp.zero_apply, annih_apply, if_neg hi, if_neg hj, if_neg hjS,
          if_neg hiS, hsign1, hsign2, hcomm]
        rcases hne with hlt1 | hlt2
        · rw [if_pos hlt1, if_neg (asymm hlt1)]
          ring
        · rw [if_neg (asymm hlt2), if_pos hlt2]
          ring
