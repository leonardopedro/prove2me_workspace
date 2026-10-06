-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.car_annih_creat_self
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Theorems.Thm_BookProof_SmCar_jwSign_mul_self
open BookProof.SmCar




open Finset

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin n) :
    annih i ∘ₗ creat i + creat i ∘ₗ annih i = LinearMap.id := by

  refine LinearMap.ext fun ψ => ?_
  ext S
  by_cases h : i ∈ S
  · have h1 : i ∉ S.erase i := Finset.notMem_erase i S
    have h2 : insert i (S.erase i) = S := Finset.insert_erase h
    simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.id_apply,
      PiLp.add_apply, annih_apply, creat_apply, if_pos h, if_neg h1, h2, zero_add]
    rw [← mul_assoc, jwSign_mul_self]
    ring
  · have h1 : i ∈ insert i S := Finset.mem_insert_self i S
    have h2 : (insert i S).erase i = S := Finset.erase_insert h
    simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.id_apply,
      PiLp.add_apply, annih_apply, creat_apply, if_neg h, if_pos h1, h2, add_zero]
    rw [← mul_assoc, jwSign_mul_self]
    ring
