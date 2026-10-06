-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.fermiEnergy_apply
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Theorems.Thm_BookProof_SmCar_sum_apply_fock
import Theorems.Thm_BookProof_SmCar_smul_apply_fock
import Theorems.Thm_BookProof_SmCar_occupation_apply
import Theorems.Thm_BookProof_SmCar_fermiEnergy_eq_sum
open BookProof.SmCar




open Finset

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (m : Fin n → ℝ) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (fermiEnergy m ψ) S = ((∑ i ∈ S, m i : ℝ) : ℂ) * ψ S := by

  rw [fermiEnergy_eq_sum]
  have hsum : (∑ i : Fin n, (m i : ℂ) • creat i (annih i ψ)) S
      = ∑ i : Fin n, ((m i : ℂ) * (if i ∈ S then ψ S else 0)) := by
    rw [sum_apply_fock]
    exact Finset.sum_congr rfl fun i _ => by
      rw [smul_apply_fock, occupation_apply]
  rw [hsum]
  rw [Finset.sum_congr rfl (fun i (_ : i ∈ Finset.univ) =>
    show (m i : ℂ) * (if i ∈ S then ψ S else 0)
      = (if i ∈ S then (m i : ℂ) else 0) * ψ S by split <;> ring)]
  rw [← Finset.sum_mul]
  congr 1
  rw [Finset.sum_ite_mem, Finset.univ_inter, Complex.ofReal_sum]
