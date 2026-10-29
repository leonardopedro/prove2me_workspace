-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.car_annih_creat_self
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Theorems.Thm_BookProof_SmCar_jwSign_mul_self
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterF1
open BookProof.SmCar




open Finset
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.ChapterF1

variable {n : ℕ}

variable {n : ℕ}

/-- Local unfolding of `annih` — the published bundle ships only the `def`. -/
theorem annih_eq (i : Fin n) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (annih i ψ).ofLp S = if i ∈ S then 0 else jwSign i S * ψ.ofLp (insert i S) := rfl

/-- Local unfolding of `creat` — the published bundle ships only the `def`. -/
theorem creat_eq (i : Fin n) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (creat i ψ).ofLp S = if i ∈ S then jwSign i (S.erase i) * ψ.ofLp (S.erase i) else 0 := rfl

set_option maxHeartbeats 1000000 in

theorem solution (i : Fin n) :
    BookProof.SmCar.annih i ∘ₗ BookProof.SmCar.creat i + BookProof.SmCar.creat i ∘ₗ BookProof.SmCar.annih i = LinearMap.id := by
  refine LinearMap.ext fun ψ => ?_
  ext S
  by_cases h : i ∈ S
  · have h1 : i ∉ S.erase i := Finset.notMem_erase i S
    have h2 : insert i (S.erase i) = S := Finset.insert_erase h
    simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.id_apply,
      PiLp.add_apply, annih_eq, creat_eq, if_pos h, if_neg h1, h2, zero_add]
    rw [← mul_assoc, jwSign_mul_self]
    ring
  · have h1 : i ∈ insert i S := Finset.mem_insert_self i S
    have h2 : (insert i S).erase i = S := Finset.erase_insert h
    simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.id_apply,
      PiLp.add_apply, annih_eq, creat_eq, if_neg h, if_pos h1, h2, add_zero]
    rw [← mul_assoc, jwSign_mul_self]
    ring
