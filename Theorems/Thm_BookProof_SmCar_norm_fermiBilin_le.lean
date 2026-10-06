-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.norm_fermiBilin_le
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.SmCar

variable {n : ℕ}



open Finset


theorem BookProof.SmCar.norm_fermiBilin_le (h : Matrix (Fin n) (Fin n) ℂ) (ψ : FermiFock n) :
    ‖fermiBilin h ψ‖ ≤ (∑ i : Fin n, ∑ j : Fin n, ‖h i j‖) * ‖ψ‖ := by sorry
