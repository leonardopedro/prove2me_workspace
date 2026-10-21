-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.norm_annih_le
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Theorems.Thm_BookProof_SmCar_normSq_eq_sum
open BookProof.SmCar




open Finset

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin n) (ψ : FermiFock n) : ‖annih i ψ‖ ≤ ‖ψ‖ := by

  have hsq : ‖annih i ψ‖ ^ 2 ≤ ‖ψ‖ ^ 2 := by
    rw [normSq_eq_sum, normSq_eq_sum]
    have hkey : ∑ S : Finset (Fin n), ‖(annih i ψ) S‖ ^ 2
        = ∑ S : Finset (Fin n), (if i ∈ S then ‖ψ S‖ ^ 2 else 0) := by
      rw [← Equiv.sum_comp (flipOcc i) (fun S => ‖(annih i ψ) S‖ ^ 2)]
      refine Finset.sum_congr rfl fun S _ => ?_
      by_cases h : i ∈ S
      · have h1 : i ∉ S.erase i := Finset.notMem_erase i S
        have h2 : insert i (S.erase i) = S := Finset.insert_erase h
        simp [h, h1, h2]
      · simp [h]
    rw [hkey]
    refine Finset.sum_le_sum fun S _ => ?_
    by_cases h : i ∈ S <;> simp [h]
  have h1 : (0:ℝ) ≤ ‖annih i ψ‖ := norm_nonneg _
  nlinarith [norm_nonneg ψ]
