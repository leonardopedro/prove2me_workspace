-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.fermiEnergy_occ
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Theorems.Thm_BookProof_SmCar_fermiEnergy_apply
open BookProof.SmCar




open Finset

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (m : Fin n → ℝ) (S : Finset (Fin n)) :
    fermiEnergy m (occ S) = ((∑ i ∈ S, m i : ℝ) : ℂ) • occ S := by

  ext T
  rw [fermiEnergy_apply]
  by_cases h : T = S
  · subst h; simp [occ]
  · simp [occ, EuclideanSpace.single_apply, h]
