-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.inner_annih_left
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.SmCar



open Finset

variable {n : ℕ}


theorem BookProof.SmCar.inner_annih_left (i : Fin n) (ψ φ : FermiFock n) :
    (inner ℂ (annih i ψ) φ : ℂ) = inner ℂ ψ (creat i φ) := by sorry
