-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.norm_creat_le
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Theorems.Thm_BookProof_SmCar_normSq_eq_sum
open BookProof.SmCar




open Finset

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin n) (ψ : FermiFock n) : ‖creat i ψ‖ ≤ ‖ψ‖ := by

  have hsq : ‖creat i ψ‖ ^ 2 ≤ ‖ψ‖ ^ 2 := by
    rw [normSq_eq_sum, normSq_eq_sum]
    have hkey : ∑ S : Finset (Fin n), ‖(creat i ψ) S‖ ^ 2
        = ∑ S : Finset (Fin n), (if i ∈ S then 0 else ‖ψ S‖ ^ 2) := by
      rw [← Equiv.sum_comp (flipOcc i) (fun S => ‖(creat i ψ) S‖ ^ 2)]
      refine Finset.sum_congr rfl fun S _ => ?_
      by_cases h : i ∈ S
      · have h1 : i ∉ S.erase i := Finset.notMem_erase i S
        simp [h, h1]
      · have h1 : i ∈ insert i S := Finset.mem_insert_self i S
        have h2 : (insert i S).erase i = S := Finset.erase_insert h
        simp [h, h1, h2]
    rw [hkey]
    refine Finset.sum_le_sum fun S _ => ?_
    by_cases h : i ∈ S <;> simp [h]
  have h1 : (0:ℝ) ≤ ‖creat i ψ‖ := norm_nonneg _
  nlinarith [norm_nonneg ψ]
