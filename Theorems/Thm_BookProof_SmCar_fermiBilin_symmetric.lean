-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.fermiBilin_symmetric
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.SmCar

variable {n : ℕ}



open Finset


theorem BookProof.SmCar.fermiBilin_symmetric {h : Matrix (Fin n) (Fin n) ℂ} (hh : h.conjTranspose = h)
    (ψ φ : FermiFock n) :
    (inner ℂ (fermiBilin h ψ) φ : ℂ) = inner ℂ ψ (fermiBilin h φ) := by sorry
