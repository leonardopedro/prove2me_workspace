-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.norm_creat_le
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Theorems.Thm_BookProof_SmCar_normSq_eq_sum
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.SmCar




open Finset
open BookProof.NavierStokesFlow.FockOfFock

variable {n : ℕ}

variable {n : ℕ}

private theorem creat_apply (i : Fin n) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (creat i ψ) S = if i ∈ S then jwSign i (S.erase i) * ψ (S.erase i) else 0 := rfl

private theorem flipOcc_apply (i : Fin n) (S : Finset (Fin n)) :
    flipOcc i S = if i ∈ S then S.erase i else insert i S := rfl

private theorem norm_jwSign (i : Fin n) (S : Finset (Fin n)) : ‖jwSign i S‖ = 1 := by
  simp [jwSign]

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
        simp [h, h1, flipOcc_apply, creat_apply]
      · have h1 : i ∈ insert i S := Finset.mem_insert_self i S
        have h2 : (insert i S).erase i = S := Finset.erase_insert h
        simp [h, h1, h2, flipOcc_apply, creat_apply, norm_jwSign]
    rw [hkey]
    refine Finset.sum_le_sum fun S _ => ?_
    by_cases h : i ∈ S <;> simp [h]
  have h1 : (0:ℝ) ≤ ‖creat i ψ‖ := norm_nonneg _
  nlinarith [norm_nonneg ψ]
