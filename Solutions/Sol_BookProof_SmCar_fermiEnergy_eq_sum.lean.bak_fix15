-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.fermiEnergy_eq_sum
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Theorems.Thm_BookProof_SmCar_fermiBilin_apply
open BookProof.SmCar




open Finset

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (m : Fin n → ℝ) (ψ : FermiFock n) :
    fermiEnergy m ψ = ∑ i : Fin n, (m i : ℂ) • creat i (annih i ψ) := by

  rw [fermiEnergy, fermiBilin_apply]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_eq_single i]
  · rw [Matrix.diagonal_apply_eq]
  · intro b _ hb
    rw [Matrix.diagonal_apply_ne _ (Ne.symm hb), zero_smul]
  · intro hi
    exact absurd (Finset.mem_univ i) hi
