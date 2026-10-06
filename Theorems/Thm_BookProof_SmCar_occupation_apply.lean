-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.occupation_apply
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.SmCar

variable {n : ℕ}



open Finset


theorem BookProof.SmCar.occupation_apply (i : Fin n) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (creat i (annih i ψ)) S = if i ∈ S then ψ S else 0 := by sorry
