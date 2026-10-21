-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.fermiBilin_apply
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar




open Finset

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (h : Matrix (Fin n) (Fin n) ℂ) (ψ : FermiFock n) :
    fermiBilin h ψ = ∑ i : Fin n, ∑ j : Fin n, h i j • creat i (annih j ψ) := by

  simp [fermiBilin, LinearMap.sum_apply]
