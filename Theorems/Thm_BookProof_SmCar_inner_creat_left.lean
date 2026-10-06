-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.inner_creat_left
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.SmCar

variable {n : ℕ}



open Finset


theorem BookProof.SmCar.inner_creat_left (i : Fin n) (ψ φ : FermiFock n) :
    (inner ℂ (creat i ψ) φ : ℂ) = inner ℂ ψ (annih i φ) := by sorry
