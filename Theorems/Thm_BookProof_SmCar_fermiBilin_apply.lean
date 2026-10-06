-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.fermiBilin_apply
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.SmCar

variable {n : ℕ}



open Finset


theorem BookProof.SmCar.fermiBilin_apply (h : Matrix (Fin n) (Fin n) ℂ) (ψ : FermiFock n) :
    fermiBilin h ψ = ∑ i : Fin n, ∑ j : Fin n, h i j • creat i (annih j ψ) := by sorry
