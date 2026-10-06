-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.inner_creat_left
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Theorems.Thm_BookProof_SmCar_inner_eq_sum
import Theorems.Thm_BookProof_QuantumGravityFock_conj_jwSign
open BookProof.SmCar




open Finset

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin n) (ψ φ : FermiFock n) :
    (inner ℂ (creat i ψ) φ : ℂ) = inner ℂ ψ (annih i φ) := by

  rw [inner_eq_sum, inner_eq_sum]
  rw [← Equiv.sum_comp (flipOcc i)
    (fun R => (starRingEnd ℂ) (ψ R) * (annih i φ) R)]
  refine Finset.sum_congr rfl fun S _ => ?_
  by_cases h : i ∈ S
  · have h1 : i ∉ S.erase i := Finset.notMem_erase i S
    have h2 : insert i (S.erase i) = S := Finset.insert_erase h
    simp only [creat_apply, annih_apply, flipOcc_apply, if_pos h, if_neg h1, h2, map_mul,
      conj_jwSign]
    ring
  · have h1 : i ∈ insert i S := Finset.mem_insert_self i S
    simp only [creat_apply, annih_apply, flipOcc_apply, if_neg h, if_pos h1, map_zero,
      zero_mul, mul_zero]
